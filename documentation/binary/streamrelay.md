# StreamRelay cell

`Stream relay` variable size cell carries the stream data over the single stream. The cell payload is a full or a part of an [application message](../application/message.md) format carrying the [application specific payload](../application/application.md).

## Payload

        Data                [1-65535 bytes; application message]
