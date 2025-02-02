// AUTOGENERATED FILE - DO NOT MODIFY!
// This file generated by Djinni from VideoStreamer.djinni

#import "PSPVideoStreamRequestHandler+Private.h"
#import "PSPVideoStreamRequestHandler.h"
#import "DJIMarshal+Private.h"
#import "DJIObjcWrapperCache+Private.h"
#import "PSPVideoStreamErrorId+Private.h"
#include <stdexcept>

static_assert(__has_feature(objc_arc), "Djinni requires ARC to be enabled for this file");

namespace djinni_generated {

class VideoStreamRequestHandler::ObjcProxy final
: public ::clientsdk::VideoStreamRequestHandler
, private ::djinni::ObjcProxyBase<ObjcType>
{
    friend class ::djinni_generated::VideoStreamRequestHandler;
public:
    using ObjcProxyBase::ObjcProxyBase;
    void onVideoStreamStarted(const std::string & c_streamId) override
    {
        @autoreleasepool {
            [djinni_private_get_proxied_objc_object() onVideoStreamStarted:(::djinni::String::fromCpp(c_streamId))];
        }
    }
    void onVideoStreamError(::clientsdk::VideoStreamErrorId c_errorId) override
    {
        @autoreleasepool {
            [djinni_private_get_proxied_objc_object() onVideoStreamError:(::djinni::Enum<::clientsdk::VideoStreamErrorId, PSPVideoStreamErrorId>::fromCpp(c_errorId))];
        }
    }
};

}  // namespace djinni_generated

namespace djinni_generated {

auto VideoStreamRequestHandler::toCpp(ObjcType objc) -> CppType
{
    if (!objc) {
        return nullptr;
    }
    return ::djinni::get_objc_proxy<ObjcProxy>(objc);
}

auto VideoStreamRequestHandler::fromCppOpt(const CppOptType& cpp) -> ObjcType
{
    if (!cpp) {
        return nil;
    }
    return dynamic_cast<ObjcProxy&>(*cpp).djinni_private_get_proxied_objc_object();
}

}  // namespace djinni_generated
