# StreamCreate cell

StreamCreate variable size cell is used by node or client to create a new namespaced virtual stream on top of existing TLS connection.  Virtual streams do not provide any additional encryption on top of the existing TLS pipe and only rely on the initial RSA handshake and node fingerprint verification (if any).

Node will respond to the inbound `StreamCreate` request with either [`StreamCreated`](streamcreated.md) confirmation or [`StreamDestroy`](streamdestroy.md) refusal.  Clients must respond with `StreamDestroy` on every
inbound stream creation request.

## Payload

    Namespace                [4 bytes; big-endian unsigned integer]
    Subcommand               [optional; 4 bytes; big-endian unsigned integer]
    Cookie                   [optional; variable size]

## Usage in media streams

For nodes supporting media streaming protocols (`namespace 5`) the `StreamCreate` cell can contain two additional fields - `Subcommand` and `Cookie`. Using those
additional parameters clients can form fan-out type of streams with single broadcaster and multiple viewers.  Additional detail is available at [media streaming section](../flows/media.md).

[All cells](cell.md)