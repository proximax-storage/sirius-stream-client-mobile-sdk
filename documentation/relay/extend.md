# Relayed extend cell

`Relayed extend cell` is used by the client to extend the circuit one hop longer.  Upon receiving this cell at the end of the circuit the node creates (or reuses existing) TLS connection
and sends a new [create](../binary/create.md) cell with a new circuit ID linking those two circuits together and becoming an intermediate hop.  If the node receiving an extend cell
is already in the intermediate position (has another circuit linked with this destination) it should reply by destroying the existing circuit.

## Payload

        [N] link specifications amount   [1 byte]
            [N times] Link specification [variable bytes]
        Handshake data                   [variable bytes]

## Link specification payload

        Link specification type         [1 byte]
        [L] Link specification length   [1 byte]
        Link specification              [L bytes]

## Link specification types

Type|ID|Description|Length
----|--|-----------|------
IPv4|0|IPv4 address|4 bytes
IPv6|1|IPv6 address|16 bytes
Identity|2|Node fingerprint|32 bytes
Hostname|3|Hostname address|Variable

## Extending the circuit

The destination node should always try to reuse existing connections towards the requested node fingerprint if it already has any set up.  Node should use content from `Handshake` field
as a payload for the newly sent [create cell](../binary/create.md) as is without modifying it.  After sending the `create` cell out the node should expect the [created cell](../binary/created.md)
back and forward it back to the sender wrapping its payload into the [relayed extended cell](extended.md).

[Relay commands](command.md)