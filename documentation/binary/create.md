# Create cell

`Create` fixed size cell is used by a client or by a node to create a new circuit.
When the stream is created, creating party chooses a new
circuit ID conforming to the circuit ID [selection rules](cell.md).

## Payload

        HandshakeType          [2 bytes; big-endian unsigned integer]
        HandshakeLen           [2 bytes; big-endian unsigned integer]
        Handshake              [HandshakeLen bytes]

## Supported handshake types

Type|Value
----|-----
[PSP 0.1](createhandshake.md)|1

[All cells](cell.md)