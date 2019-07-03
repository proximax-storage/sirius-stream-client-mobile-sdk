# Relayed join rendezvous cell

`Join rendezvous` cell is used by a client joining existing rendezvous point using the already known cookie as per [rendezvous handshake](rendezvous.md) specification.

## Payload

        Cookie              [32 bytes]
        Handshake           [Variable bytes]

[Relay commands](command.md)