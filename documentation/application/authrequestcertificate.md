# Auth Request Certificate

## Definition

This mesasge provides a mechanism for requesting, from an auth node, that a particular user be given a certificate that can be used for verifying identity for a given interval.

## Operation

In order to use this mechanism, you must have a generated public and private master key. From that point, you can then do the following:

1. Generate a pki identity, which is compromised of the following: `namespace.sub-namespace.identity-type.master-key-public`. These fields are defined elsewhere in the documentation (TBD?)

C++ Example:

```
PkiIdentity pkiIdent(
    pspClientNs, pspClientSubNs, IdentityType::account, masterKey.publicKey());
```

2. Generate a flat certificate using the identity, and a specific duration, using the master key.

C++ Example:

```
FlatCertificate stub(
    container_, pk, pkiIdent.full(), nullptr, certificateDuration, masterKey);
```

3. Generate a signed ed25519 key pair, using a generated signing key and bundling it with the flat certificate

C++ Example:

```
SignedEd25519KeyPair kp(
Ed25519KeyPair{randGen_, signingKey.secretKey(), signingKey.publicKey()},
stub);
```

4. Create a signed message using a specified auth version and the signed key pair.

C++ Example:

```
SignedMessage sm(container_, authVersion, kp);
```

5. The signed message is then marshalled to bytes and used as the payload of the auth request certificate.

C++ Example:

```
AuthRequestCertificate msg;
auto rawData(sm.data());
msg.set_certificatestub(string(rawData.begin(), rawData.end()));
```

## Payload

### AuthRequestCertificate

ID|Name|Type|Desc
--|----|----|----
1|certificateStub|bytes|A signed message marshalled to bytes
