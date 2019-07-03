# Discovery Client

### The discoveryclient package extends the capabilities of a psp.Node by giving it the ability to establish connections with trusted discovery nodes. The client is responsible for providing the implementing node access to the discovery services defined by the following interface:

```go
type Discovery interface {
	GetFullList(time.Duration) ([]*NodePublicIdentity, error)
	Publish(*NodePublicIdentity) error
	ClearCache()
}
```
-----
## __GetFullList__<br>Returns a list of known onion nodes from the discovery service that can be used for routing. The protobuf exchange is as follows:

```protobuf
------> To Discovery Service
message PullDiscovery {   
         string version = 1; // Defined as: DiscoveryRequestProtocolNum = "psp-discovery-1.0"
}
```
```protobuf
<------ Response from Discovery Service
message DiscoveryDirectory {
    bytes directory = 1;
    repeated DiscoverySignature signatures = 2;
}
```

>__DiscoveryDirectory.directory:__<br>The _directory_ field in _DiscoveryDirectory_ is a signed message _(signed by the discovery node from which it was received)_ and hence stored stored as a binary. When unmarshalled it will reveal the _DirectoryListing_ defined as:
```protobuf
message DiscoveryListing {
    string version = 1;
    repeated bytes items = 2;
    uint64 creation = 3;
    uint64 expiration = 4;
}
```

>__DiscoveryListing.items:__<br>An array of marshalled messages _(currently not signed by the original sender)_. Each element will unmarshal into a _DiscoveryItem_, these are the available nodes:
```protobuf
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

>__DiscoveryListing.signatures:__<br>An array of marshalled messages. Each element will unmarshal into a _DiscoverySignature_, these represent the signatures of every discovery node that has examined the list and granted its approval:
```protobuf
message DiscoverySignature {
    bytes certificate = 1;
    bytes signature = 2;
}
```

-----
## __Publish__<br>PSP Nodes announce themselves on a regular basis to the Discovery Services by sending them a the publish message in the form:
```protobuf
------> To Discovery Service
message PublishToDiscovery {
    string version = 1;
    bytes signedDiscoveryItem = 2;
}
```
>__PublishToDiscovery.signedDiscoveryItem:__<br>This is a _DiscoveryItem_, signed by the sender, with information about the node that is publishing.

-----
## __ClearCache__<br>The list of available nodes returned by the discovery service could he cached by the client if it has not yet expired. Under some circumstances it might be useful to clear this cache. Especially when testing. 


