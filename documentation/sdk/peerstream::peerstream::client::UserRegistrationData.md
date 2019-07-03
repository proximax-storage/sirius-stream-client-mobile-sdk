# struct `peerstream::peerstream::client::UserRegistrationData` {#structpeerstream_1_1peerstream_1_1client_1_1_user_registration_data}

Data returned when a user registers. This should be stored securely by the client SDK

## Summary

 Members                        | Descriptions                                
--------------------------------|---------------------------------------------
`public `[`ClientIdentity`](doxygen/md/ClientIdentity.md#structpeerstream_1_1peerstream_1_1client_1_1_user_registration_data_1af6c43ee0b9b8237106832d3ea7b2c252)` `[`identity`](#structpeerstream_1_1peerstream_1_1client_1_1_user_registration_data_1a5c6c3046dd46385353c4474cb6aba95e) | Identity of the user. Generally represented in the following way: peerstream.client.account.XzNvt72twcU4fzYfGMnDccfkZKkURQQJFBxS9xCtyUdSyaKFG Consists of the following parts:
`public `[`Ed25519SecretKeyString`](doxygen/md/Ed25519SecretKeyString.md#structpeerstream_1_1peerstream_1_1client_1_1_user_registration_data_1a929c9efdcfd40a0ed9375d5afd833787)` `[`masterSecKey`](#structpeerstream_1_1peerstream_1_1client_1_1_user_registration_data_1aa300c00bcaebbb2a29d026765e22db94) | Private Ed25519 master key.
`public `[`Ed25519SecretKeyString`](doxygen/md/Ed25519SecretKeyString.md#structpeerstream_1_1peerstream_1_1client_1_1_user_registration_data_1a929c9efdcfd40a0ed9375d5afd833787)` `[`signingSecKey`](#structpeerstream_1_1peerstream_1_1client_1_1_user_registration_data_1aa9992230fcc24cc3efd2368f6f265cc7) | Private Ed25519 signing key.
`public `[`RawCertificate`](doxygen/md/RawCertificate.md#structpeerstream_1_1peerstream_1_1client_1_1_user_registration_data_1ab21fa7dd44b3c20c74c265cd38fc7c1c)` `[`cert`](#structpeerstream_1_1peerstream_1_1client_1_1_user_registration_data_1a22d1b28aed8f7b092a6c7ff15864cffd) | Certificate created upon registration.
`typedef `[`ClientIdentity`](#structpeerstream_1_1peerstream_1_1client_1_1_user_registration_data_1af6c43ee0b9b8237106832d3ea7b2c252) | 
`typedef `[`Ed25519SecretKeyString`](#structpeerstream_1_1peerstream_1_1client_1_1_user_registration_data_1a929c9efdcfd40a0ed9375d5afd833787) | 
`typedef `[`RawCertificate`](#structpeerstream_1_1peerstream_1_1client_1_1_user_registration_data_1ab21fa7dd44b3c20c74c265cd38fc7c1c) | 

## Members

#### `public `[`ClientIdentity`](doxygen/md/ClientIdentity.md#structpeerstream_1_1peerstream_1_1client_1_1_user_registration_data_1af6c43ee0b9b8237106832d3ea7b2c252)` `[`identity`](#structpeerstream_1_1peerstream_1_1client_1_1_user_registration_data_1a5c6c3046dd46385353c4474cb6aba95e) {#structpeerstream_1_1peerstream_1_1client_1_1_user_registration_data_1a5c6c3046dd46385353c4474cb6aba95e}

Identity of the user. Generally represented in the following way: peerstream.client.account.XzNvt72twcU4fzYfGMnDccfkZKkURQQJFBxS9xCtyUdSyaKFG Consists of the following parts:

* namespace

* sub namespace

* identity/node type (only client will be valid for this)

* base58 hash of public signing key along with checksum

#### `public `[`Ed25519SecretKeyString`](doxygen/md/Ed25519SecretKeyString.md#structpeerstream_1_1peerstream_1_1client_1_1_user_registration_data_1a929c9efdcfd40a0ed9375d5afd833787)` `[`masterSecKey`](#structpeerstream_1_1peerstream_1_1client_1_1_user_registration_data_1aa300c00bcaebbb2a29d026765e22db94) {#structpeerstream_1_1peerstream_1_1client_1_1_user_registration_data_1aa300c00bcaebbb2a29d026765e22db94}

Private Ed25519 master key.

#### `public `[`Ed25519SecretKeyString`](doxygen/md/Ed25519SecretKeyString.md#structpeerstream_1_1peerstream_1_1client_1_1_user_registration_data_1a929c9efdcfd40a0ed9375d5afd833787)` `[`signingSecKey`](#structpeerstream_1_1peerstream_1_1client_1_1_user_registration_data_1aa9992230fcc24cc3efd2368f6f265cc7) {#structpeerstream_1_1peerstream_1_1client_1_1_user_registration_data_1aa9992230fcc24cc3efd2368f6f265cc7}

Private Ed25519 signing key.

#### `public `[`RawCertificate`](doxygen/md/RawCertificate.md#structpeerstream_1_1peerstream_1_1client_1_1_user_registration_data_1ab21fa7dd44b3c20c74c265cd38fc7c1c)` `[`cert`](#structpeerstream_1_1peerstream_1_1client_1_1_user_registration_data_1a22d1b28aed8f7b092a6c7ff15864cffd) {#structpeerstream_1_1peerstream_1_1client_1_1_user_registration_data_1a22d1b28aed8f7b092a6c7ff15864cffd}

Certificate created upon registration.

#### `typedef `[`ClientIdentity`](#structpeerstream_1_1peerstream_1_1client_1_1_user_registration_data_1af6c43ee0b9b8237106832d3ea7b2c252) {#structpeerstream_1_1peerstream_1_1client_1_1_user_registration_data_1af6c43ee0b9b8237106832d3ea7b2c252}

#### `typedef `[`Ed25519SecretKeyString`](#structpeerstream_1_1peerstream_1_1client_1_1_user_registration_data_1a929c9efdcfd40a0ed9375d5afd833787) {#structpeerstream_1_1peerstream_1_1client_1_1_user_registration_data_1a929c9efdcfd40a0ed9375d5afd833787}

#### `typedef `[`RawCertificate`](#structpeerstream_1_1peerstream_1_1client_1_1_user_registration_data_1ab21fa7dd44b3c20c74c265cd38fc7c1c) {#structpeerstream_1_1peerstream_1_1client_1_1_user_registration_data_1ab21fa7dd44b3c20c74c265cd38fc7c1c}

