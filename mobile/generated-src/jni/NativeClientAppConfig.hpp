// AUTOGENERATED FILE - DO NOT MODIFY!
// This file generated by Djinni from ClientApp.djinni

#pragma once

#include "ClientAppConfig.hpp"
#include "djinni_support.hpp"

namespace djinni_generated {

class NativeClientAppConfig final {
public:
    using CppType = ::clientsdk::ClientAppConfig;
    using JniType = jobject;

    using Boxed = NativeClientAppConfig;

    ~NativeClientAppConfig();

    static CppType toCpp(JNIEnv* jniEnv, JniType j);
    static ::djinni::LocalRef<JniType> fromCpp(JNIEnv* jniEnv, const CppType& c);

private:
    NativeClientAppConfig();
    friend ::djinni::JniClass<NativeClientAppConfig>;

    const ::djinni::GlobalRef<jclass> clazz { ::djinni::jniFindClass("com/peerstream/psp/sdk/bridge/ClientAppConfig") };
    const jmethodID jconstructor { ::djinni::jniGetMethodID(clazz.get(), "<init>", "(Ljava/lang/String;Ljava/lang/String;Lcom/peerstream/psp/sdk/bridge/ClientBootstrapNode;)V") };
    const jfieldID field_mNameSpace { ::djinni::jniGetFieldID(clazz.get(), "mNameSpace", "Ljava/lang/String;") };
    const jfieldID field_mSubNameSpace { ::djinni::jniGetFieldID(clazz.get(), "mSubNameSpace", "Ljava/lang/String;") };
    const jfieldID field_mNode { ::djinni::jniGetFieldID(clazz.get(), "mNode", "Lcom/peerstream/psp/sdk/bridge/ClientBootstrapNode;") };
};

}  // namespace djinni_generated
