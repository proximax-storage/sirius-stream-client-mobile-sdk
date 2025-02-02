// AUTOGENERATED FILE - DO NOT MODIFY!
// This file generated by Djinni from ClientApp.djinni

#pragma once

#include "ClientNetworkStatus.hpp"
#include "djinni_support.hpp"

namespace djinni_generated {

class NativeClientNetworkStatus final {
public:
    using CppType = ::clientsdk::ClientNetworkStatus;
    using JniType = jobject;

    using Boxed = NativeClientNetworkStatus;

    ~NativeClientNetworkStatus();

    static CppType toCpp(JNIEnv* jniEnv, JniType j);
    static ::djinni::LocalRef<JniType> fromCpp(JNIEnv* jniEnv, const CppType& c);

private:
    NativeClientNetworkStatus();
    friend ::djinni::JniClass<NativeClientNetworkStatus>;

    const ::djinni::GlobalRef<jclass> clazz { ::djinni::jniFindClass("com/peerstream/psp/sdk/bridge/ClientNetworkStatus") };
    const jmethodID jconstructor { ::djinni::jniGetMethodID(clazz.get(), "<init>", "(FJ)V") };
    const jfieldID field_mNetworkConnectivity { ::djinni::jniGetFieldID(clazz.get(), "mNetworkConnectivity", "F") };
    const jfieldID field_mNumEntryNodesConnected { ::djinni::jniGetFieldID(clazz.get(), "mNumEntryNodesConnected", "J") };
};

}  // namespace djinni_generated
