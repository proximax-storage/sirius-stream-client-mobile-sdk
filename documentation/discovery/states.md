# Discovery State Machine

### When Discovery is running with three or more nodes it will elect a leader and the remaining nodes will serve as followers. In this mode the behavior of the cluster will be dictated by a state machine that will react to both discovery specific needs as well as transitions in leadership determined by the Raft component. 


* ### When running as a leader-follower cluster there are number of messages that are interchanged between discovery nodes. For this reason Discovery nodes were also retro-fitted with its own DiscoveryClient although kept and maintained as the separate interface, _DiscoveryConsensus_.

* ### The DiscoveryConsensus is an interface used by the discovery service to collaborate with other instances of the discovery service:
```go
type DiscoveryConsensus interface {
	IsLeader() (bool, error)
	IsLeaderFingerprint(enc.Fingerprint) bool
	GetFullListForPublication(time.Duration) (*protocol.DiscoveryDirectory, error)
	SendRaftPacket(msg *protocol.DiscoveryRaftPacket) error
	InitiateVoting(uint64, uint64) (int, error)
	Vote(leader string, signature []byte) error
	Recover() error
	ForwardPublishToDiscovery(leader string, msg []byte) error
	SendFinalConsensus(*protocol.DiscoveryFinalConsensus) error
	SignDiscoveryContent(msg []byte) (*protocol.DiscoverySignature, error)
	NewSignedMessage(msg []byte) (interface{}, error)
	Config() []interface{}
	SendDirectory(interface{}) error

	OnReceivedRaftPacket(fingerprint enc.Fingerprint, msg *protocol.DiscoveryRaftPacket) error
	OnReceivedPublishToDiscovery(fingerprint enc.Fingerprint, index uint64, msg []byte, signatures []*protocol.DiscoverySignature) (uint64, error)
	OnReceivedConsensusVote(fingerprint enc.Fingerprint, msg *protocol.DiscoveryConsensusVote) error
	OnReceivedRequestConsensusVote(fingerprint enc.Fingerprint, msg *protocol.DiscoveryRequestConsensusVote) error
	OnReceivedFinalConsensus(fingerprint enc.Fingerprint, msg *protocol.DiscoveryFinalConsensus) error
}
```

* ### The following protobuf events support this functionality:
```protobuf
message DiscoveryRequestConsensusVote {
    string version = 1;
    uint64 creation = 2;
    uint64 expiration = 3;
}

message DiscoveryConsensusVote {
    string version = 1;
    DiscoverySignature signature = 2;
}

message DiscoveryFinalConsensus {
    string version = 1;
    repeated DiscoverySignature signatures = 2;
}

message PublishToDiscoveryForwarded {
    string version = 1;
    string fingerprint = 2;
    bytes publishPacket = 3;
    DiscoverySignature signature = 4;
}
```

* ### The valid states are defined as follows:

  * __EngStateNil__ : Uninitialized state. Will only occur pre-startup or post shutdown.

  * __EngStateInitializing__ : The node does not yet know whether it is a leader or follower during this state.

  * __EngStateLeaderRunning__ : This node is a confirmed leader and is running as such.

  * __EngStateLeaderConsensusCalc__ : In the process of calculating a consensus.
  
  * __EngStateLeaderConsensusPublish__ : Consensus calculated and final list of signatures has been prepared.
	
  * __EngStateLeaderCleanup__ : Cleanup and prepare for the next consensus round.
	
  * __EngStateLeaderEnhance__ : Examine the lists received from the other discovery nodes. See if there is anything we can do to improve syncing/collaboration etc.

  * __EngStateFollowerVerifyLeader__ : We are a follower and we do our due diligence to make sure the leader is a valid leader. If not we can refuse to follow.

  * __EngStateFollowerRunning__ : This node is a confirmed follower and is running as such.

  * __EngStateFollowerConsensusVote__ : In the process of voting on the current collaborated list.
  
  * __EngStateFollowerVerifyFinalList__ : We voted and the leader has prepared a final list of signatures based on these votes. We received this list and are now verifying it a final time before we make it public on the current discovery node.
	
  * __EngStateFollowerPublishFinalList__ : The final list of sigantures has been verified locally against the collaboration list. It is now time to make this list publically available on this local discovery node.

  * __EngStateFollowerCleanup__ : Time to cleanup and prepare for the next round.

