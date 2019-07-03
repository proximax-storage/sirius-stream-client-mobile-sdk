
#include "ClientAppInternal.hpp"
#include "ChannelInternal.hpp"
#include "VideoStreamerInternal.hpp"

#include <functional>
#include <iostream>


namespace clientsdk {

    using namespace std;

    static constexpr const auto _1 = placeholders::_1;


    shared_ptr<ClientApp> ClientApp::create(const ClientAppConfig & config,
                                            const shared_ptr<ClientAppObserver> & observer)
    {
        return make_shared<ClientAppInternal>(config, observer);
    }

    ClientAppInternal::ClientAppInternal(const ClientAppConfig & config,
                                         const shared_ptr<ClientAppObserver> & observer)
    {
        connections_.clear();

        SDKInitializationParameters p {
            .appIdentityNamespace = config.nameSpace,
            .appIdentitySubNamespace = config.subNameSpace,
            .bootstrapNodes =
            vector<BootstrapNode>{
                BootstrapNode{
                    .mode = config.node.mode,
                    .handshakeKey = config.node.handshakeKey,
                    .fingerprint = config.node.fingerprint,
                    .identity = config.node.identity,
                    .addresses = vector<string>{config.node.address}
                },
            },
        };
        auto params = make_optional<SDKInitializationParameters>(p);
        m_client = peerstream::client::createClientApp(move(params));


        // callback handlers:
        if (observer) {
            m_observer = observer;

            connections_.push_back(m_client->registerApplicationReady(bind(&ClientAppInternal::onApplicationReady, this)));
            connections_.push_back(m_client->registerApplicationExit(bind(&ClientAppInternal::onApplicationExit, this, _1)));
            connections_.push_back(m_client->registerChannelRequested(bind(&ClientAppInternal::onChannelRequested, this, _1)));
            connections_.push_back(m_client->registerNetworkStatus(bind(&ClientAppInternal::onNetworkStatus, this, _1)));
        }
    }
    

    void ClientAppInternal::start() {
        if (m_client) {
            m_client->start();
        }
    }

    void ClientAppInternal::stop() {
        if (m_client) {
            m_client->stop();

            // clearing out any active handlers
            connections_.clear();
        }
    }

    void ClientAppInternal::setMinLogLevel(ClientLogLevel level) {
        if (m_client) {
            m_client->setMinLogLevel(LogLevel(level));
        }
    }

    void ClientAppInternal::registerUser(const shared_ptr<ClientRegisterHandler> &handler) {
        if (m_client) {
            m_client->registerUser([this, handler] (UserRegistrationData userData) {
                ClientRegistrationData data = ClientRegistrationData(userData.identity,
                                                                     userData.signingSecKey,
                                                                     userData.cert);
                handler->onRegisterSuccess(getIdentity(), data);
            }, [this, handler] (RegisterFailureCode failureCode) {
                ClientRegisterFailureCode code = ClientRegisterFailureCode(failureCode);
                handler->onRegisterFailure(getIdentity(), code);
            });
        }
    }

    void ClientAppInternal::login(const ClientRegistrationData &userData,
                                  const shared_ptr<ClientLoginHandler> &handler)
    {
        if (m_client) {
            UserRegistrationData data {
                .identity = userData.identity,
                .signingSecKey = userData.secretKey,
                .cert = userData.certificate
            };

            m_client->login(move(data), [this, handler] (string response, optional<UserRegistrationData> data) {
                optional<ClientRegistrationData> newData;
                if (data) {
                    newData = ClientRegistrationData(data->identity,
                                                     data->signingSecKey,
                                                     data->cert);
                }
                handler->onLoginSuccess(getIdentity(), response, newData);

            }, [this, handler] (LoginFailureCode failureCode) {
                ClientLoginFailureCode code = ClientLoginFailureCode(failureCode);
                handler->onLoginFailure(getIdentity(), code);
            });
        }
    }

    string ClientAppInternal::getIdentity() {
        if (m_client) {
            return m_client->identity();
        }
        return "";
    }

    shared_ptr<VideoStreamer> ClientAppInternal::getVideoStreamer() {
        if (m_client) {
            shared_ptr<VideoStreamer> vidStreamer = make_shared<VideoStreamerInternal>(m_client->videoStreamer());
            return vidStreamer;
        }
        return nullptr;
    }

//    ClientKeyPair ClientAppInternal::generateKeyPair() {
//        if (m_client) {
//            KeyPair pair = m_client->generateKeyPair();
//            return ClientKeyPair(pair.publicKey, pair.privateKey);
//        }
//        return ClientKeyPair("", "");
//    }

    void ClientAppInternal::createChannel(const string &userId,
                                          ClientChannelSecurity security,
                                          const shared_ptr<ClientChannelHandler> &handler)
    {
        if (m_client) {
            cout << ">> [ClientAppInternal] Creating a channel with ID: " << userId << endl;
            m_client->createChannel(userId, [this, handler] (ChannelPtr ch) {
                shared_ptr<Channel> channel = make_shared<ChannelInternal>(ch);
                if (channel) {
                    cout << ">> [ClientAppInternal] Channel create success: " << channel->getIdentity() << endl;
                    if (handler) {
                        handler->onChannelConfirmed(getIdentity(), channel);
                    }
                }
            }, [this, handler] (ChannelRequestErrorID errorId) {
                cout << ">> [ClientAppInternal] Channel create failed with errorId: " << (uint8_t)errorId << endl;
                if (handler) {
                    ChannelRequestErrorId eid = ChannelRequestErrorId(errorId);
                    handler->onChannelResponseError(getIdentity(), eid);
                }
            }, ChannelSecurity(security));
        }
    }

    void ClientAppInternal::confirmChannel(const string &userId,
                                           ClientChannelSecurity security,
                                           const shared_ptr<ClientChannelHandler> &handler)
    {
        if (m_client) {
            cout << ">> [ClientAppInternal] Confirming a channel with ID: " << userId << endl;
            m_client->confirmChannel(userId, [this, handler](ChannelPtr ch) {
                shared_ptr<Channel> channel = make_shared<ChannelInternal>(ch);
                if (channel) {
                    cout << ">> [ClientAppInternal] Channel confirm success: " << channel->getIdentity() << endl;
                    if (handler) {
                        handler->onChannelConfirmed(getIdentity(), channel);
                    }
                }
            }, [this, handler](ChannelRequestErrorID errorId) {
                cout << ">> [ClientAppInternal] Channel confirm failed with errorId: " << (uint8_t)errorId << endl;
                if (handler) {
                    ChannelRequestErrorId eid = ChannelRequestErrorId(errorId);
                    handler->onChannelResponseError(getIdentity(), eid);
                }
            }, ChannelSecurity(security));
        }
    }
    
    void ClientAppInternal::denyChannel(const string &userId) {
        if (m_client) {
            m_client->denyChannel(userId);
        }
    }

    void ClientAppInternal::registerUserPresenceChange(const string &userId)
    {
        if (m_client) {
            connections_.push_back(m_client->registerUserPresenceChange(userId, bind(&ClientAppInternal::onUserPresenceChange, this, userId, _1)));
        }
    }

    void ClientAppInternal::unregisterUserPresenceChange(const string &userId)
    {
        // FIXME:
    }


    /*
     * Registered callbacks
     */
    void ClientAppInternal::onApplicationReady() {
        if (m_observer) {
            m_observer->onApplicationReady(getIdentity());
        };
    }

    void ClientAppInternal::onApplicationExit(const AppExitCode &code) {
        if (m_observer) {
            ClientAppExitCode exitCode = ClientAppExitCode(code);
            m_observer->onApplicationExit(exitCode);
        }
    }

    void ClientAppInternal::onChannelRequested(string userId) {
        if (m_observer) {
            m_observer->onChannelRequested(getIdentity(), userId);
        }
    }

    void ClientAppInternal::onNetworkStatus(NetworkStatus status) {
        if (m_observer) {
            ClientNetworkStatus netStatus = ClientNetworkStatus(status.networkConnectivity,
                                                                status.numEntryNodesConnected);
            m_observer->onNetworkStatus(getIdentity(), netStatus);
        }
    }

    void ClientAppInternal::onUserPresenceChange(const string &userId, bool isActive) {
        if (m_observer) {
            m_observer->onUserPresenceChange(getIdentity(), userId, isActive);
        }
    }
}
