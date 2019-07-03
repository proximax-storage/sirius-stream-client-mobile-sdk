Pod::Spec.new do |s|

  s.name         = "PSPClientKit"
  s.version      = "0.4.14"
  s.summary      = "Peerstream Protocol iOS Client Kit"
  s.description  = "Peerstream Protocol iOS Client Kit"

  s.homepage     = "https://www.peerstream.com/"
  s.license      = "Copyright © 2019 PeerStream, Inc. All rights reserved."
  s.author       = "Sebastian Misiewicz"
  s.platform     = :ios
  s.ios.deployment_target = "11.0"
  s.requires_arc = true


  # s.prepare_command = <<-CMD
  #   bash fetch_libs.sh
  # CMD

  s.module_name  = "PSPClientKit"
  s.source       = { :git => 'https://github.com/peerstreaminc/client-sdk-ios.git', :tag => s.version }

  s.source_files = [
    "PSPClientKit/PSPClientKit.h",
    "PSPClientKit/bridge/**/*.{hpp,cpp,h,m,mm}"
  ]
  
  s.exclude_files = [
  ]
  
  s.private_header_files = [
    "PSPClientKit/bridge/djinni-src/*.hpp",
    "PSPClientKit/bridge/djinni-src/objc/*.h",
    "PSPClientKit/bridge/generated-src/objc/private/*.h",
    "PSPClientKit/bridge/generated-src/cpp/clientsdk/*.hpp",
    "PSPClientKit/bridge/libs/include/middleware/*.hpp",
    "PSPClientKit/bridge/src/cpp/*.{h,hpp}"
  ]

  s.vendored_libraries = [
    "PSPClientKit/bridge/libs/bin/libCoreSDK.dylib"
  ]
 
  s.frameworks = [
    'AVFoundation',
    'AudioToolbox',
    'VideoToolbox',
    'CoreMedia',
    'CoreAudio',
    'CoreVideo'
  ]
  

  s.pod_target_xcconfig = {
    'OTHER_LDFLAGS' => '-ObjC -lz',
    'HEADER_SEARCH_PATHS' => '$(PROJECT_DIR)/PSPClientKit/PSPClientKit/bridge/src/cpp $(PROJECT_DIR)/PSPClientKit/PSPClientKit/bridge/src/objc $(PROJECT_DIR)/PSPClientKit/PSPClientKit/bridge/generated-src/cpp $(PROJECT_DIR)/PSPClientKit/PSPClientKit/bridge/generated-src/objc $(PROJECT_DIR)/PSPClientKit/PSPClientKit/bridge/generated-src/objc/private $(PROJECT_DIR)/PSPClientKit/PSPClientKit/bridge/djinni-src/objc $(PROJECT_DIR)/PSPClientKit/PSPClientKit/bridge/djinni-src $(PROJECT_DIR)/PSPClientKit/PSPClientKit/bridge/libs/include'
  }

  s.library = 'c++'
  s.xcconfig = {
       'CLANG_CXX_LANGUAGE_STANDARD' => 'gnu++17',
       'CLANG_CXX_LIBRARY' => 'libc++'
#    'ENABLE_BITCODE' => 'NO'
  }

end
