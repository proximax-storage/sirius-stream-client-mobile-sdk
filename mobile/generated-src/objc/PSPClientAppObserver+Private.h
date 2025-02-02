// AUTOGENERATED FILE - DO NOT MODIFY!
// This file generated by Djinni from ClientApp.djinni

#include "ClientAppObserver.hpp"
#include <memory>

static_assert(__has_feature(objc_arc), "Djinni requires ARC to be enabled for this file");

@protocol PSPClientAppObserver;

namespace djinni_generated {

class ClientAppObserver
{
public:
    using CppType = std::shared_ptr<::clientsdk::ClientAppObserver>;
    using CppOptType = std::shared_ptr<::clientsdk::ClientAppObserver>;
    using ObjcType = id<PSPClientAppObserver>;

    using Boxed = ClientAppObserver;

    static CppType toCpp(ObjcType objc);
    static ObjcType fromCppOpt(const CppOptType& cpp);
    static ObjcType fromCpp(const CppType& cpp) { return fromCppOpt(cpp); }

private:
    class ObjcProxy;
};

}  // namespace djinni_generated

