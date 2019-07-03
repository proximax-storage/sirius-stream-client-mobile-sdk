# PSP Authority level protocols

## Definition

PSP Authority level protocols are used for higher-level operations such as requesting an auth certificate for a valid user. This operation can be thought of as "logging in" and then the returned certificate can be conceptually thought of as a "token", which gives a shorter path for using the system for the duration of the system which doesn't required re-requesting a new certificate until the existing certificate expires. However, in common operation, the initiator will re-request a new certificate at any point before the expiration of the certificate, which is the recommended usage.

## Operation

The authority level protocol operates on top of onion level streams protocol or onion circuits protocol. The client or the node uses a stream relay cell with streams or relayed escape cell with circuits to tell the onion level to pass the data sent to the upper authority level for processing. Inside those cells lays serialized authority message carrying the event ID and the even body.

## Payload

        Event ID                [2 bytes; big-endian unsigned integer]
        Event Body              [variable size; protobuf serialized event body]

## Events

Event|ID|Circuit|Stream namespace|Received from|Delivered to
-----|--|---------------|----------------|-------------|------------
[Auth Request Certificate](authrequestcertificate.md)|1|:white_check_mark:|:x:|Client|Auth node
[Auth Request Certifictae Result](authrequestcertificateresult.md)|2|:white_check_mark:|:x:|Auth node|Client
