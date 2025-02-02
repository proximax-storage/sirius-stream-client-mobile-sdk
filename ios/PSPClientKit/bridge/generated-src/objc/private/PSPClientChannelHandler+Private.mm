// AUTOGENERATED FILE - DO NOT MODIFY!
// This file generated by Djinni from ClientApp.djinni

#import "PSPClientChannelHandler+Private.h"
#import "PSPClientChannelHandler.h"
#import "DJIMarshal+Private.h"
#import "DJIObjcWrapperCache+Private.h"
#import "PSPChannel+Private.h"
#import "PSPChannelRequestErrorId+Private.h"
#include <stdexcept>

static_assert(__has_feature(objc_arc), "Djinni requires ARC to be enabled for this file");

namespace djinni_generated {

class ClientChannelHandler::ObjcProxy final
: public ::clientsdk::ClientChannelHandler
, private ::djinni::ObjcProxyBase<ObjcType>
{
    friend class ::djinni_generated::ClientChannelHandler;
public:
    using ObjcProxyBase::ObjcProxyBase;
    void onChannelConfirmed(const std::string & c_clientId, const std::shared_ptr<::clientsdk::Channel> & c_channel) override
    {
        @autoreleasepool {
            [djinni_private_get_proxied_objc_object() onChannelConfirmed:(::djinni::String::fromCpp(c_clientId))
                                                                 channel:(::djinni_generated::Channel::fromCpp(c_channel))];
        }
    }
    void onChannelResponseError(const std::string & c_clientId, ::clientsdk::ChannelRequestErrorId c_errorId) override
    {
        @autoreleasepool {
            [djinni_private_get_proxied_objc_object() onChannelResponseError:(::djinni::String::fromCpp(c_clientId))
                                                                     errorId:(::djinni::Enum<::clientsdk::ChannelRequestErrorId, PSPChannelRequestErrorId>::fromCpp(c_errorId))];
        }
    }
};

}  // namespace djinni_generated

namespace djinni_generated {

auto ClientChannelHandler::toCpp(ObjcType objc) -> CppType
{
    if (!objc) {
        return nullptr;
    }
    return ::djinni::get_objc_proxy<ObjcProxy>(objc);
}

auto ClientChannelHandler::fromCppOpt(const CppOptType& cpp) -> ObjcType
{
    if (!cpp) {
        return nil;
    }
    return dynamic_cast<ObjcProxy&>(*cpp).djinni_private_get_proxied_objc_object();
}

}  // namespace djinni_generated
