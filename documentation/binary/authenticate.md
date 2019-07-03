# Authenticate cell

`Authenticate` is a variable size cell containing the authentication response from the initiator.
If an initiator wants to authenticate, it responds to the AuthChallenge cell with a Certs cell and an Authenticate cell.

## Payload

An Authenticate cell contains the following:

        AuthType                              [2 bytes; big-endian unsigned integer]
        AuthLen                               [2 bytes; big-endian unsigned integer]
        Authentication                        [AuthLen bytes]

Responders must ignore extra bytes at the end of an `Authenticate` cell.

Initiators must not send an `Authenticate` cell before they have verified the certificates presented
in the responders `Certs` cell, and authenticated the responder.

## Supported methods

Method|Value|Description
------|-----|-----------
[RSASHA256TLSSecret](RSASHA256TLSSecret.md)|1|Default auth method

[All cells](cell.md)