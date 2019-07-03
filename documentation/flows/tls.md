# TLS connection and initial handshake in PSP

## TLS connection

Connections between two nodes, or between a client and a node, use TLS/SSLv3 for link authentication and encryption.
After the initial TLS negotiation completes, parties perform additional in-protocol post-TLS handshake
and optionally additionally authenticate themselves.
TLS connections are not permanent. Either side may close a connection if there are no circuits or streams running over it
and an amount of time has passed since the last time any circuit or stream existed on the TLS connection.  Clients should
hold a TLS connection with no circuits or streams open, if it is likely that a client will soon be using that connection.
Both parties keep the connections alive periodically sending [keep alive](../binary/padding.md) packets if there are no other
information been sent out over the connection.
Node and client implementation must not allow TLS session resumption, TLS tickets, and TLS session compression.
After the initial TLS connection is established all communication over the pipe is performed in [cells format](../binary/cell.md).

## Post TLS handshake

After two instances negotiate the TLS handshake and establish the connection they must exchange cells to make the connection valid
and useful for streams and circuits.
The handshake starts from the initiating side sending the [versions cell](../binary/versions.md). The responding party replies to the
`versions` cell with its own `versions` cell and both parties negotiate the higher available version of the protocol to use.
After negotiating the versions the responding side sends the [certs cell](../binary/certs.md) containing one `link` certificate and one `identity`
certificate of the responder immediately followed by the [auth challenge cell](../binary/authchallenge.md). `Auth challenge` cell contains
the list of supported authentication methods initiator can use to continue the handshake.
Upon receiving the `certs` cell initiator validates that:

- The `certs` cell contains exactly one `identity` certificate.
- The `certs` cell contains exactly one `link` certificate.
- All certificates are correctly signed.
- All X.509 certificates above have `validAfter` and `validUntil` dates.
- The certified key in the `link` certificate matches the key of the certificate that was used to authenticate the TLS connection.
- The `link` certificate was signed with the key listed in `identity` certificate.
- The `identity` certificate is correctly self signed.
- The `identity` RSA key bit count is 1024 or above.

Checking these conditions is sufficient to confirm that the responding node identity matches its identity certificate.

If the responding party supports `AllowBypass` authentication method at this moment the initiating side could send the [auth bypass](../binary/authbypass.md)
cell to bypass the initiator authentication and connect anonymously. All client apps must connect to all nodes anonymously and terminate connection
if the remote side does not support bypassing authentication.

If the initiating party decides to authenticate, after validating the responder identity, it responds with its own `certs` cell containing one `identity`
and one `authenticate` certificate. Immediately after sending the `certs` cell initiator sends the [authenticate cell](../binary/authenticate.md) performing
the [authentication procedure](../binary/RSASHA256TLSSecret.md).

Upon receiving the `certs` cell responding side validates that:

- The `certs` cell contains exactly one `identity` certificate.
- The `certs` cell contains exactly one `authenticate` certificate.
- All certificates are correctly signed.
- All X.509 certificates above have `validAfter` and `validUntil` dates.
- The `authenticate` certificate was signed with the key listed in `identity` certificate.
- The `identity` certificate is correctly self signed.
- The `identity` RSA key bit count is 1024 or above.

If following checks are valid the responder additionally verifies that all fields their unique correct values as [described](../binary/RSASHA256TLSSecret.md),
and then verifies the signature. The responder must ignore any extra bytes in the signed data.

Once authentication is completed or bypassed the connection considered ready to use for streams and circuits. Clients should reuse existing TLS connections
for different circuits and streams they may create, nodes will reuse authenticated TLS connections when required and will never reuse not authenticated connections.