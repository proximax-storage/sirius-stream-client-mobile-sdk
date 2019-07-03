# Rendezvous circuit

Rendezvous circuit is used by two clients to establish a secure anonymous end to end encrypted circuit through one or multiple nodes.

## Establishing the rendezvous point

In order to establish the rendezvous point the client creates a new circuit, chooses a new rendezvous cookie (using SHA256 over 32 random bytes) and sends a [establish rendezvous](establishrendezvous.md) cell
towards the last node on a circuit.  If node confirms creation of the rendezvous circuit it then responds with [rendezvous established](rendezvousestablished.md) cell back.

## Inviting the other user to join

After the rendezvous point is established, in order to invite another client to join it, client creates a first part of the handshake material, and it sends out to the other client using the
[forward presence](../application/forwardpresence.md) application level message.  If another client decides to respond to the invitation it creates his own circuit ending it up with the node
hosting the rendezvous point, creates his part of the handshake response and sends it out in form of [join rendezvous](joinrendezvous.md) cell.  If join process succeeds the corresponding node
responds by sending [rendezvous joined 1](rendezvousjoined1.md) cell back to the joining user and forwarding the handshake response in [rendezvous joined 2](rendezvousjoined2.md) cell to the user
owning the rendezvous point.  Both clients use handshake material to form their set of forward and backward keys and use those keys to encrypt all the information sent via the rendezvous circuit.

## Rendezvous handshake

### Legend

Name|Type|Description|Side
----|----|-----------|----
Announcer|client|Client announcing his presence/online status on the system|
Communicator|client|Client reaching out to the announcer in order to create a rendezvous circuit|
Announcer Key|ed25519 key|Temporary key announced as part of the presence announcement|Announcer
Announcer Identity|PSP identity|PSP client identity of the announcer|Announcer
Introduce Request||A request from communicator to the announcer containing required material for him to join the rendezvous point|Communicator

### Initial handshake material and Introduce request

Initial handshake material payload:

        Cookie                      [32 bytes; rendezvous point cookie]
        Fingerprint                 [32 bytes; rendezvous point node fingerprint]
        Handshake key               [32 bytes; rendezvous point node handshake key]
        [N] Link specifications     [1 byte; amount of link specifications attached]
            [N times]               [Variable bytes - Link specification in "extend" cell format]

After creating the initial handshake payload, communicator wraps it into [signed message](../application/message.md) and encrypts it with the temporary handshake key as follows:

In this section define

    HSHandshakeProtoID    = "psp-hs-curve25519-sha256-01"
    HSHandshakeKey        = HSHandshakeProtoID + ":hs_key_extract"
    HSHandshakeVerify     = HSHandshakeProtoID + ":hs_verify"
    HSHandshakeMac        = HSHandshakeProtoID + ":hs_mac"
    HSHandshakeExpand     = HSHandshakeProtoID + ":hs_key_expand"
    HSHandshakeAuthSuffix = ":server"
    HSHashSize            = 32
    HSStreamCipherKeySize = 16

Client generates a keypair of `x,X = NewED25519()`, and uses announcer public key 'B' and announcer identity 'ID' to compute:

    secret_input = EXP(B,x) | ID | X | B | HSHandshakeProtoID

Client then uses the key derivation function HKDF from [RFC 5869](https://tools.ietf.org/html/rfc5869),
instantiated with SHA256 with info `HSHandshakeExpand`, salt `HSHandshakeKey`, and secret `secret_input`.

    KDF = Encode Key (HSStreamCipherKeySize) | MAC Key (HSHashSize)

Client then creates a new AES 128 cypher using all zeros as an IV and `Encode Key` as the key and encrypts the initial handshake material using this cypher.

After encrypting the initial handshake material client creates an introduce request which he can deliver to the announcer.

        Identity Length                             [2 bytes; big-endian unsigned integer]
        Announcer Identity                          [Identity length bytes]
        Announcer Key                               [32 bytes]
        Client Key (X)                              [32 bytes]
        Initial Encrypted Handshake Material Length [2 bytes; big-endian unsigned integer]
        Initial Encrypted Handshake Material        [Length bytes]
        MAC                                         HMAC_SHA256 of all fields using "MAC Key" as a key

### Reading introduce request, creating handshake response and rendezvous circuit keys

After receiving the introduce request the announcer then calculates following:

    secret_input = EXP(X,b) | ID | X | B | HSHandshakeProtoID

Then creates HKDF function similarly with communicator and creates the key and the MAC key.  Announcer then uses the keys to decode tha
encrypted payload and verify the MAC value.

If MAC verification passes, client is able to read the signed message correctly, and decides to respond to the introduce request
announcer then generates a new keypair of `y,Y = NewED25519()`, and calculates following:

    secret_input = EXP(X,y) | EXP(X,b) | ID | B | X | Y | HSHandshakeProtoID
    verify = H(secret_input, HSHandshakeVerify)
    auth_input = verify | ID | B | Y | X | HSHandshakeProtoID | HSHandshakeAuthSuffix
    KEY_SEED = KDF(secret_input, t_key)

Client then uses the key derivation function HKDF, instantiated with SHA256 with info `HSHandshakeExpand`,
salt `HSHandshakeKey`, and secret `secret_input`. Client then builds circuit keys similarly with
[create handshake](../binary/createhandshake.md) key generation.

Announcer then creates a [join rendezvous](joinrendezvous.md) cell with following `Handshake` payload:

        Circuit Keypair (Y)             [32 bytes]
        Auth input (auth_input)         [Auth len bytes]

### Reading handshake response and using the circuit

Communicator, receiving the handshake response in [rendezvous joined 2](rendezvousjoined2.md) cell, calculates following:

    secret_input = EXP(Y,x) | EXP(B,x) | ID | B | X | Y | HSHandshakeProtoID
    verify = H(secret_input, HSHandshakeVerify)
    auth_input = verify | ID | B | Y | X | HSHandshakeProtoID | HSHandshakeAuthSuffix
    KEY_SEED = KDF(secret_input, t_key)

Using the `secret_input` and `auth_input` values communicator verifies the authentication and creates corresponding set of keys.
Communicator uses forward key and forward digest for encrypting the outgoing cells on a circuit and announcer does the opposite
using forward digest and forward key for receiving cells from the circuit.  The encryption on the circuit itself matches the
[encryption on a circuit](relaycrypto.md) with the exception of using the rendezvous keys as an origin layer of encryption and then
the first node keys as a next hop on a circuit.

[Relay commands](command.md)