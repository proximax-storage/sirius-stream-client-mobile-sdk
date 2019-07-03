// AUTOGENERATED FILE - DO NOT MODIFY!
// This file generated by Djinni from Channel.djinni

#pragma once

#include "ChannelErrorId.hpp"
#include "djinni_support.hpp"

namespace djinni_generated {

class NativeChannelErrorId final : ::djinni::JniEnum {
public:
    using CppType = ::clientsdk::ChannelErrorId;
    using JniType = jobject;

    using Boxed = NativeChannelErrorId;

    static CppType toCpp(JNIEnv* jniEnv, JniType j) { return static_cast<CppType>(::djinni::JniClass<NativeChannelErrorId>::get().ordinal(jniEnv, j)); }
    static ::djinni::LocalRef<JniType> fromCpp(JNIEnv* jniEnv, CppType c) { return ::djinni::JniClass<NativeChannelErrorId>::get().create(jniEnv, static_cast<jint>(c)); }

private:
    NativeChannelErrorId() : JniEnum("com/peerstream/psp/sdk/bridge/ChannelErrorId") {}
    friend ::djinni::JniClass<NativeChannelErrorId>;
};

}  // namespace djinni_generated
