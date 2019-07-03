# Discovery Publish

## Definition


## Operation


## Payload

```
// internal messages
message DiscoveryItem {
    string version = 1;
    string identity = 2;
    string fingerprint = 3;
    string handshake = 4;
    string mode = 5;
    repeated string address = 6;
    uint64 expiration = 7;
}

message DiscoveryListing {
    string version = 1;
    repeated bytes items = 2;
    uint64 creation = 3;
    uint64 expiration = 4;
}

message DiscoverySignature {
    bytes certificate = 1;
    bytes signature = 2;
}

message PublishToDiscovery {
    string version = 1;
    bytes signedDiscoveryItem = 2;
}
```
