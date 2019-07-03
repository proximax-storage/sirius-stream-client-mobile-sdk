# DHT transport layer design

DHT utilizes the onion tranport layer provided by PSP for communication, this is accomplished by implementing the `Transport` interface from `libp2p-transport` in `xpxtransport` allowing each node hosting DHT to communicate

## Design

### XPXTransport

DHT integrates Ipfs with the secure onion transport layer provided by PSP by fulfilling the contract required by `libp2p-transport` and `go-libp2p-transport-upgrader` to provide a transport layer for use by the nodes comprising the [swarm](github.com/libp2p/go-libp2p-swarm), thereby providing secure and authenticated communication between DHT nodes

XPXTransport implements the following `libp2p-transport` interfaces which allow DHT to operate over the secure onion transport layer provided by PSP:

```go
// Conn is an extension of the net.Conn interface that provides multiaddr
// information, and an accessor for the transport used to create the conn
type Conn interface {
	smux.Conn
	inet.ConnSecurity
	inet.ConnMultiaddrs

	// Transport returns the transport to which this connection belongs.
	Transport() Transport
}

// Transport represents any device by which you can connect to and accept
// connections from other peers. The built-in transports provided are TCP and UTP
// but many more can be implemented, sctp, audio signals, sneakernet, UDT, a
// network of drones carrying usb flash drives, and so on.
type Transport interface {
	// Dial dials a remote peer. It should try to reuse local listener
	// addresses if possible but it may choose not to.
	Dial(ctx context.Context, raddr ma.Multiaddr, p peer.ID) (Conn, error)

	// CanDial returns true if this transport knows how to dial the given
	// multiaddr.
	//
	// Returning true does not guarantee that dialing this multiaddr will
	// succeed. This function should *only* be used to preemptively filter
	// out addresses that we can't dial.
	CanDial(addr ma.Multiaddr) bool

	// Listen listens on the passed multiaddr.
	Listen(laddr ma.Multiaddr) (Listener, error)

	// Protocol returns the set of protocols handled by this transport.
	//
	// See the Network interface for an explanation of how this is used.
	Protocols() []int

	// Proxy returns true if this is a proxy transport.
	//
	// See the Network interface for an explanation of how this is used.
	// TODO: Make this a part of the go-multiaddr protocol instead?
	Proxy() bool
}

// Listener is an interface closely resembling the net.Listener interface.  The
// only real difference is that Accept() returns Conn's of the type in this
// package, and also exposes a Multiaddr method as opposed to a regular Addr
// method
type Listener interface {
	Accept() (Conn, error)
	Close() error
	Addr() net.Addr
	Multiaddr() ma.Multiaddr
}

type Network interface {
	inet.Network

	// AddTransport adds a transport to this Network.
	//
	// When dialing, this Network will iterate over the protocols in the
	// remote multiaddr and pick the first protocol registered with a proxy
	// transport, if any. Otherwise, it'll pick the transport registered to
	// handle the last protocol in the multiaddr.
	//
	// When listening, this Network will iterate over the protocols in the
	// local multiaddr and pick the *last* protocol registered with a proxy
	// transport, if any. Otherwise, it'll pick the transport registered to
	// handle the last protocol in the multiaddr.
	AddTransport(t Transport) error
}
```

#### Conn

Exposes the stream and mechanisms which allow communication between DHT nodes utilizing the secure onion transport provided by PSP

```go
// Conn encapsulates a connection in Peerstream protocol
// Main component is the DhtStream which manages the pipes in the onion layer
type Conn struct {
	ds           *DhtStream
	remote       string
	b            []byte
	header       []byte
	headerInPlay bool
	mut          sync.Mutex
	mutRead      sync.Mutex
}
```

#### Listener

Receiver for new incoming connections using XPXTransport

```go
// XPXListener  complete encapsulation of a DHT listener in peerstream protocol
type XPXListener struct {
	Incoming  chan *DhtStream
	Closed    chan interface{}
	Node      *Node
	localAddr string
}
```

#### Node

Node is a wrapper around PSP Node which exposes the stream creation ability that allows DHT to employ the secure onion transport layer

```go
type Node struct {
	pspnode psp.Node // PSP node
	handler psp.StreamCreatorHandler // the callback which allows communication between endpoints of a stream
}
```

#### DhtStream

DhtStream represents a secure and authenticated connection between instances of DHT nodes within the PSP network

```go
// DhtStream  this is a wrapper for the channel returned to us by the onion layer
type DhtStream struct {
	fingerprint enc.Fingerprint // sha256 digest of node rsa key
	sender      psp.ApplicationMessageHandler // callback for other side
	channel     chan []byte // chan we send/receive to network with
}
```

#### DHT Transport

Object which exposes all the necessary components and functionality to allow DHT nodes to communicate securely using PSP

```go
// PSPDHTTransport  complete definition of XPX transport object
type PSPDHTTransport struct {
	Node     *Node
	Listener *XPXListener
	Upgrader *tptu.Upgrader
}
```