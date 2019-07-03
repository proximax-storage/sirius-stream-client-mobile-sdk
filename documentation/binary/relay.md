# Relay cell

Fixed size `Relay` cell is used to transmit additional commands or data on top of the circuit. Relay cell is encrypted
[as described](../relay/relaycrypto.md) with multiple layers of encryption and contains following payload.

## Payload

        Relay Command                [1 byte]
        Recognized                   [2 bytes; big endian unsigned integer]
        Digest                       [4 bytes; big endian unsigned integer]
        Length                       [2 bytes; big endian unsigned integer]
        Data                         [0 to 500 (Length) bytes padded with zeros]

Detailed list of `Relay Commands` is [available here](../relay/command.md). The other fields are used [as described](../relay/relaycrypto.md).