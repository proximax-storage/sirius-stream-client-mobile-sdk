// AUTOGENERATED FILE - DO NOT MODIFY!
// This file generated by Djinni from VideoStreamer.djinni

#import "PSPVideoStreamDevice+Private.h"
#import "DJIMarshal+Private.h"
#import "PSPVideoStreamCapability+Private.h"
#include <cassert>

namespace djinni_generated {

auto VideoStreamDevice::toCpp(ObjcType obj) -> CppType
{
    assert(obj);
    return {::djinni::String::toCpp(obj.name),
            ::djinni::String::toCpp(obj.identifier),
            ::djinni::List<::djinni_generated::VideoStreamCapability>::toCpp(obj.videoCapabilities)};
}

auto VideoStreamDevice::fromCpp(const CppType& cpp) -> ObjcType
{
    return [[PSPVideoStreamDevice alloc] initWithName:(::djinni::String::fromCpp(cpp.name))
                                           identifier:(::djinni::String::fromCpp(cpp.identifier))
                                    videoCapabilities:(::djinni::List<::djinni_generated::VideoStreamCapability>::fromCpp(cpp.videoCapabilities))];
}

}  // namespace djinni_generated
