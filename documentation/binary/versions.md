# Versions cell

`Versions` variable size cell begins the protocol handshake allowing two connecting parties to exchange the protocol versions and capabilities
they support. `Versions` cell initiates the handshake process.

## Payload

        version                             [2 bytes; big-endian unsigned integer]
        ...

`Versions` cells payload contains 1 to N version identifiers sending party can negotiate for. During the handshake two sides always
agree on a maximum available version number supported for both ends.

## Supported versions

        PSP 0.1                             1

[All cells](cell.md)