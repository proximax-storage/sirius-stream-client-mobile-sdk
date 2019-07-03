# Circuits

## Introduction

In an anonymous system, circuits provide a mechanism for communicating with an aspect of the system while providing one or more hops. This can be done in a secure mode, which uses 3 hops, or an insecure mode, which uses 1 hop per circuit.

## Building Guidelines

Building a circuit, a client would connect to an intermediate hop, which it performs a key exchange with. It then does the same by asking the node to extend to an additional node specified by the client, of which an additional key exchange is performed, of which the payload is encrypted by the client, so only the intended recipient can handshake with in order to exchange public keys. This extend is done one more time, this time using both of the first two nodes as a pass through, encrypting each level like an onion and then decrypting each when it comes back, in order to exchange keys with a final intended target. The client and this final node can then message each other using this three-level onion encryption to avoid any middle parties from understanding the payload.

### Entrance node selection

The selection of entrance nodes happens in a well-defined way. First, a client connects to the onion network, using one or more bootstrap nodes. The client then obtains discovery information about all the nodes in the network. The client then uses a strong random number generator to choose M entrance nodes at random of the N nodes that are available. Typically, M should be between 3 and 20. It then uses these nodes as the sole entry points to the onion network maintaining that list persistent between
relaunching the application. Periodically, it should select a new set of entrance nodes. Note: A strong random number generator typically uses a random mechanism that has a source of entropy.

### Presence node selection

At startup, a client will choose a set of P presence nodes. This value is configurable, but the default is three. These presence nodes are then held for a certain period of time and are used for presence announcements and forward presence requests only. All other messages should not be sent through a presence circuit.

### Situations with multiple presence announcements

In the announcement, the fingerprint of the presence node is used as part of the announcement. For a client looking up presence, they would then receive 1..N lookup results of announcements. The client should choose the announcement with the latest expiration time and then use this information to create a new circuit to the presence node to request meeting at the rendezvous node (forward presence request).

### Discovery node selection

Discovery should use the shortest route. At startup, the client bootstraps from a list of known nodes. The number of nodes is configurable. It reaches to 1..N of those nodes, from the list of entry nodes. It then creates a stream directly to each and pulls discovery. Anonymity is not required for this first step since there is no identifiable information that is in any of the packets.

Additionally, a client could pull the discovery listing from any other node which it has an active circuit to during runtime. This can avoid creating a new circuit in order to refresh the discovery list. The discovery directory, itself, will have an expiration on it. Client should request a new list just prior to the old one expiring.

### Fault tolerance

Upon any node going offline and therefore destroying circuits that have this node as one of the hops, the client should attempt to reconnect to the network, recreating destroyed circuits using a different set of random intermediate nodes to reach the endpoint. If the node that has gone offline is the endpoint, then it should choose a different endpoint for that particular purpose that is of the same type. The current list of types includes onion nodes, authentication nodes, discovery nodes and oracle nodes.

## Reuse Logic Specification

This section defines which circuits are allowed to perform what operation. There are various types of circuits. Each section will define the type of circuit, what this means in terms of the application, and whether the circuit can be reused for any other purposes.

### Registering with an Auth Node

For secure communication, registration with an auth node happens with the auth node being the last node of the circuit. Registration is a one-off operation and this circuit should not be reused after registration is complete.

### Presence Announcements

For a presence announcement, these circuits are reused for a given amount of time. Just before expiration time which is configurable, the client should re-announce presence to this circuit. This circuit should not be used for messages other than presence announcements, and receipt of a forward presence request.

### Presence Lookups

Presence lookups are a one-off operation. A client will create a brand new circuit to perform a presence lookup. It will then perform the lookup, receive the lookup result. Any further messages other than padding cells will result in the circuit being destroyed.

### Rendezvous

A client can join a rendezvous node either by being the one who establishes the rendezvous node, known as the initiator, or by being the one who joined after receiving a forward presence request. This node is then kept alive for the entirety of the conversation between two clients. It expires only when one of the clients terminate the connection, at which point the other client will be notified that the circuit has been destroyed.

This rendezvous circuit cannot be used for presence messages, auth messages or for a separate rendezvous with a different client. Any attempt to send these disallowed messages will result in the circuit being destroyed for all parties.

### Discovery

Circuits which we query discovery from can be used for other purposes, so we could just get the listing from acting circuits after startup.
