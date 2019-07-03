## Datastore

DHT utilizes a synchronized local datastore which is continuously swept to remove expired records and maintain validity of contained data.

The DHT datastore implements the [datastore](https://github.com/ipfs/go-datastore/blob/master/datastore.go) interface as defined by [Ipfs](ipfs.io)

```go
// MapDatastore uses a standard Go map for internal storage.
type MapDatastore struct {
	sync.RWMutex

	values map[ds.Key][]byte

	expiration *expire.Expiration
}
```

##### Operation

The datastore is interacted with primarily via the following methods

```go
// Add entry with key and value in datastore
func (md *MapDatastore) Put(key ds.Key, value []byte) error

// Return the value for the given key, error if no such value
func (md *MapDatastore) Get(key ds.Key) (value []byte, err error)

// Does a (key, value) pair exist with the given key
func (md *MapDatastore) Has(key ds.Key) (exists bool, err error)

// Delete entry with the given key from the datastore
func (md *MapDatastore) Delete(key ds.Key) (err error)
```
see also: [expiration](github.com/peerstreaminc/documentation/blob/master/dht/expiration.md)
