# Announce Presence

## Definition

In order for clients to be able to announce the presence and/or lookup availability information for other users, it should send the Announce Presence message.

## Operation

The client randomly selects N nodes at random that it will announce presence to. For each presence circuit, it randomly chooses 3 nodes that represents the circuit and then builds a chain from these. The endpoint is the presence node.

C++ Example

Generate identity using AuthManager

```asm
const auto identity{client_.authMgr().identity().full()};
```

Get endpoint from existing circuit and take its identity
```asm
const auto identity = circuit->endpoint().identity;
```
Expiration time is time in UNIX format

Generate presence key
```asm
RandomGenerator randGenerator;   
crypto::curve25519::Curve25519KeyPair presenceKey{randGenerator};
const auto& presencePublicKey = presenceKey_.publicKey().publicKey;
```

```
AnnouncementMessage announceReq;
announceReq.set_identity(identity);
announceReq.set_nodeidentity(endpoint.identity);
announceReq.set_expires(unixTime);
announceReq.set_key(presencePublicKey.data(), presencePublicKey.size());
```
And finally message should be serialized to byte array, signed and passed as part of AnnouncePresence message 
```
client_.authMgr().genSignedMessage(
        ProtobufHandler::toBytes(announceReq),
        task_->wrapByFuncSig<void(SignedMessage), SignedMessage>(
            [circuit, presencePublicKey = move(presencePublicKey)](
                SignedMessage reqSigned) mutable {
                const auto reqSignedData{reqSigned.data()};

                using AnnouncePresenceMsg = ::protocol::AnnouncePresence;
                AnnouncePresenceMsg presMsg;
                presMsg.set_request(reqSignedData.data(), reqSignedData.size());
                presMsg.set_key(presencePublicKey.data(), presencePublicKey.size());

                circuit->escape(EscapeMessageId::announcePresence, presMsg);
            }));
```

## Payload

```
message AnnouncementMessage {
    string identity = 1;
    string nodeIdentity = 2;
    uint64 expires = 3;
    bytes key = 4;
    repeated string address = 5;
    bytes fingerprint = 6;
    bytes handshake = 7;
}

message AnnouncePresence {
    bytes request = 1;
    bytes key = 2;
}
```

### AnnouncementMessage

ID|Name|Type|Desc
--|----|----|----
1|identity|string|The identity of the entity
2|nodeIdentity|string|The identity of the endpoint of announcing presence to
3|expires|uint64|The expiration time of the announcement in unix time
4|key|bytes|The public presence key (Curve25519)
5|address|repeated string|A list of addresses for the endpoint
6|fingerprint|bytes|The fingerprint of the endpoint
7|handshake|bytes|The handshake key of the endpoint

### AnnouncePresence

ID|Name|Type|Desc
--|----|----|----
1|request|bytes|Signed message serialized to bytes
2|key|bytes|The public presence key (Curve25519)
