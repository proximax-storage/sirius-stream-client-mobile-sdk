# Lookup Result

## Definition

The lookup result is the information returned to client upon a lookup request,

## Operation

It returned as result on circuit creation step and thereafter attempt to resolve client identity. It will reflect all possible problems happened or successfull lookup on one of this two steps.  

C++ Example
When we get a lookup result, there are a list of announcements returned. We then take the most recent announcement in the client iteratng over list of announcements in binary form.
 

```asm
auto res = ProtobufHandler::toMsg<protocol::LookupResult>(resData);

for (const auto& val : res.announcements())
{
    auto valVec{stringToVec(val)};
    auto sm = SignedMessage::fromBinary(container_, valVec, client_.authMgr());
    auto smi = SignedMessage::fromBinary(container_, sm.message(), client_.authMgr());
    auto announcement = ProtobufHandler::toMsg<AnnouncementMessage>(smi.message());
}

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

message LookupResult {
    enum resultType {
        success = 0;
        notFound = 1;
        failure = 2;
    }
    
    string identity = 1;
    resultType result = 2;
    repeated bytes announcements = 3;
}
```

### AnnouncementMessage

[See Announce Presence](announcepresence.md)

### LookupResult::resultType

ID|Name|Type|Desc
--|----|----|----
0|success|enum|The request succeeded and one or more announcements exists in the announcments field
1|notFound|enum|The requested user was not found in a lookup
2|failure|enum|There was a failure for a reason other than one of the above

### LookupResult

ID|Name|Type|Desc
--|----|----|----
1|identity|string|The identity of the user that was looked up
2|result|resultType|Result code for the lookup
2|announcements|repeated bytes|A list of protobuf AnnouncementMessage serialized as a list of bytes
