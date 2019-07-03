#pragma once

#include <clientsdk/ClientApp.hpp>
#include <clientsdk/ClientAppConfig.hpp>
#include <clientsdk/ClientAppExitCode.hpp>
#include <clientsdk/ClientAppObserver.hpp>
#include <clientsdk/ClientRegistrationData.hpp>
#include <clientsdk/ClientRegisterFailureCode.hpp>
#include <clientsdk/ClientLoginFailureCode.hpp>
#include <clientsdk/ClientKeyPair.hpp>
#include <clientsdk/ClientNetworkStatus.hpp>
#include <clientsdk/ClientRegisterHandler.hpp>
#include <clientsdk/ClientLoginHandler.hpp>
#include <clientsdk/ClientChannelHandler.hpp>
#include <clientsdk/ClientBootstrapNode.hpp>

#include <MiddlewareSDK.hpp>


namespace clientsdk {

    using namespace peerstream::client;


    class ClientAppInternal: public clientsdk::ClientApp {

    private:
        using ConnectionPtr = peerstream::core::signals::ConnectionPtr;
        using ConnectionPtrList = peerstream::core::signals::ConnectionPtrList;

        using ChannelPtr = IClientApp::ChannelPtr;
        using KeyPair = IClientApp::KeyPair;

        using AppExitCode = peerstream::client::AppExitCode;

        using OnApplicationReady = IClientApp::OnApplicationReady;
        using OnApplicationExit = IClientApp::OnApplicationExit;
        using OnChannelRequested = IClientApp::OnChannelRequested;
        using OnNetworkStatus = IClientApp::OnNetworkStatus;


        std::unique_ptr<IClientApp> m_client;
        std::shared_ptr<ClientAppObserver> m_observer;

        ConnectionPtrList connections_;

        void onApplicationReady();
        void onApplicationExit(const AppExitCode &code);
        void onChannelRequested(std::string userId);
        void onNetworkStatus(NetworkStatus status);
        void onUserPresenceChange(const std::string& identity, bool isOnline);

    public:
        // constructor
        ClientAppInternal(const ClientAppConfig & config,
                          const std::shared_ptr<ClientAppObserver> & observer);

        void start();

        void stop();

        void setMinLogLevel(ClientLogLevel level);

        void registerUser(const std::shared_ptr<ClientRegisterHandler> &handler);

        void login(const ClientRegistrationData &userData,
                   const std::shared_ptr<ClientLoginHandler> &handler);

        std::string getIdentity();

        std::shared_ptr<VideoStreamer> getVideoStreamer();

        void createChannel(const std::string &userId,
                           ClientChannelSecurity security,
                           const std::shared_ptr<ClientChannelHandler> &handler);

        void confirmChannel(const std::string &userId,
                            ClientChannelSecurity security,
                            const std::shared_ptr<ClientChannelHandler> &handler);

        void denyChannel(const std::string &userId);

        void registerUserPresenceChange(const std::string &userId);
        void unregisterUserPresenceChange(const std::string &userId);
    };

}  // namespace clientsdk
