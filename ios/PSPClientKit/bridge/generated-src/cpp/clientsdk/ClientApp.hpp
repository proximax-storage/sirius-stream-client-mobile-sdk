// AUTOGENERATED FILE - DO NOT MODIFY!
// This file generated by Djinni from ClientApp.djinni

#pragma once

#include <memory>
#include <string>

namespace clientsdk {

class ClientAppObserver;
class ClientChannelHandler;
class ClientLoginHandler;
class ClientRegisterHandler;
class VideoStreamer;
enum class ClientChannelSecurity;
enum class ClientLogLevel;
struct ClientAppConfig;
struct ClientRegistrationData;

class ClientApp {
public:
    virtual ~ClientApp() {}

    static std::shared_ptr<ClientApp> create(const ClientAppConfig & config, const std::shared_ptr<ClientAppObserver> & observer);

    virtual void start() = 0;

    virtual void stop() = 0;

    virtual void setMinLogLevel(ClientLogLevel level) = 0;

    virtual void registerUser(const std::shared_ptr<ClientRegisterHandler> & handler) = 0;

    virtual void login(const ClientRegistrationData & userData, const std::shared_ptr<ClientLoginHandler> & handler) = 0;

    virtual std::string getIdentity() = 0;

    virtual std::shared_ptr<VideoStreamer> getVideoStreamer() = 0;

    virtual void createChannel(const std::string & userId, ClientChannelSecurity security, const std::shared_ptr<ClientChannelHandler> & handler) = 0;

    virtual void confirmChannel(const std::string & userId, ClientChannelSecurity security, const std::shared_ptr<ClientChannelHandler> & handler) = 0;

    virtual void denyChannel(const std::string & userId) = 0;

    virtual void registerUserPresenceChange(const std::string & userId) = 0;

    virtual void unregisterUserPresenceChange(const std::string & userId) = 0;
};

}  // namespace clientsdk
