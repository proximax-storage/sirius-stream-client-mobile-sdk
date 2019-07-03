// AUTOGENERATED FILE - DO NOT MODIFY!
// This file generated by Djinni from ClientApp.djinni

#import "PSPClientRegistrationData+Private.h"
#import "DJIMarshal+Private.h"
#include <cassert>

namespace djinni_generated {

auto ClientRegistrationData::toCpp(ObjcType obj) -> CppType
{
    assert(obj);
    return {::djinni::String::toCpp(obj.identity),
            ::djinni::String::toCpp(obj.secretKey),
            ::djinni::Binary::toCpp(obj.certificate)};
}

auto ClientRegistrationData::fromCpp(const CppType& cpp) -> ObjcType
{
    return [[PSPClientRegistrationData alloc] initWithIdentity:(::djinni::String::fromCpp(cpp.identity))
                                                     secretKey:(::djinni::String::fromCpp(cpp.secretKey))
                                                   certificate:(::djinni::Binary::fromCpp(cpp.certificate))];
}

}  // namespace djinni_generated
