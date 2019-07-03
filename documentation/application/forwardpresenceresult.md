# Forward Presence Result

## Definition

In response to [ForwardPresenceRequest](forwardpresence.md), a PSP node returns a result. Depending on the result, the rendezvous circuit will be destroyed or used for communication.

## Operation

The client need to subscribe for this response before sending the initial request.

C++ Example
```asm
circuitConnections_[newCircuit->streamID()].push_back(
    newCircuit->registerEscape<ForwardPresenceRequestResult>(
        task_,
        EscapeMessageId::forwardPresenceRequestResult,
        [=](ForwardPresenceRequestResult res) {
            onForwardPresenceRequestResult(move(res));

            // Close circuit once we get a presence request result
            client_.streamMgr().destroyStream(newCircuit->streamID());
        }));        
```
Then application can make decision based on result code value for user specified in identity field 
```asm
void PresenceManager::onForwardPresenceRequestResult(
    const protocol::ForwardPresenceRequestResult& res)
{
    PS_LOG_INFO(logger_) << "Received a forward presence request result.";

    if (res.result() != ForwardPresenceRequestResult_resultType_success)
    {
        auto code{toFwdPresenceRequestResult(res.result())};

        PS_LOG_WARNING(logger_)
            << "Unable to forward the presence request, due to: " << code;

        // Destroy rendezvous circuit
    }
    else
    {
        PS_LOG_INFO(logger_) << "Successfully forwarded presence request";
    }
}

```

## Payload

```
message ForwardPresenceRequestResult {
    enum resultType {
        success = 0;
        notFound = 1;
        notAllowed = 2;
        internalError = 3;
    }

    string identity = 1;
    resultType result = 2;
}
```