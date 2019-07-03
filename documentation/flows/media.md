# Media streams

## Purpose

Media stream fan-outs could be created to allow 1-1 and 1-M media delivery over a single or a set of nodes.  Multi-node delivery is achieved by stacking
several fan-outs together.  The fan-out could be used for both video and data delivery with a rate limited delivery with potential skips.

## Fan-out message format

Fan-out is established or joined using extended [StreamCreate](../binary/streamcreate.md) cell.  All the communication for the established fan-out is done
using regular [StreamRelay](../binary/streamrelay.md) cells with payload containing serialized [fan-out payload](fanout.md) format.  Stream content is
encrypted as specified in [encrypting and decrypting the packet payload section](ratchet.md).

## Extended StreamCreate cell

Establishing a new fan-out or joining to the existing fan-out is done by the client sending a new extended [StreamCreate](../binary/streamcreate.md) cell with
additional subcommand and a 32 byte long random cookie (SHA256 from the random 32 bytes).
Supported subcommands are:

        MediaProtocolRegister   uint32 = 1
        MediaProtocolJoin       uint32 = 2

`MediaProtocolRegister` is used for creation of a new fan-out, `MediaProtocolJoin` is used for joining to the existing fan-out.  Node confirms success for the operation
replying with [StreamCreated](../binary/streamcreated.md) cell or refuses the request with [StreamDestroy](../binary/streamdestroy.md) cell.