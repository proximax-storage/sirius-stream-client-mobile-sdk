# Relay cell format and encryption

## Fields

`Relay` cell binary payload specification is [available here](../binary/relay.md).

## Definition

The forward direction is the direction that [create cell](../binary/create.md) cells is sent.

The backward direction is the direction `create` cell was received from.

Using SHA1 as a circuit digest algorithm.

Using AES 128 with zero IV as a stream cypher.

Encrypting the cell encrypts the entire payload of the `relay` cell including the header.

## Encrypting the circuit

### Routing from the origin

When a relay cell is sent from the client, the client encrypts the payload
with the stream cipher as follows:

    Clear the cell digest (set it to zero)
    Update the Df forward digest with the cell value with digest cleared
    Set the digest to the new digest value (taking first 4 bytes out of digest value)
    For I=N...1, where N is the destination node:
        Encrypt with Kf.
    Transmit the encrypted cell to node 1.

## Relaying the cell forward

When a forward relay cell is received by a node, it decrypts the payload with the stream cipher, as follows:

    Use Kf as key; decrypt.

The node then decides whether it recognizes the relay cell, by inspecting the payload.
If the node recognizes the cell, it processes the contents of the relay cell.
Otherwise, it passes the decrypted relay cell along the circuit if the circuit continues.
If the node at the end of the circuit encounters an unrecognized relay cell the node sends a
[destroy cell](../binary/destroy.md) to tear down the circuit.

## Relaying the cell backward

When a backward relay cell is received by a node, it encrypts the payload with the stream cipher, as follows:

    Use Kb as key; encrypt.
    Transmit the encrypted cell to a previous node or client on a circuit.

## Receiving the cell at origin

When a relay cell arrives back to the client, the client decrypts the payload with the stream cipher as follows:

    Client receives relay cell from node 1:
    For I=1...N, where N is the final node on the circuit:
        Decrypt with Kb-I.
    If the payload is recognized, then:
        The sending node is I.
        Stop and process the payload.
    If cell is not recognized at the end the client tears down the circuit.

## Recognizing the cell

The `recognized` field is used as a simple indication that the cell is still encrypted. It is an optimization
to avoid calculating expensive digests for every cell. When sending cells, the non-encrypted `recognized` must
be set to zero.  When receiving and decrypting cells the `recognized` will always be zero if we're the endpoint
that the cell is destined for.  For cells that we should relay, the `recognized` field will usually be nonzero,
but may accidentally be zero.

When handling a relay cell, if the `recognized` in field in a decrypted relay payload is zero, the `digest` field
is computed as the first four bytes of the running digest of all the bytes that have been destined for this hop
of the circuit or originated from this hop of the circuit, seeded from Df or Db respectively, and including
this `relay` cell's entire payload (taken with the digest field set to zero).  If the digest is correct,
the cell is considered "recognized" for the purposes of decryption.

[Relay commands](command.md)