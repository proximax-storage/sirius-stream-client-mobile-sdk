// AUTOGENERATED FILE - DO NOT MODIFY!
// This file generated by Djinni from Channel.djinni

#include "NativeChannelStreamHandler.hpp"  // my header
#include "Marshal.hpp"
#include "NativeVideoStreamErrorId.hpp"

namespace djinni_generated {

NativeChannelStreamHandler::NativeChannelStreamHandler() : ::djinni::JniInterface<::clientsdk::ChannelStreamHandler, NativeChannelStreamHandler>() {}

NativeChannelStreamHandler::~NativeChannelStreamHandler() = default;

NativeChannelStreamHandler::JavaProxy::JavaProxy(JniType j) : Handle(::djinni::jniGetThreadEnv(), j) { }

NativeChannelStreamHandler::JavaProxy::~JavaProxy() = default;

void NativeChannelStreamHandler::JavaProxy::onStreamCreated(const std::string & c_channelId, const std::string & c_streamId) {
    auto jniEnv = ::djinni::jniGetThreadEnv();
    ::djinni::JniLocalScope jscope(jniEnv, 10);
    const auto& data = ::djinni::JniClass<::djinni_generated::NativeChannelStreamHandler>::get();
    jniEnv->CallVoidMethod(Handle::get().get(), data.method_onStreamCreated,
                           ::djinni::get(::djinni::String::fromCpp(jniEnv, c_channelId)),
                           ::djinni::get(::djinni::String::fromCpp(jniEnv, c_streamId)));
    ::djinni::jniExceptionCheck(jniEnv);
}
void NativeChannelStreamHandler::JavaProxy::onStreamError(const std::string & c_channelId, ::clientsdk::VideoStreamErrorId c_errorId) {
    auto jniEnv = ::djinni::jniGetThreadEnv();
    ::djinni::JniLocalScope jscope(jniEnv, 10);
    const auto& data = ::djinni::JniClass<::djinni_generated::NativeChannelStreamHandler>::get();
    jniEnv->CallVoidMethod(Handle::get().get(), data.method_onStreamError,
                           ::djinni::get(::djinni::String::fromCpp(jniEnv, c_channelId)),
                           ::djinni::get(::djinni_generated::NativeVideoStreamErrorId::fromCpp(jniEnv, c_errorId)));
    ::djinni::jniExceptionCheck(jniEnv);
}

}  // namespace djinni_generated
