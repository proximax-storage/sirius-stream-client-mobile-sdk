# Expiration Routine

#### Expiration

Data structure responsible for tracking expired records within DHT datastore

```go
// Expiration ... structure
type Expiration struct {
	expireList *list.List
	expireMap  map[ds.Key]time.Time

	insertChannel  chan *ExpireRecord
	deleteChannel  chan int
	expiredChannel chan *list.List
}
```

#### Expire Record

A record of a key and subkey combination present in the DHT datastore which expires at the given time T

```go
// ExpireRecord Unit of expiring a value in the map datastore
type ExpireRecord struct {
	T      time.Time
	Key    ds.Key
	Subkey string // Can be nil for single-valued functions
}
```

#### Process

* Insertion into the datastore of a DHT node includes insertion of a matching record into the local `Expiration` object with an expiry time matching the expiration date of the new record in the datastore
* A goroutine within each DHT node datastore is responsible for querying the `Expiration` object for expired records
* A list of `ExpireRecords` is returned to the goroutine responsible for the query
* If the record returned has no subkeys the key from the record is deleted from the datastore key value store
* If the record has subkeys all key value pairs with matching subkeys are removed from the datastore
* If the datastore contains only values matching the key and subkey combination returned from `Expiration` the key is removed from the datastore