# Discovery-Raft

### The Discovery service uses a modified fork of hashicorp/Raft (https://github.com/hashicorp/raft) for leadership election and collaborative list sharing. Modifications to this fork were necessary in order to accomodate the following:


* ### Discovery nodes create a local raft instance and correspondingly an in-memory transport for each trusted discovery node it knows about.

* ### The local Raft instance will send messages thru these transports which will be intercepted and consumed over the internal raft exposed channel peer[n].transport.Proxy() and fowarded to the other discovery nodes accordingly using the psp protocol. Hence wrapping Rafts own protocol within the psp protocol. 

* ### Raft's own proprietary communication is transferred into a protobuf structure and then marshalled before being wrapped into the psp protocol as follows:

```protobuf
message DiscoveryRaftPacket {
    string version = 1;
    
    enum raftMsgType {
        appendEntriesRequest = 0;
        requestVoteRequest = 1;
        installSnapshotRequest = 2;
        appendEntriesResponse = 3;
        requestVoteResponse = 4;
        installSnapshotResponse = 5;
    } 

    string sourceID = 3;
    string desitnationID = 4;
    raftMsgType msgType = 5;

    uint64 packetID = 6;
    bytes packet = 7;
}
```
* ### Currently these messages are not signed by the dispatching discovery node although a secure psp communcation channel is being used.

* ### Leadership election via Raft happens gracefully without any discovery related influences. 

* ### The Raft log is used as the collaborative shared list of publish items. It is maintained only by the leader node. Ownership gets transferred when a new leader is elected. 

* ### Data is stored in the raft log as the following marshalled protobuf structure _RaftLogEntry_:

```protobuf
message DiscoverySignature {
    bytes certificate = 1;
    bytes signature = 2;
}

message RaftLogSignatureEntry {
    DiscoverySignature signature = 1;
    uint64 expiration = 2;
}

message RaftLogEntry {
	bytes packet = 1;
	repeated RaftLogSignatureEntry signatures = 2;
    uint64 deleteIndex = 3;
}
```

* ### Typically Raft Logs grow. In the case of discovery the log entries are updated by inserting a new updated record and deleting the original. This allows each Publish item to persist with a list of signatures and corrsponding expiration date. It also keeps the log from growing out of control.

* ### Raft allows for an outside observer to be informed of its internal state changes and transistions. This is relied upon by the Discovery Consensus's state machine to react upon the election or demotion of a leader node. 