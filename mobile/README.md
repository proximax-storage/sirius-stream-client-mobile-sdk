

# Peerstream Client SDK

Peerstream client SDK wrapper.


## Initial Setup

Following steps are to set up PSPClientKit project, which contains test apps for both iOS and MacOS platforms, leveraging PSP middleware.

- Clone and drill into root directory of the project:
```
git clone https://github.com/peerstreaminc/mobile.git
cd mobile
```

- Setup submodules:
```
git submodule update --init --recursive
```

- Copy necessary dependency libs:
`./copy_middleware_libs.sh -p <PLATFORM>` where `<PLATFORM>` is `ios`, `macos` or `android`

- Open up `PSPClient.xcodeproj` within `project/PSPClient` dir, select a desired target, build and run.


## Updating Middleware Hash

In order to update middleware to a specific commit hash, we just need to pass an additional parameter to `copy_middleware_libs.sh` script:

```
./copy_middleware_libs.sh -p <PLATFORM> -v 13dc0dbb19b9fce64d52b81ab12d02ddff57ab5c
```

> NOTE: You can always run `./copy_middleware_libs.sh --help` for more info.


## Djinni Setup

This setup is only necessary if modifications to native APIs are needed (only when any of .djinni templates have been modified).

- Run the following from root which will regenerate djinni sources and copy everything over to linked directories:
```
./djinni.sh
./copy_djinni_sources.sh
```
