# Relayed rendezvous joined 2 cell

`Rendezvous joined 2` cell is being sent to the client who created the rendezvous point after the other client joins it as per [rendezvous handshake](rendezvous.md) specification.

## Payload

        Cookie              [32 bytes]
        Handshake           [Variable bytes]

[Relay commands](command.md)