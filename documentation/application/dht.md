# DHT Application level

DHT at the Application level in PSP provides the capability for announcing the 'presence' or availability of a client at an `Onion node`, coupled with the ability to locate the node(s) through which a client is currently available to be contacted, facilitating the ability of PSP to conceal the true location of the client on the network as well as secure the content of the conversation while connecting clients anywhere

## Definition

The DHT (Distributed Hash Table) in use by PSP is an implementation of Kademlia with [S/Kademlia modifications](https://en.bitcoinwiki.org/wiki/Kademlia) utilizing [Libp2p](github.com/libp2p) for peer-to-peer networking along with [Ipfs](ipfs.io) for distributed datastores and content IDs

DHT provides a content-addressable peer-to-peer filesystem which PSP utilizes to help provide secure and anonymous communication between parties on the network

Each node in the peer-to-peer DHT network has a Node ID which is used to locate values by using a 'distance' calculation based on the exclusive-or (XOR) of two node IDs, taking the result as an integer. Information is retrieved by mapping it to a key which can then be located via node lookup using the distance calculation to locate node IDs closest to the key

Values are stored at several nodes to provide redundancy and stability in anticipation of nodes entering and exiting the network

Out of date Values are also continuously expired and removed from DHT to remove old information from the system expediently and ensure information in DHT is current and valid

## Operation

DHT exposes two methods which together constitute it's interface: `Put` and `Get` These methods are utilized by the application layer within the `Onion node` to interact with DHT in order to record and locate presence records for clients using the PSP network. DHT validates data during insertion and rejects malformed or otherwise invalid data prior to addition, in tandem with expunging expired records to maintain accuracy and validatity of presence information for clients in the network in DHT

### Put

`Put` is the means by which DHT allows clients to add entries to it's internal ledger.

All `Put` operations are validated prior to inclusion in DHT to avoid faulty lookups or erroneous presence announcements

#### Input

```go
// Put Input
owner pki.Identity // the identity of the client making the presence announcement
node pki.Identity // the identity of the node at which the client will be present
data []byte // Marshaled AnnouncementMessage containing all the necessary data for the presence announcement, signed by the client and node signaling client presence
expiration int64 // the time (in seconds UTC from the epoch) at which this announcement will no longer be valid
```

#### Output

```go
// Put Output
error // which will be `nil` upon successful addition to the DHT otherwise it will contain relevant context describing the current failure
```

### Get

Likewise `Get` is the operation by which clients are able to retrieve the presence records for a provided `pki.Identity` if such records have been added to DHT and are currently valid

#### Input

```go
// Get Input
owner pki.Identity // the identity whom we are attempting to retrieve presence results for
```

#### Output

```go
// Get Outputs
[]*dhtAnnouncement // slice of dhtAnnouncement type one for each node the client has announced presence at
error // will be `nil` upon successful retrieval or contain relevant context for the current failure otherwise

type dhtAnnouncement struct {
    nodeIdentity string // identity of node through which client is available
    announcement []byte // marshaled representation of announcement message signed by client and node
}
```