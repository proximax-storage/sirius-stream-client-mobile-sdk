
# Middleware Tech Stack

## Middleware Conan Libraries:

```
OpenSSL/1.1.0i@conan/stable
boost/1.69.0@conan/stable
glad/0.1.24@bincrafters/stable
glfw/3.2.1@bincrafters/stable
libsodium/1.0.16@bincrafters/stable
libx264/20171211@bincrafters/stable
ncurses/6.1@conan/stable
protobuf/3.6.1@bincrafters/stable
sdl2/2.0.9@bincrafters/stable
sdl2_ttf/2.0.15@bincrafters/stable
vscodepropertiesgen/0.1@mkovalchik/stable
```

## Additional Middleware 3rdParty Libraries

```
boost_1.69.0
cppinvert
date
ffmpeg
h264lib_opencore
h264lib_svc
h264lib_x264
jsoncpp-1.8.4
libsodium-1.0.16
openssl-1.1.0f
protobuf-3.6.1
sdl-2.0.9
siren
speex-1.2rc1
webrtc
x264
```

For `WebRTC`, there is a specific build process for all platforms.

In terms of programming languages in Middleware, we use:

`C++17`, `C` (very sparingly), `ccache` for compilation object caching, `clang` for compilation, `CMake` for builds, `Python` (mostly for scripts and tests), `Bash` (mostly for scripts and tests)

For configuration, Middleware uses `protobuf`

For iOS, we also make use of `Objective C` to bridge between `C++` and `Objective-C/Swift/React Native`. We also use `Objective-C` to use platform specific APIs.

For Android, we also make some use of `Java` and `JNI` interfaces to bridge between `C++` and `Java` We also use `Java` to use platform specific APIs (mostly for WebRTC).

## PSP Node Libraries:

```
vendor/github.com/armon/go-metrics
vendor/github.com/boltdb/bolt
vendor/github.com/btcsuite/btcd
vendor/github.com/btcsuite/btcutil
vendor/github.com/coreos/go-semver
vendor/github.com/fd/go-nat
vendor/github.com/gogo/protobuf
vendor/github.com/golang/protobuf
vendor/github.com/google/uuid
vendor/github.com/gorilla/mux
vendor/github.com/gorilla/websocket
vendor/github.com/gxed/GoEndian
vendor/github.com/gxed/eventfd
vendor/github.com/gxed/hashland
vendor/github.com/hashicorp/go-immutable-radix
vendor/github.com/hashicorp/go-msgpack
vendor/github.com/hashicorp/golang-lru
vendor/github.com/huin/goupnp
vendor/github.com/ipfs/go-cid
vendor/github.com/ipfs/go-datastore
vendor/github.com/ipfs/go-ipfs-util
vendor/github.com/ipfs/go-log
vendor/github.com/ipfs/go-todocounter
vendor/github.com/jackpal/gateway
vendor/github.com/jackpal/go-nat-pmp
vendor/github.com/jbenet/go-context
vendor/github.com/jbenet/go-temp-err-catcher
vendor/github.com/jbenet/goprocess
vendor/github.com/jroimartin/gocui
vendor/github.com/libp2p/go-addr-util
vendor/github.com/libp2p/go-conn-security
vendor/github.com/libp2p/go-conn-security-multistream
vendor/github.com/libp2p/go-flow-metrics
vendor/github.com/libp2p/go-libp2p
vendor/github.com/libp2p/go-libp2p-circuit
vendor/github.com/libp2p/go-libp2p-crypto
vendor/github.com/libp2p/go-libp2p-host
vendor/github.com/libp2p/go-libp2p-interface-connmgr
vendor/github.com/libp2p/go-libp2p-interface-pnet
vendor/github.com/libp2p/go-libp2p-kad-dht
vendor/github.com/libp2p/go-libp2p-kbucket
vendor/github.com/libp2p/go-libp2p-loggables
vendor/github.com/libp2p/go-libp2p-metrics
vendor/github.com/libp2p/go-libp2p-nat
vendor/github.com/libp2p/go-libp2p-net
vendor/github.com/libp2p/go-libp2p-netutil
vendor/github.com/libp2p/go-libp2p-peer
vendor/github.com/libp2p/go-libp2p-peerstore
vendor/github.com/libp2p/go-libp2p-protocol
vendor/github.com/libp2p/go-libp2p-record
vendor/github.com/libp2p/go-libp2p-routing
vendor/github.com/libp2p/go-libp2p-secio
vendor/github.com/libp2p/go-libp2p-swarm
vendor/github.com/libp2p/go-libp2p-transport
vendor/github.com/libp2p/go-libp2p-transport-upgrader
vendor/github.com/libp2p/go-maddr-filter
vendor/github.com/libp2p/go-mplex
vendor/github.com/libp2p/go-msgio
vendor/github.com/libp2p/go-reuseport
vendor/github.com/libp2p/go-reuseport-transport
vendor/github.com/libp2p/go-sockaddr
vendor/github.com/libp2p/go-stream-muxer
vendor/github.com/libp2p/go-tcp-transport
vendor/github.com/libp2p/go-testutil
vendor/github.com/libp2p/go-ws-transport
vendor/github.com/mattn/go-colorable
vendor/github.com/mattn/go-isatty
vendor/github.com/mattn/go-runewidth
vendor/github.com/minio/blake2b-simd
vendor/github.com/minio/sha256-simd
vendor/github.com/mr-tron/base58
vendor/github.com/multiformats/go-multiaddr
vendor/github.com/multiformats/go-multiaddr-dns
vendor/github.com/multiformats/go-multiaddr-net
vendor/github.com/multiformats/go-multibase
vendor/github.com/multiformats/go-multihash
vendor/github.com/multiformats/go-multistream
vendor/github.com/nsf/termbox-go
vendor/github.com/opentracing/opentracing-go
vendor/github.com/peerstreaminc/raft
vendor/github.com/pkg/errors
vendor/github.com/potakhov/cache
vendor/github.com/potakhov/loge
vendor/github.com/spaolacci/murmur3
vendor/github.com/stretchr/testify
vendor/github.com/whyrusleeping/base32
vendor/github.com/whyrusleeping/go-keyspace
vendor/github.com/whyrusleeping/go-logging
vendor/github.com/whyrusleeping/go-multiplex
vendor/github.com/whyrusleeping/go-notifier
vendor/github.com/whyrusleeping/go-smux-multiplex
vendor/github.com/whyrusleeping/go-smux-multistream
vendor/github.com/whyrusleeping/go-smux-yamux
vendor/github.com/whyrusleeping/mafmt
vendor/github.com/whyrusleeping/multiaddr-filter
vendor/github.com/whyrusleeping/yamux
vendor/go.uber.org/atomic
vendor/go.uber.org/multierr
vendor/golang.org/x/crypto
vendor/golang.org/x/net
vendor/golang.org/x/sys
vendor/golang.org/x/text
```

The PSP nodes also use `Go`, `Bash` and `Docker`, as well as `protobuf` for serialization/deserialization of application messages.
JSON is used for discovery bootstrap configuration for PSP nodes.

## Client SDK iOS Libraries

```
AVFoundation
AudioToolbox
VideoToolbox
CoreMedia
CoreAudio
CoreVideo
```



## Client SDK Android Libraries:

```
Ant
Maven
Gradle
JUnit
```

## Mobile Common Libraries:

`djinni` (for code generation)

