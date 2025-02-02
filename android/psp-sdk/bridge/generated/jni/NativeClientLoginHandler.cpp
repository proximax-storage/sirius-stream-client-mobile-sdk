// AUTOGENERATED FILE - DO NOT MODIFY!
// This file generated by Djinni from ClientApp.djinni

#include "NativeClientLoginHandler.hpp"  // my header
#include "Marshal.hpp"
#include "NativeClientLoginFailureCode.hpp"
#include "NativeClientRegistrationData.hpp"

namespace djinni_generated {

NativeClientLoginHandler::NativeClientLoginHandler() : ::djinni::JniInterface<::clientsdk::ClientLoginHandler, NativeClientLoginHandler>() {}

NativeClientLoginHandler::~NativeClientLoginHandler() = default;

NativeClientLoginHandler::JavaProxy::JavaProxy(JniType j) : Handle(::djinni::jniGetThreadEnv(), j) { }

NativeClientLoginHandler::JavaProxy::~JavaProxy() = default;

void NativeClientLoginHandler::JavaProxy::onLoginSuccess(const std::string & c_clientId, const std::string & c_response, const std::optional<::clientsdk::ClientRegistrationData> & c_data) {
    auto jniEnv = ::djinni::jniGetThreadEnv();
    ::djinni::JniLocalScope jscope(jniEnv, 10);
    const auto& data = ::djinni::JniClass<::djinni_generated::NativeClientLoginHandler>::get();
    jniEnv->CallVoidMethod(Handle::get().get(), data.method_onLoginSuccess,
                           ::djinni::get(::djinni::String::fromCpp(jniEnv, c_clientId)),
                           ::djinni::get(::djinni::String::fromCpp(jniEnv, c_response)),
                           ::djinni::get(::djinni::Optional<std::optional, ::djinni_generated::NativeClientRegistrationData>::fromCpp(jniEnv, c_data)));
    ::djinni::jniExceptionCheck(jniEnv);
}
void NativeClientLoginHandler::JavaProxy::onLoginFailure(const std::string & c_clientId, ::clientsdk::ClientLoginFailureCode c_code) {
    auto jniEnv = ::djinni::jniGetThreadEnv();
    ::djinni::JniLocalScope jscope(jniEnv, 10);
    const auto& data = ::djinni::JniClass<::djinni_generated::NativeClientLoginHandler>::get();
    jniEnv->CallVoidMethod(Handle::get().get(), data.method_onLoginFailure,
                           ::djinni::get(::djinni::String::fromCpp(jniEnv, c_clientId)),
                           ::djinni::get(::djinni_generated::NativeClientLoginFailureCode::fromCpp(jniEnv, c_code)));
    ::djinni::jniExceptionCheck(jniEnv);
}

}  // namespace djinni_generated
