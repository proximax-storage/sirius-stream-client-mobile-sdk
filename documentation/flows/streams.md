# Streams

## Purpose

For the general case when two nodes or a client and a node need to exchange information without an added layer of anonymity they should use a stream
on top of the existing TLS connection.  The stream does not provide any additional level of encryption or validation besides what TLS connection already
has and does not allow to build multi hop paths to deliver the data.  Clients should never accept incoming streams and nodes should only accepts streams
with namespaces they support.  Streams could be authenticated (coming from the TLS connection with authenticated initiator) or non-authenticated (coming
from anonymous TLS connection).

## Stream creation

Initiating party creates a stream sending a [stream create cell](../binary/streamcreate.md) containing the stream ID (following stream ID
[selection rules](../binary/cell.md)) and stream namespace ID.  If responder party chooses to accept the inbound stream it creates the presented
stream on the responding side and starts accepting packets.  If, for some reason, the responding party wants to refuse the stream it replies with
[stream destroy cell](../binary/streamdestroy.md).  Both parties can terminate the stream at any moment delivering the `stream destroy` cell to the other end.

## Stream data delivery

Both parties on a stream exchange data using the [stream relay cell](../binary/streamrelay.md).  The cell payload is a full or a part of an
[application message](../application/message.md) format carrying the [application specific payload](../application/application.md).

## Supported stream namespaces

Type|ID|Node type
----|--|---------
Authority protocol|1|Authority node
Discovery protocol|2|Discovery node
DHT protocol|3|Onion node
Onion presence protocol|4|Onion node
Media streaming protocol|5|Onion node