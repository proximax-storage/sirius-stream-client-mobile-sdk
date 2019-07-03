# RSA-SHA256-TLSSecret authentication type

If AuthType is 1 (meaning "RSA-SHA256-TLSSecret"), then the
Authentication field of the Authenticate cell contains the following:

Field|Description|Length in bytes
-----|-----------|---------------
Type|The characters "AUTH0001"|8
ClientIdentityKey|A SHA256 hash of the initiators RSA identity key|32
ServerIdentityKey|A SHA256 hash of the responders RSA identity key|32
ServerLogHash|A SHA256 hash of all bytes sent from the responder to the initiator as part of the negotiation up to and including the AuthChallenge cell; that is, the Versions cell, the Certs cell, the AuthChallenge cell, and any padding cells|32
ClientLogHash|A SHA256 hash of all bytes sent from the initiator to the responder as part of the negotiation so far; that is, the Versions cell and the Certs cell and any padding cells|32
ServerLinkCert|A SHA256 hash of the responders TLS link certificate|32
TLSKeyMaterial|A connection key ring material as defined in [RFC 5705](https://tools.ietf.org/html/rfc5705) using "EXPORTER: PSP handshake" as a label and NUL-terminated string "PSP handshake TLS cross-certification\x00" as a context|32
Rand|A 24 byte value, randomly chosen by the initiator|24
Signature|A signature of a SHA256 hash of all the previous fields using the initiator's "Authenticate" key as presented|variable

To check the Authenticate cell, a responder checks that all fields
from Type through TLSKeyMaterial contain their unique correct values as described above,
and then verifies the signature.

[All cells](cell.md)