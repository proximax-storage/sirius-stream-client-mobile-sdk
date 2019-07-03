# Lookup Presence

## Definition  

When the client has successfully announced itself, it should be discoverable inside PSP network (as part of DHT maintained by PSP). Any client or node which knows a particular client identity can send a lookup presence request and get an associated lookup response.

## Operation

The client creates a PSP circuit to perform user lookup and using that circuit sends lookup request where provides expected user identity. 

Once lookup result received lookup circuit is destroyed. 

C++ Example

```asm
void PresenceManager::lookupPresence(const std::string& identity)
{
    task_->push([=]() {
        client_.streamMgr().getCircuitToRandomEndpoint(
            [=](CircuitPtr lookupCircuit) {
                PS_LOG_INFO(logger_) << "Created/Retrieved new circuit with circuit ID "
                                        "for presence lookup: "
                                     << lookupCircuit->streamID();

                task_->push([=]() {
                    class LookupPresence lookupMsg;
                    lookupMsg.set_identity(identity);
                    circuit->escape(EscapeMessageId::lookupPresence, lookupMsg);
                });
            },
            [=](const CircuitException& ex) {
                PS_LOG_WARNING(logger_)
                    << "Unable to create circuit to " << identity << ", due to : " << ex;
            },
            CircuitSecurity::secure,
            identityTypesOnion);
    });
}

```
As result previusly registered callback for [LookupResult](lookuppresence.md) will be called

## Payload

```
message LookupPresence {
    string identity = 1;
}
```

### LookupPresence

ID|Name|Type|Desc
--|----|----|----
1|identity|string|The identity of the user to lookup
