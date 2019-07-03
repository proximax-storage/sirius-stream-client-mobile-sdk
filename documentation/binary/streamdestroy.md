# StreamDestroy cell

StreamDestroy cell is a variable size cell with or without payload. Both nodes on a stream can send that cell any time when they want to terminate the stream.

## Payload

    Reason                [optional; 1 byte]

## Possible stream termination reasons

Name|Code|Reason
----|----|------
Unknown|0 or no payload|Reason is not specified
Closed|1|Stream is closed/not registered by the other side
Protocol|2|Invalid protocol sequence on a stream
Not supported|3|Requested namespace is not supported by the node
Duplicate|4|Stream with given ID or fan-out with given cookie is already registered on the node

[All cells](cell.md)