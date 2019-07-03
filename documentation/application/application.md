# PSP Application level protocols

## Definition

PSP Application level protocol is used by PSP clients to perform higher-level operations such as registering their presence at the system,
announcing their media streams, and creating secure channels to each other.  Various parts of the system are using the application level
to communicate, including the [DHT](dht.md) subsystem, the [authority](authority.md) subsystem, and the [discovery](discovery.md) system.

## Operation

Application level protocol operates on top of onion level [streams](../flows/streams.md) protocol or onion [circuits](../flows/circuits.md) protocol.
The client or the node uses a [stream relay](../binary/streamrelay.md) cell with streams or [relayed escape](../relay/escape.md) cell with circuits
to tell the onion level to pass the data sent to the upper application level for processing.  Inside those cells lays serialized
[application message](applicationmessage.md) carrying the event ID and the even body.

## Payload

        Event ID                [2 bytes; big-endian unsigned integer]
        Event Body              [variable size; protobuf serialized event body]

## Events

Not all the events are supported by all node types.  Some of the events could only be used in circuits, some only in streams, some in both.
Below is the table listing all application level events accessible for the clients.  The DHT protocol events are not exposed externally and only
operate within authorized streams between onion nodes.

Event|ID|Circuit|Stream namespace|Received from|Delivered to
-----|--|---------------|----------------|-------------|------------
[Announce Presence](announcepresence.md)|1|:white_check_mark:|:x:|Client|Onion node
[Announcement Result](announcementresult.md)|2|:white_check_mark:|:x:|Onion node|Client
[Lookup Presence](lookuppresence.md)|3|:white_check_mark:|:x:|Client|Onion node
[Lookup Result](lookupresult.md)|4|:white_check_mark:|:x:|Onion node|Client
[Forward Presence Request](forwardpresence.md)|5|:white_check_mark:|:x:|Client|Onion node
[Forward Presence Result](forwardpresenceresult.md)|6|:white_check_mark:|:x:|Onion node|Client
[Request Certificate](requestcertificate.md)|1000|:white_check_mark:|Authority|ANY|Authority node
[Request Certificate Result](certificateresult.md)|1001|:white_check_mark:|Authority|Authority node|ANY
[Discovery Pull List](discoverypull.md)|2001|:x:|Discovery|ANY|Discovery node, onion node
[Discovery Directory](discoverydirectory.md)|2002|:x:|Discovery|Discovery node, onion node|ANY
[Discovery Publish](discoverypublish.md)|2003|:x:|Discovery|Any node|Discovery node