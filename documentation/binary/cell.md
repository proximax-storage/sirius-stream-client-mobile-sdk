# Cell packet format

## Intro

All communication between nodes and between nodes and clients in PSP is marshaled into binary cells. Cells contain the cell header,
the cell command and the cell circuit (or stream) ID. Cells can be fixed size or variable length packets. Cells that
have command ID greater or equal 128 are variable length and cells with command ID below 128 are fixed length.

## Cell binary format

Fixed-length cells

        CircuitID                             [4 bytes]
        Command                               [1 byte]
        Payload (padded with 0 bytes)         [509 bytes]

Variable-length cells

        CircuitID                             [4 bytes]
        Command                               [1 byte]
        Length                                [2 bytes; big-endian unsigned integer]
        Payload                               [1-65535 (Length) bytes]

## Circuit ID (Stream ID)

The Circuit ID is an arbitrarily chosen nonzero integer, selected by the node or the client that sends the Create
or StreamCreate cell. New circuit ID should not reuse any other circuit ID already used within the used TLS connection
but may interlap with circuit IDs used on other TLS connections.
To prevent Circuit ID collisions, whichever party initiated the TLS connection sets its MSB to 1, and whichever party did not
initiate the connection sets its MSB to 0.
The Circuit ID value 0 is specifically reserved for cells that do not belong to any circuit or stream: Circuit ID 0 must not be used for circuits or streams.  No other Circuit ID value is reserved.

## Commands

Command|ID|Description|Type
-------|--|-----------|----
Padding|1|[Padding, keep-alive cell padding](padding.md)|Fixed
Create|2|[Create a circuit](create.md)|Fixed
Created|3|[Acknowledge circuit creation](created.md)|Fixed
Destroy|4|[Destroy circuit](destroy.md)|Fixed
Relay|5|[Relay data on a circuit](relay.md)|Fixed
Versions|128|[Negotiate protocol versions](versions.md)|Variable
AuthBypass|129|[Bypass authentication](authbypass.md)|Variable
Certs|130|[Deliver certificates](certs.md)|Variable
AuthChallenge|131|[Authentication challenge](authchallenge.md)|Variable
Authenticate|132|[Authentication](authenticate.md)|Variable
StreamCreate|133|[Create a stream](streamcreate.md)|Variable
StreamRelay|134|[Relay data on a stream](streamrelay.md)|Variable
StreamDestroy|135|[Destroy a stream](streamdestroy.md)|Variable
StreamCreated|136|[Acknowledge stream creation](streamcreated.md)|Variable
