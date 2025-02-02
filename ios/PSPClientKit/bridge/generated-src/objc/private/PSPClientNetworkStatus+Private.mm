// AUTOGENERATED FILE - DO NOT MODIFY!
// This file generated by Djinni from ClientApp.djinni

#import "PSPClientNetworkStatus+Private.h"
#import "DJIMarshal+Private.h"
#include <cassert>

namespace djinni_generated {

auto ClientNetworkStatus::toCpp(ObjcType obj) -> CppType
{
    assert(obj);
    return {::djinni::F32::toCpp(obj.networkConnectivity),
            ::djinni::I64::toCpp(obj.numEntryNodesConnected)};
}

auto ClientNetworkStatus::fromCpp(const CppType& cpp) -> ObjcType
{
    return [[PSPClientNetworkStatus alloc] initWithNetworkConnectivity:(::djinni::F32::fromCpp(cpp.networkConnectivity))
                                                numEntryNodesConnected:(::djinni::I64::fromCpp(cpp.numEntryNodesConnected))];
}

}  // namespace djinni_generated
