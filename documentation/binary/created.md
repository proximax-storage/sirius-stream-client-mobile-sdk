# Created cell

`Created` fixed size cell is sent by the node as a response to `Create` cell during the circuit creation handshake.

## Payload

        ServerHandshakeLen           [2 bytes; big-endian unsigned integer]
        ServerHandshake              [ServerHandshakeLen bytes]

`ServerHandshake` contains the server handshake response [as specified](createhandshake.md).

[All cells](cell.md)