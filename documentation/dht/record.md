# DHT Records format

##### Records are entries in the internal key value store which are replicated across the network, they contain the information necessary to locate and establish communication with a client through an onion node

```go
// Record represents an XPX dht record that contains a value
// for a key value pair
message Record {
	string key = 1; // the key for the internal map datastore

	int64 updateDate = 2; // time at which the record was updated in the ledger

	string id1 = 3; // the identity of the client announcing their presence

	repeated Value values = 4;  // Values should not exceed 1 element
	                            // And updating, inserting and deleting operates
				    // Differently for arrays and non-arrays	
}
```

##### Values store the identity of the node at which a client has announced its presence with together with metadata and a message signed by both the client and the onion node containing:

* Identity of the node hosting the client presence ('the node')
* Identity of the client making the presence announcement ('the client')
* Curve25519 Public key for the node ('handshake key')
* Sha256 digest of the nodes identity key ('fingerprint')
* Expiration date when the announcement is no longer considered valid ('expiration')
* Curve25519 Public key used for client-to-client communication ('presence key')

##### the application layer uses this information to verify requests are valid as well as facilitate secure and private communication between clients

```go
message Value {
    string id2 = 1; // subkey and be the whole key (repeated) or with an additional layer appended

    int64 creationDate = 3; // when this value was added to the DHT
    
    int64 expirationDate = 4; // when this value will no longer be considered valid
    
    bytes value = 5; // marshaled AnnouncementMessage signed by both client and node
}
```

### Record Creation

```go
// Creates a DHT record ready to be added to the key value store
func MakePutRecord(
    path string, // the base of DHT key of the form '/<base>/<id1>/'
    pkiID1 []byte, // byte string repr of client identity i.e. byte(pki.Identity.String())
    pkiID2 []byte, // byte string repr of node identity
    signedMessage []byte, // marshaled, signed AnnouncementMessage
    expireTime int64 // time after which this record is invalid
) *pb.Record // new record
```

### Record Validation

##### Records are validated by user defined routines implementing `Validator` prior to inclusion in DHT 
```go
// Validator is an interface that should be implemented by record validators.
type Validator interface {
	// Validate validates the given record, returning an error if it's
	// invalid (e.g., expired, signed by the wrong key, etc.).
	Validate(key string, value *pb.Record) error

	// Select selects the best record from the set of records (e.g., the
	// newest).
	//
	// Decisions made by select should be stable.
	Select(key string, values []*pb.Record) (int, error)

	// Consolidate (new for peerstream).  Composite a bunch of values for a single key
	Consolidate(key string, values []*pb.Record) error
}
```
