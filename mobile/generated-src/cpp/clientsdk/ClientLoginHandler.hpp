// AUTOGENERATED FILE - DO NOT MODIFY!
// This file generated by Djinni from ClientApp.djinni

#pragma once

#include <optional>
#include <string>

namespace clientsdk {

enum class ClientLoginFailureCode;
struct ClientRegistrationData;

class ClientLoginHandler {
public:
    virtual ~ClientLoginHandler() {}

    virtual void onLoginSuccess(const std::string & clientId, const std::string & response, const std::optional<ClientRegistrationData> & data) = 0;

    virtual void onLoginFailure(const std::string & clientId, ClientLoginFailureCode code) = 0;
};

}  // namespace clientsdk
