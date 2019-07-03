# PSP Default Create handshake

## Create Cell Handshake Payload

Field|Description|Length in bytes
-----|-----------|---------------
Fingerprint|A SHA256 hash of the node's RSA identity key|32
Node Key|A node's Curve25519 public handshake key|32
Client Key|A client's temporary Curve25519 public key|32

## Created Cell Handshake Payload

Field|Description|Length in bytes
-----|-----------|---------------
Node key|Node's temporary Curve25519 public key Y|32
Auth|H(auth_input, t_mac) as specified below|32

## Handshake

Default handshake uses a set of DH handshakes to compute a set of shared keys which the client knows are shared only with a particular
server, and the server knows are shared with whomever sent the original handshake.

In this section, define:

    H(x,t) as HMAC_SHA256 with message x and key t
    PROTOID   = "psp-curve25519-sha256-01"
    t_mac     = PROTOID | ":mac"
    t_key     = PROTOID | ":key_extract"
    t_verify  = PROTOID | ":verify"
    EXP(a,b)  = scalar multiplication of the curve25519 point 'a' by the scalar 'b'
    KEYGEN()  = The curve25519 key generation algorithm, returning a private/public keypair.
    m_expand  = PROTOID | ":key_expand"

To perform the handshake, the client needs to know an identity key digest for the node, and a node handshake key (a curve25519 public
key). Call the node handshake key "B".  The client generates a temporary keypair x,X = KEYGEN() and generates a client-side handshake
with payload specified above.

The node generates a keypair of y,Y = KEYGEN(), and uses its handshake private key 'b' to compute:

    secret_input = EXP(X,y) | EXP(X,b) | ID | B | X | Y | PROTOID
    verify = H(secret_input, t_verify)
    auth_input = verify | ID | B | Y | X | PROTOID | ":server"
    KEY_SEED = KDF(secret_input, t_key)

Node responds with a Created cell with payload specified above. The client then computes:

    secret_input = EXP(Y,x) | EXP(B,x) | ID | B | X | Y | PROTOID
    verify = H(secret_input, t_verify)
    auth_input = verify | ID | B | Y | X | PROTOID | ":server"
    KEY_SEED = KDF(secret_input, t_key)

The client then verifies that AUTH == H(auth_input, t_mac).

Both parties now have a shared value for KEY_SEED.  They expand this into the keys needed for the relay protocol,
using the KDF function described below.

## KDF

PSP uses the key derivation function HKDF from [RFC 5869](https://tools.ietf.org/html/rfc5869),
instantiated with SHA256 with info m_expand, salt t_key, and secret secret_input.
The generated key material is:

    K = K_1 | K_2 | K_3 | ...

When used in PSP handshake, the first 20 bytes form the forward digest Df; the next 20 form the backward digest Db;
the next 16 form forward key Kf, the next 16 form backward key Kb.  Excess bytes from K are discarded.

[All cells](cell.md)