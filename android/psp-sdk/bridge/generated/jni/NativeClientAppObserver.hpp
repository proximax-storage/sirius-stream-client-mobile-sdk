// AUTOGENERATED FILE - DO NOT MODIFY!
// This file generated by Djinni from ClientApp.djinni

#pragma once

#include "ClientAppObserver.hpp"
#include "djinni_support.hpp"

namespace djinni_generated {

class NativeClientAppObserver final : ::djinni::JniInterface<::clientsdk::ClientAppObserver, NativeClientAppObserver> {
public:
    using CppType = std::shared_ptr<::clientsdk::ClientAppObserver>;
    using CppOptType = std::shared_ptr<::clientsdk::ClientAppObserver>;
    using JniType = jobject;

    using Boxed = NativeClientAppObserver;

    ~NativeClientAppObserver();

    static CppType toCpp(JNIEnv* jniEnv, JniType j) { return ::djinni::JniClass<NativeClientAppObserver>::get()._fromJava(jniEnv, j); }
    static ::djinni::LocalRef<JniType> fromCppOpt(JNIEnv* jniEnv, const CppOptType& c) { return {jniEnv, ::djinni::JniClass<NativeClientAppObserver>::get()._toJava(jniEnv, c)}; }
    static ::djinni::LocalRef<JniType> fromCpp(JNIEnv* jniEnv, const CppType& c) { return fromCppOpt(jniEnv, c); }

private:
    NativeClientAppObserver();
    friend ::djinni::JniClass<NativeClientAppObserver>;
    friend ::djinni::JniInterface<::clientsdk::ClientAppObserver, NativeClientAppObserver>;

    class JavaProxy final : ::djinni::JavaProxyHandle<JavaProxy>, public ::clientsdk::ClientAppObserver
    {
    public:
        JavaProxy(JniType j);
        ~JavaProxy();

        void onApplicationReady(const std::string & clientId) override;
        void onApplicationExit(::clientsdk::ClientAppExitCode code) override;
        void onChannelRequested(const std::string & clientId, const std::string & userId) override;
        void onNetworkStatus(const std::string & clientId, const ::clientsdk::ClientNetworkStatus & status) override;
        void onUserPresenceChange(const std::string & clientId, const std::string & userId, bool isActive) override;

    private:
        friend ::djinni::JniInterface<::clientsdk::ClientAppObserver, ::djinni_generated::NativeClientAppObserver>;
    };

    const ::djinni::GlobalRef<jclass> clazz { ::djinni::jniFindClass("com/peerstream/psp/sdk/bridge/ClientAppObserver") };
    const jmethodID method_onApplicationReady { ::djinni::jniGetMethodID(clazz.get(), "onApplicationReady", "(Ljava/lang/String;)V") };
    const jmethodID method_onApplicationExit { ::djinni::jniGetMethodID(clazz.get(), "onApplicationExit", "(Lcom/peerstream/psp/sdk/bridge/ClientAppExitCode;)V") };
    const jmethodID method_onChannelRequested { ::djinni::jniGetMethodID(clazz.get(), "onChannelRequested", "(Ljava/lang/String;Ljava/lang/String;)V") };
    const jmethodID method_onNetworkStatus { ::djinni::jniGetMethodID(clazz.get(), "onNetworkStatus", "(Ljava/lang/String;Lcom/peerstream/psp/sdk/bridge/ClientNetworkStatus;)V") };
    const jmethodID method_onUserPresenceChange { ::djinni::jniGetMethodID(clazz.get(), "onUserPresenceChange", "(Ljava/lang/String;Ljava/lang/String;Z)V") };
};

}  // namespace djinni_generated
