# DHT Message types and formats

These are used by nodes in DHT to communicate and perform the basic operations `Find Node`, `Find/Store Value`, and `Ping` 

```go
message Message {
    enum MessageType {
        PUT_VALUE = 0; // Add value to key value store
        GET_VALUE = 1; // Get value from key value store
        ADD_PROVIDER = 2; // Add provider
        GET_PROVIDERS = 3; // Get provider
        FIND_NODE = 4; // Find node with closest to given key
        PING = 5; // keepalive
        SEND_ID = 6; // TODO
        REQUEST_ID = 7; // TODO
    }
    enum ConnectionType {
        // sender does not have a connection to peer, and no extra information (default)
        NOT_CONNECTED = 0;

        // sender has a live connection to peer
        CONNECTED = 1;

        // sender recently connected to peer
        CAN_CONNECT = 2;

        // sender recently tried to connect to peer repeatedly but failed to connect
        // ("try" here is loose, but this should signal "made strong effort, failed")
        CANNOT_CONNECT = 3;
    }

    message Peer {
        // ID of a given peer.
        bytes id = 1;

        // multiaddrs for a given peer of the form '(/<protoName string>/<value string>)+'
        repeated bytes addrs = 2;

        // used to signal the sender's connection capabilities to the peer
        ConnectionType connection = 3;
    }

    // defines what type of message it is.
    MessageType type = 1;

    // defines what coral cluster level this query/response belongs to.
    // in case we want to implement coral's cluster rings in the future.
    int32 clusterLevelRaw = 10;

    // Used to specify the key associated with this message.
    // PUT_VALUE, GET_VALUE, ADD_PROVIDER, GET_PROVIDERS
    bytes key = 2;

	// Used to return a value
	// PUT_VALUE, GET_VALUE
	record.pb.Record record = 3;

	// Used to return peers closer to a key in a query
	// GET_VALUE, GET_PROVIDERS, FIND_NODE
	repeated Peer closerPeers = 8;

	// Used to return Providers
	// GET_VALUE, ADD_PROVIDER, GET_PROVIDERS
	repeated Peer providerPeers = 9;
}

```
