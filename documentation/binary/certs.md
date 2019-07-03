# Certs cell

`Certs` variable length cell describes the keys the node or client is claiming to have.
It is sent from both initiating and responding sides as a beginning of
the handshake. `Certs` cell is not sent if authentication is bypassed.

## Payload

        N Number of certs in cell             [1 byte]
        N times
           CertType                           [1 byte]
           CLEN                               [2 bytes; big-endian unsigned integer]
           Certificate                        [CLEN bytes]

Any extra octets at the end of a `Certs` cell must be ignored.

## Supported certType values

Type|ID|Key type|Description|Side
----|--|--------|-----------|----
Link|1|RSA 1024|Node link certificate signed with identity key|Responder
Identity|2|RSA 1024|Node identity certificate, self-signed|Responder and Initiator
Authenticate|3|RSA 1024|Node authentication certificate signed with identity key|Initiator

The certificate format for certificate types 1-3 is DER encoded X509.
`Certs` cell may have no more than one certificate of each `CertType`.

[All cells](cell.md)