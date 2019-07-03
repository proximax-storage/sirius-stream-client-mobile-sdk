# Forward Presence

## Definition

Forward presence request method by which a client requests presence information for another client on the network. This request can be sent after rendezvous point established.

## Operation

A client sends a forward presence request message to the onion node, the node looks in [DHT](dht.md) for the given identity for the target node 
and returns it or an error as a [ForwardPresenceRequestResult](forwardpresenceresult.md)
so prior to that a node will announce it’s presence on a node, the forward presence request is then sent by a second client who is trying to reach the initial client.

C++ Example
```asm
task_->wrapByFuncSig<void(SignedMessage), SignedMessage>(
    makeSharedFunction([this,
                        initiator = move(initiator),
                        cookie = move(cookie),
                        target = currState.target](SignedMessage req) mutable {
        auto request{initiator->generateIntroduceRequest(req.data())};

        rvStateMachine_.set(ForwardPresenceRendezvous{
            .cookie = move(cookie), .initiator = move(initiator)});

        forwardPresenceRequest_(target, move(request));
    })
```

Callback forwardPresenceRequest_ used to pass data to component (PresenceManager) which performs actual data transmit to Escape node.    
here how some variables received 

C+ Example
```asm
auto& currState = rvStateMachine_.get<RVStateForwardPresenceRendezvous>();

auto initiator =
    make_unique<RVCircuitInitiator>(randGen_, identity_, move(currState.rvKey));
    
auto cookie = currState.cookie;    
```
 
## Payload

```
    message ForwardPresenceRequest {
        bytes request = 1;
    }
```
