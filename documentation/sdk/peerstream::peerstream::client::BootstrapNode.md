# struct `peerstream::peerstream::client::BootstrapNode` {#structpeerstream_1_1peerstream_1_1client_1_1_bootstrap_node}

## Summary

 Members                        | Descriptions                                
--------------------------------|---------------------------------------------
`public std::string `[`fingerprint`](#structpeerstream_1_1peerstream_1_1client_1_1_bootstrap_node_1adf959e4564f7c46757368d80905ac818) | Fingerprint of node, as a hex string.
`public std::string `[`handshakeKey`](#structpeerstream_1_1peerstream_1_1client_1_1_bootstrap_node_1a2427e6875623bf33f78b9f6f6e95442e) | Handshake key of node, as a hex string.
`public std::vector< std::string > `[`addresses`](#structpeerstream_1_1peerstream_1_1client_1_1_bootstrap_node_1a21e29388d341470804133ba38e63d159) | Vector of addresses of node, as a host:port string e.g.: discovery:6996
`public std::string `[`identity`](#structpeerstream_1_1peerstream_1_1client_1_1_bootstrap_node_1acaa943185c5980c19817fc78b5e05cfa) | Identity of node in PKI Identity format e.g.: namespace.sub-namespace.type.base58Hash
`public std::string `[`mode`](#structpeerstream_1_1peerstream_1_1client_1_1_bootstrap_node_1abfc19519f9f7544a4966699c2722dde3) | Mode of this node. Possible current values: client, onion, discovery, auth, oracle

## Members

#### `public std::string `[`fingerprint`](#structpeerstream_1_1peerstream_1_1client_1_1_bootstrap_node_1adf959e4564f7c46757368d80905ac818) {#structpeerstream_1_1peerstream_1_1client_1_1_bootstrap_node_1adf959e4564f7c46757368d80905ac818}

Fingerprint of node, as a hex string.

#### `public std::string `[`handshakeKey`](#structpeerstream_1_1peerstream_1_1client_1_1_bootstrap_node_1a2427e6875623bf33f78b9f6f6e95442e) {#structpeerstream_1_1peerstream_1_1client_1_1_bootstrap_node_1a2427e6875623bf33f78b9f6f6e95442e}

Handshake key of node, as a hex string.

#### `public std::vector< std::string > `[`addresses`](#structpeerstream_1_1peerstream_1_1client_1_1_bootstrap_node_1a21e29388d341470804133ba38e63d159) {#structpeerstream_1_1peerstream_1_1client_1_1_bootstrap_node_1a21e29388d341470804133ba38e63d159}

Vector of addresses of node, as a host:port string e.g.: discovery:6996

#### `public std::string `[`identity`](#structpeerstream_1_1peerstream_1_1client_1_1_bootstrap_node_1acaa943185c5980c19817fc78b5e05cfa) {#structpeerstream_1_1peerstream_1_1client_1_1_bootstrap_node_1acaa943185c5980c19817fc78b5e05cfa}

Identity of node in PKI Identity format e.g.: namespace.sub-namespace.type.base58Hash

#### `public std::string `[`mode`](#structpeerstream_1_1peerstream_1_1client_1_1_bootstrap_node_1abfc19519f9f7544a4966699c2722dde3) {#structpeerstream_1_1peerstream_1_1client_1_1_bootstrap_node_1abfc19519f9f7544a4966699c2722dde3}

Mode of this node. Possible current values: client, onion, discovery, auth, oracle

