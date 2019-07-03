# Relayed escape cell

## Payload

Relayed escape cell carries the stream data over the single circuit. The cell payload is a full or a part of an [application message](../application/message.md) format carrying the [application specific payload](../application/application.md).

## Use

Clients can send the `escape` cells to the node to deliver some application-specific events to the node application level. If the event does not fit into the single
relay cell it is being split through multiple escape cells sent in order together.

[Relay commands](command.md)