// AUTOGENERATED FILE - DO NOT MODIFY!
// This file generated by Djinni from VideoStreamer.djinni

#import "PSPVideoStreamerObserver+Private.h"
#import "PSPVideoStreamerObserver.h"
#import "DJIMarshal+Private.h"
#import "DJIObjcWrapperCache+Private.h"
#import "PSPVideoFrameOrientation+Private.h"
#include <stdexcept>

static_assert(__has_feature(objc_arc), "Djinni requires ARC to be enabled for this file");

namespace djinni_generated {

class VideoStreamerObserver::ObjcProxy final
: public ::clientsdk::VideoStreamerObserver
, private ::djinni::ObjcProxyBase<ObjcType>
{
    friend class ::djinni_generated::VideoStreamerObserver;
public:
    using ObjcProxyBase::ObjcProxyBase;
    void onVideoStreamDisplayFrameReceived(const std::string & c_streamId, const std::vector<uint8_t> & c_buffer, int32_t c_width, int32_t c_height, ::clientsdk::VideoFrameOrientation c_orientation) override
    {
        @autoreleasepool {
            [djinni_private_get_proxied_objc_object() onVideoStreamDisplayFrameReceived:(::djinni::String::fromCpp(c_streamId))
                                                                                 buffer:(::djinni::Binary::fromCpp(c_buffer))
                                                                                  width:(::djinni::I32::fromCpp(c_width))
                                                                                 height:(::djinni::I32::fromCpp(c_height))
                                                                            orientation:(::djinni::Enum<::clientsdk::VideoFrameOrientation, PSPVideoFrameOrientation>::fromCpp(c_orientation))];
        }
    }
    void onVideoStreamDestroyed(const std::string & c_streamId) override
    {
        @autoreleasepool {
            [djinni_private_get_proxied_objc_object() onVideoStreamDestroyed:(::djinni::String::fromCpp(c_streamId))];
        }
    }
};

}  // namespace djinni_generated

namespace djinni_generated {

auto VideoStreamerObserver::toCpp(ObjcType objc) -> CppType
{
    if (!objc) {
        return nullptr;
    }
    return ::djinni::get_objc_proxy<ObjcProxy>(objc);
}

auto VideoStreamerObserver::fromCppOpt(const CppOptType& cpp) -> ObjcType
{
    if (!cpp) {
        return nil;
    }
    return dynamic_cast<ObjcProxy&>(*cpp).djinni_private_get_proxied_objc_object();
}

}  // namespace djinni_generated
