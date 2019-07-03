# Circuits

## Purpose

Circuits in PSP are used to anonymize the client traffic forwarding the flow over several different nodes until it reaches the final
target.  Nodes do not use circuits to communicate to each other, client can use circuits or streams depending on a level of anonymity
required.  General rules for circuit usage is [described here](circuitlogic.md).

## Circuit creation

Clients set up circuits incrementally, one hop at a time. To create a new circuit, client sends a [create cell](../binary/create.md) to the first node,
with the first half of an authenticated handshake; that node responds with a [created cell](../binary/created.md) with the second half of the handshake.
To extend a circuit past the first hop, the client sends an [extend relay cell](../relay/extend.md) which instructs the last node in the circuit to send
a [create cell](../binary/create.md) to extend the circuit.

## Circuit data delivery

Clients are able to relay data on existing circuits using [relay cells](../binary/relay.md) with various [relay commands](../relay/command.md).  Encryption
and decryption process for all the data passing the circuit is described in [this section](../relay/relaycrypto.md).

## Switching from the onion to the application level

Clients use [escape relay cell](../relay/escape.md) to switch from the onion level to the top application level.  The `escape` cell payload is a full or a part of an
[application message](../application/message.md) format carrying the [application specific payload](../application/application.md).

## Usage in rendezvous communication

Established circuits could be used to form a [rendezvous circuit](../relay/rendezvous.md) to connect two clients directly with end to end encrypted channel.