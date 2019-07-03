# Fan-out payload format

## Supported message types

Type|ID|Segmentation|Description|Direction
----|--|------------|-----------|---------
Stream parameters|0|:x:|Stream parameters/stream initialization event|B->N->V
Video Key|1|:white_check_mark:|Key frame for the video stream|B->N->V
Video non-key|2|:white_check_mark:|Any other video frame|B->N->V
Audio|3|:white_check_mark:|Audio frame|B->N->V
Report|4|:x:|Broadcaster stream report|N->B
Viewers change|5|:x:|Broadcaster viewers changed event|N->B
Data|6|:white_check_mark:|Binary data frame|B->N->V

```text
B - broadcaster, N - node, and V - viewer
```

## Payload format

### Common header

Most of serialized payload messages share first common 6 bytes containing the packet type, a sequence ID, and a segmentation marker.  The
sequence ID is a monotonically increasing number increasing with every packet being sent from the broadcaster to the node.  Broadcaster may
skip packets but it must not repeat the packets or go backwards.  Application may use the sequence ID for advancing the cryptography ratchet
to derive the cryptographic keys for [encrypting and decrypting the packet payload](ratchet.md). The header is then immediately followed by
the packet data.

        Message type    [1 byte]
        Sequence ID     [4 bytes; big-endian unsigned integer]
        Parts remaining [1 byte]
        Data            [variable bytes]

Two service broadcaster packets (`Report` and `Viewers change`) carry shorter header consisting of just single packet type byte immediately
followed by the event data omitting sequence ID and parts remaining fields.

        Message type    [1 byte]
        Data            [variable bytes]

### Segmented packets

Some of the packets on fan-out payload may not fit into the maximum size for the variable-size cell payload of 64Kb.  In order to support that
the protocol supports segmented payloads splitting message content to up to `5 packets`.  Segmented packets within the same sequence all carry
the same sequence ID.

`Remaining parts` field must contain the amount of pieces following the current piece (for example for the packets segment with 3 pieces the
remaining parts field will be `2, 1, 0` for the packets correspondingly).  Broadcaster must never skip any pieces or deliver the pieces out of order
otherwise the node will terminate the stream.  Node guarantees that it will never skip or reorder any parts for any segmented packet
being sent out to viewers. Very first piece of the segmented packet must carry the top bit (`0x80`) of the `Remaining parts` field set to `1` to indicate
beginning of the sequence.

### Stream rate control

Both node and broadcaster are responsible for performing the rate control for the fan-out.  To do so both broadcaster (on a pipe towards the node)
and the node (on all pipes towards the viewers) are allowed to skip the packets when it is not possible to deliver the data in time.  Rate control
must prevent from sending any more video packets until the next key frame if at least one video frame was skipped and must guarantee that segmented
packets are being delivered in full without skipping parts of it.  Stream parameters cells get special treatment as described in the next section.

### Stream parameters cell

Stream parameters packet contains the variable length payload that described the current stream format and parameters.  The broadcaster must send
the initial stream parameters cell after establishing the fan-out to complete the initialization.  Viewers will not be allowed to join the fan-out
before it was completely initialized.  All viewers receive the most recent parameters cell upon joining.

Broadcaster is able to change the stream parameters during the broadcast.  To do that he may send the new stream parameters cell at any given point
of the stream.  Node guarantees that all viewers will receive all (if not backlogged) or the most recent (if viewer is backlogged) version of the cell
and it will maintain the order of all other frames corresponding to stream parameters cells intact.

### Broadcaster report cell

Node confirms receiving every key video frame from the broadcaster sending him back the report cell carrying following payload:

        Last received Sequence ID               [4 bytes; big-endian unsigned integer]
        Bytes seceived since the last keyframe  [4 bytes; big-endian unsigned integer]

### Viewers change cell

Node notifies the broadcaster when his viewers change sending him viewers change cell carrying following payload:

        Number of viewers                       [4 bytes; big-endian unsigned integer]
