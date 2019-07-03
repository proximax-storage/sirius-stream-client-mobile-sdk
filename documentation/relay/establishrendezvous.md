# Relayed establish rendezvous cell

`Establish rendezvous` cell is used in a circuit as a beginning of [rendezvous handshake](rendezvous.md).

## Payload

        Cookie              [32 bytes]

Client should choose a new SHA256[32 random bytes] value as a new rendezvous cookie value every time it creates a new rendezvous point.

[Relay commands](command.md)