# Discovery Directory

## Definition
This message provides information about known discovery nodes. The message contains information about nodes inside the signatures field. 

        
## Operation
Nodes can be extracted from DiscoveryDirectory, field signatures. An example follows.

C++ Example:  
```
auto discoveryListing =
        ProtobufHandler::toMsg<DiscoveryListing>(discoveryDir.directory());
        
message DiscoveryListing {
    string version = 1;
    repeated bytes items = 2;
    uint64 creation = 3;
    uint64 expiration = 4;
}
        
```
Field items represent actual discovery nodes. It should be deserialized as well.

C++ Example:  

```
auto discoveryItem = ProtobufHandler::toMsg<DiscoveryItem>(item);

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
```

## Payload

```
message DiscoveryDirectory {
    bytes directory = 1;
    repeated DiscoverySignature signatures = 2;
}
```
