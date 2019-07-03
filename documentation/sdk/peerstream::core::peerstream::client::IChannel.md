# class `peerstream::core::peerstream::client::IChannel` {#classpeerstream_1_1core_1_1peerstream_1_1client_1_1_i_channel}

A channel represents a conceptual (but indirect) connection to another client. It is a conceptual wrapper around a group of circuits, where underneath the hood, a client creates a circuit which ends in a rendezvous node.

## Summary

 Members                        | Descriptions                                
--------------------------------|---------------------------------------------
`public inline virtual  `[`~IChannel`](#classpeerstream_1_1core_1_1peerstream_1_1client_1_1_i_channel_1a10c5144bcad5a72a3bfe8a204596ca29)`()` | 
`public void `[`sendRawData`](#classpeerstream_1_1core_1_1peerstream_1_1client_1_1_i_channel_1a2905711d424c3e5aa9661e796e660e1e)`(const std::vector< uint8_t > & rawData)` | 
`public void `[`sendMessage`](#classpeerstream_1_1core_1_1peerstream_1_1client_1_1_i_channel_1a67181349d8ac1ba2190f0512f308b443)`(const std::string & msg)` | 
`public void `[`closeChannel`](#classpeerstream_1_1core_1_1peerstream_1_1client_1_1_i_channel_1a8d1d4f17ab7751779ab42d160373f835)`()` | 
`public void `[`confirmChannel`](#classpeerstream_1_1core_1_1peerstream_1_1client_1_1_i_channel_1a6f97c455f64782cd6dadcf2ec6b41a6e)`(std::function< `[`OnChannelConfirmed`](doxygen/md/OnChannelConfirmed.md#classpeerstream_1_1core_1_1peerstream_1_1client_1_1_i_channel_1a88da65c5df71887a97ddef7d53d8ceba)` > onChannelConfirmed,std::function< `[`OnChannelRequestError`](doxygen/md/OnChannelRequestError.md#classpeerstream_1_1core_1_1peerstream_1_1client_1_1_i_channel_1a7d290a08af057c41dfdfde4f9987f580)` > onError)` | 
`public void `[`denyChannel`](#classpeerstream_1_1core_1_1peerstream_1_1client_1_1_i_channel_1a83e3dcd4ffbc3476a972e990d2094a8a)`()` | 
`public void `[`shareStream`](#classpeerstream_1_1core_1_1peerstream_1_1client_1_1_i_channel_1ae8cde0b8c2740aad8df97f12a7eecaeb)`(std::function< `[`OnVideoStreamCreated`](doxygen/md/OnVideoStreamCreated.md#classpeerstream_1_1core_1_1peerstream_1_1client_1_1_i_channel_1a3c3b4350bf54e8bfbd48309a671d5fbc)` > onCreate,std::function< `[`OnVideoStreamError`](doxygen/md/OnVideoStreamError.md#classpeerstream_1_1core_1_1peerstream_1_1client_1_1_i_channel_1afdfeffe4b3ddd0312a0f62d758dca945)` > onError)` | Method to share your stream with another user 
`public void `[`requestStream`](#classpeerstream_1_1core_1_1peerstream_1_1client_1_1_i_channel_1a0bf3d75d7ff3c11219dc36c3d290bfd4)`(std::function< `[`OnVideoStreamCreated`](doxygen/md/OnVideoStreamCreated.md#classpeerstream_1_1core_1_1peerstream_1_1client_1_1_i_channel_1a3c3b4350bf54e8bfbd48309a671d5fbc)` > onCreate,std::function< `[`OnVideoStreamError`](doxygen/md/OnVideoStreamError.md#classpeerstream_1_1core_1_1peerstream_1_1client_1_1_i_channel_1afdfeffe4b3ddd0312a0f62d758dca945)` > onError)` | Method to request to view the stream of another user 
`public void `[`confirmVideoStreamRequest`](#classpeerstream_1_1core_1_1peerstream_1_1client_1_1_i_channel_1afa9827d243ffe9aefcc64af4d8f45eb3)`(std::function< `[`OnVideoStreamCreated`](doxygen/md/OnVideoStreamCreated.md#classpeerstream_1_1core_1_1peerstream_1_1client_1_1_i_channel_1a3c3b4350bf54e8bfbd48309a671d5fbc)` > onCreate,std::function< `[`OnVideoStreamError`](doxygen/md/OnVideoStreamError.md#classpeerstream_1_1core_1_1peerstream_1_1client_1_1_i_channel_1afdfeffe4b3ddd0312a0f62d758dca945)` > onError)` | Method to confirm the other user from viewing your stream after their request 
`public void `[`denyVideoStreamRequest`](#classpeerstream_1_1core_1_1peerstream_1_1client_1_1_i_channel_1ae61831406d27c16b86d2675a9f8d8067)`()` | Method to deny a user from viewing your stream after their request.
`public void `[`confirmVideoStreamShare`](#classpeerstream_1_1core_1_1peerstream_1_1client_1_1_i_channel_1ad489518c01b7fa90f6bc8eb39a5a03c5)`(std::function< `[`OnVideoStreamCreated`](doxygen/md/OnVideoStreamCreated.md#classpeerstream_1_1core_1_1peerstream_1_1client_1_1_i_channel_1a3c3b4350bf54e8bfbd48309a671d5fbc)` > onCreate,std::function< `[`OnVideoStreamError`](doxygen/md/OnVideoStreamError.md#classpeerstream_1_1core_1_1peerstream_1_1client_1_1_i_channel_1afdfeffe4b3ddd0312a0f62d758dca945)` > onError)` | Method to confirm viewing of the other user's stream that has been shared with you 
`public void `[`denyVideoStreamShare`](#classpeerstream_1_1core_1_1peerstream_1_1client_1_1_i_channel_1a6f098ea97dcccc28eab271e15515480d)`()` | Method to decline viewing of the other user's stream that has been shared with you.
`public void `[`stopViewingStream`](#classpeerstream_1_1core_1_1peerstream_1_1client_1_1_i_channel_1aead8746389ad878e28cbd2c2e16d5ea0)`()` | Method to stop viewing the other user's stream (if you're already viewing)
`public std::string `[`identity`](#classpeerstream_1_1core_1_1peerstream_1_1client_1_1_i_channel_1a2777ca6eba856f5e60a23e64a35ff6b4)`() const` | Method to retrieve the identity of the user on the channel.
`public bool `[`isConfirmed`](#classpeerstream_1_1core_1_1peerstream_1_1client_1_1_i_channel_1a91af01cd71ef070e324ea8d360ea1c35)`() const` | Method to retrieve whether or not the channel is confirmed.
`public `[`core::signals::ConnectionPtr`](doxygen/md/ConnectionPtr.md#namespacepeerstream_1_1core_1_1signals_1aca3fd2deaf3c0f573c485c8e8ab0b31d)` registerRawDataReceived `[`PS_SDK_NODISCARD`](#classpeerstream_1_1core_1_1peerstream_1_1client_1_1_i_channel_1a73900c08c53872a16b09d067509fe0f6)`(std::function< `[`OnRawReceived`](doxygen/md/OnRawReceived.md#classpeerstream_1_1core_1_1peerstream_1_1client_1_1_i_channel_1ac0656fc8becd2a270caf24da6e8f4806)` > handler)` | Register for raw data received notification 
`public `[`core::signals::ConnectionPtr`](doxygen/md/ConnectionPtr.md#namespacepeerstream_1_1core_1_1signals_1aca3fd2deaf3c0f573c485c8e8ab0b31d)` registerMessageReceived `[`PS_SDK_NODISCARD`](#classpeerstream_1_1core_1_1peerstream_1_1client_1_1_i_channel_1a32f55285686dc0a56c19f78bdb80fa12)`(std::function< `[`OnMessageReceived`](doxygen/md/OnMessageReceived.md#classpeerstream_1_1core_1_1peerstream_1_1client_1_1_i_channel_1a501a4832044c18c92cb3dee7f9031e2a)` > handler)` | Register for a message received notification 
`public `[`core::signals::ConnectionPtr`](doxygen/md/ConnectionPtr.md#namespacepeerstream_1_1core_1_1signals_1aca3fd2deaf3c0f573c485c8e8ab0b31d)` registerChannelError `[`PS_SDK_NODISCARD`](#classpeerstream_1_1core_1_1peerstream_1_1client_1_1_i_channel_1aba9c8619ffc8e92e98be8d56083d61c9)`(std::function< `[`OnChannelError`](doxygen/md/OnChannelError.md#classpeerstream_1_1core_1_1peerstream_1_1client_1_1_i_channel_1ab7185f3bf9a8526717e3412e1037a1f7)` > handler)` | Register for a channel error notification 
`public `[`core::signals::ConnectionPtr`](doxygen/md/ConnectionPtr.md#namespacepeerstream_1_1core_1_1signals_1aca3fd2deaf3c0f573c485c8e8ab0b31d)` registerVideoStreamRequested `[`PS_SDK_NODISCARD`](#classpeerstream_1_1core_1_1peerstream_1_1client_1_1_i_channel_1a6b6b02c4d87c77538451d89befe22882)`(std::function< `[`OnVideoStreamRequested`](doxygen/md/OnVideoStreamRequested.md#classpeerstream_1_1core_1_1peerstream_1_1client_1_1_i_channel_1a149f5ae1a6879582b001470a7ed1ab5b)` > handler)` | Register for a notification of a video stream that has been requested 
`public `[`core::signals::ConnectionPtr`](doxygen/md/ConnectionPtr.md#namespacepeerstream_1_1core_1_1signals_1aca3fd2deaf3c0f573c485c8e8ab0b31d)` registerVideoStreamShared `[`PS_SDK_NODISCARD`](#classpeerstream_1_1core_1_1peerstream_1_1client_1_1_i_channel_1a68cdc93ef5baa552706d9d7c1ab5cb71)`(std::function< `[`OnVideoStreamShared`](doxygen/md/OnVideoStreamShared.md#classpeerstream_1_1core_1_1peerstream_1_1client_1_1_i_channel_1a9a9dcd66c2704143ea31d62071f5b0db)` > handler)` | Register for a notification of a video stream that has been shared 
`typedef `[`VideoStreamID`](#classpeerstream_1_1core_1_1peerstream_1_1client_1_1_i_channel_1a89281862df5123e78f66192c63ea786e) | 
`typedef `[`ChannelPtr`](#classpeerstream_1_1core_1_1peerstream_1_1client_1_1_i_channel_1ac73bf4ab72adf70c39f6996d88e67fa6) | 
`typedef `[`OnRawReceived`](#classpeerstream_1_1core_1_1peerstream_1_1client_1_1_i_channel_1ac0656fc8becd2a270caf24da6e8f4806) | 
`typedef `[`OnMessageReceived`](#classpeerstream_1_1core_1_1peerstream_1_1client_1_1_i_channel_1a501a4832044c18c92cb3dee7f9031e2a) | 
`typedef `[`OnChannelError`](#classpeerstream_1_1core_1_1peerstream_1_1client_1_1_i_channel_1ab7185f3bf9a8526717e3412e1037a1f7) | 
`typedef `[`OnVideoStreamCreated`](#classpeerstream_1_1core_1_1peerstream_1_1client_1_1_i_channel_1a3c3b4350bf54e8bfbd48309a671d5fbc) | 
`typedef `[`OnVideoStreamError`](#classpeerstream_1_1core_1_1peerstream_1_1client_1_1_i_channel_1afdfeffe4b3ddd0312a0f62d758dca945) | 
`typedef `[`OnVideoStreamRequested`](#classpeerstream_1_1core_1_1peerstream_1_1client_1_1_i_channel_1a149f5ae1a6879582b001470a7ed1ab5b) | 
`typedef `[`OnVideoStreamShared`](#classpeerstream_1_1core_1_1peerstream_1_1client_1_1_i_channel_1a9a9dcd66c2704143ea31d62071f5b0db) | 
`typedef `[`OnVideoStreamDenied`](#classpeerstream_1_1core_1_1peerstream_1_1client_1_1_i_channel_1a0dce1d9f6119fe35d06c3c8792d448a1) | 
`typedef `[`OnChannelConfirmed`](#classpeerstream_1_1core_1_1peerstream_1_1client_1_1_i_channel_1a88da65c5df71887a97ddef7d53d8ceba) | 
`typedef `[`OnChannelRequestError`](#classpeerstream_1_1core_1_1peerstream_1_1client_1_1_i_channel_1a7d290a08af057c41dfdfde4f9987f580) | 

## Members

#### `public inline virtual  `[`~IChannel`](#classpeerstream_1_1core_1_1peerstream_1_1client_1_1_i_channel_1a10c5144bcad5a72a3bfe8a204596ca29)`()` {#classpeerstream_1_1core_1_1peerstream_1_1client_1_1_i_channel_1a10c5144bcad5a72a3bfe8a204596ca29}

#### `public void `[`sendRawData`](#classpeerstream_1_1core_1_1peerstream_1_1client_1_1_i_channel_1a2905711d424c3e5aa9661e796e660e1e)`(const std::vector< uint8_t > & rawData)` {#classpeerstream_1_1core_1_1peerstream_1_1client_1_1_i_channel_1a2905711d424c3e5aa9661e796e660e1e}

#### `public void `[`sendMessage`](#classpeerstream_1_1core_1_1peerstream_1_1client_1_1_i_channel_1a67181349d8ac1ba2190f0512f308b443)`(const std::string & msg)` {#classpeerstream_1_1core_1_1peerstream_1_1client_1_1_i_channel_1a67181349d8ac1ba2190f0512f308b443}

#### `public void `[`closeChannel`](#classpeerstream_1_1core_1_1peerstream_1_1client_1_1_i_channel_1a8d1d4f17ab7751779ab42d160373f835)`()` {#classpeerstream_1_1core_1_1peerstream_1_1client_1_1_i_channel_1a8d1d4f17ab7751779ab42d160373f835}

#### `public void `[`confirmChannel`](#classpeerstream_1_1core_1_1peerstream_1_1client_1_1_i_channel_1a6f97c455f64782cd6dadcf2ec6b41a6e)`(std::function< `[`OnChannelConfirmed`](doxygen/md/OnChannelConfirmed.md#classpeerstream_1_1core_1_1peerstream_1_1client_1_1_i_channel_1a88da65c5df71887a97ddef7d53d8ceba)` > onChannelConfirmed,std::function< `[`OnChannelRequestError`](doxygen/md/OnChannelRequestError.md#classpeerstream_1_1core_1_1peerstream_1_1client_1_1_i_channel_1a7d290a08af057c41dfdfde4f9987f580)` > onError)` {#classpeerstream_1_1core_1_1peerstream_1_1client_1_1_i_channel_1a6f97c455f64782cd6dadcf2ec6b41a6e}

#### `public void `[`denyChannel`](#classpeerstream_1_1core_1_1peerstream_1_1client_1_1_i_channel_1a83e3dcd4ffbc3476a972e990d2094a8a)`()` {#classpeerstream_1_1core_1_1peerstream_1_1client_1_1_i_channel_1a83e3dcd4ffbc3476a972e990d2094a8a}

#### `public void `[`shareStream`](#classpeerstream_1_1core_1_1peerstream_1_1client_1_1_i_channel_1ae8cde0b8c2740aad8df97f12a7eecaeb)`(std::function< `[`OnVideoStreamCreated`](doxygen/md/OnVideoStreamCreated.md#classpeerstream_1_1core_1_1peerstream_1_1client_1_1_i_channel_1a3c3b4350bf54e8bfbd48309a671d5fbc)` > onCreate,std::function< `[`OnVideoStreamError`](doxygen/md/OnVideoStreamError.md#classpeerstream_1_1core_1_1peerstream_1_1client_1_1_i_channel_1afdfeffe4b3ddd0312a0f62d758dca945)` > onError)` {#classpeerstream_1_1core_1_1peerstream_1_1client_1_1_i_channel_1ae8cde0b8c2740aad8df97f12a7eecaeb}

Method to share your stream with another user 
#### Parameters
* `onCreate` Called when a stream is successfully created 

* `onError` called when the stream creation fails

#### `public void `[`requestStream`](#classpeerstream_1_1core_1_1peerstream_1_1client_1_1_i_channel_1a0bf3d75d7ff3c11219dc36c3d290bfd4)`(std::function< `[`OnVideoStreamCreated`](doxygen/md/OnVideoStreamCreated.md#classpeerstream_1_1core_1_1peerstream_1_1client_1_1_i_channel_1a3c3b4350bf54e8bfbd48309a671d5fbc)` > onCreate,std::function< `[`OnVideoStreamError`](doxygen/md/OnVideoStreamError.md#classpeerstream_1_1core_1_1peerstream_1_1client_1_1_i_channel_1afdfeffe4b3ddd0312a0f62d758dca945)` > onError)` {#classpeerstream_1_1core_1_1peerstream_1_1client_1_1_i_channel_1a0bf3d75d7ff3c11219dc36c3d290bfd4}

Method to request to view the stream of another user 
#### Parameters
* `onCreate` Called when a stream is successfully created 

* `onError` called when the stream creation fails

#### `public void `[`confirmVideoStreamRequest`](#classpeerstream_1_1core_1_1peerstream_1_1client_1_1_i_channel_1afa9827d243ffe9aefcc64af4d8f45eb3)`(std::function< `[`OnVideoStreamCreated`](doxygen/md/OnVideoStreamCreated.md#classpeerstream_1_1core_1_1peerstream_1_1client_1_1_i_channel_1a3c3b4350bf54e8bfbd48309a671d5fbc)` > onCreate,std::function< `[`OnVideoStreamError`](doxygen/md/OnVideoStreamError.md#classpeerstream_1_1core_1_1peerstream_1_1client_1_1_i_channel_1afdfeffe4b3ddd0312a0f62d758dca945)` > onError)` {#classpeerstream_1_1core_1_1peerstream_1_1client_1_1_i_channel_1afa9827d243ffe9aefcc64af4d8f45eb3}

Method to confirm the other user from viewing your stream after their request 
#### Parameters
* `onCreate` Called when a stream is successfully created 

* `onError` called when the stream creation fails

#### `public void `[`denyVideoStreamRequest`](#classpeerstream_1_1core_1_1peerstream_1_1client_1_1_i_channel_1ae61831406d27c16b86d2675a9f8d8067)`()` {#classpeerstream_1_1core_1_1peerstream_1_1client_1_1_i_channel_1ae61831406d27c16b86d2675a9f8d8067}

Method to deny a user from viewing your stream after their request.

#### `public void `[`confirmVideoStreamShare`](#classpeerstream_1_1core_1_1peerstream_1_1client_1_1_i_channel_1ad489518c01b7fa90f6bc8eb39a5a03c5)`(std::function< `[`OnVideoStreamCreated`](doxygen/md/OnVideoStreamCreated.md#classpeerstream_1_1core_1_1peerstream_1_1client_1_1_i_channel_1a3c3b4350bf54e8bfbd48309a671d5fbc)` > onCreate,std::function< `[`OnVideoStreamError`](doxygen/md/OnVideoStreamError.md#classpeerstream_1_1core_1_1peerstream_1_1client_1_1_i_channel_1afdfeffe4b3ddd0312a0f62d758dca945)` > onError)` {#classpeerstream_1_1core_1_1peerstream_1_1client_1_1_i_channel_1ad489518c01b7fa90f6bc8eb39a5a03c5}

Method to confirm viewing of the other user's stream that has been shared with you 
#### Parameters
* `onCreate` Called when a stream is successfully created 

* `onError` called when the stream creation fails

#### `public void `[`denyVideoStreamShare`](#classpeerstream_1_1core_1_1peerstream_1_1client_1_1_i_channel_1a6f098ea97dcccc28eab271e15515480d)`()` {#classpeerstream_1_1core_1_1peerstream_1_1client_1_1_i_channel_1a6f098ea97dcccc28eab271e15515480d}

Method to decline viewing of the other user's stream that has been shared with you.

#### `public void `[`stopViewingStream`](#classpeerstream_1_1core_1_1peerstream_1_1client_1_1_i_channel_1aead8746389ad878e28cbd2c2e16d5ea0)`()` {#classpeerstream_1_1core_1_1peerstream_1_1client_1_1_i_channel_1aead8746389ad878e28cbd2c2e16d5ea0}

Method to stop viewing the other user's stream (if you're already viewing)

#### `public std::string `[`identity`](#classpeerstream_1_1core_1_1peerstream_1_1client_1_1_i_channel_1a2777ca6eba856f5e60a23e64a35ff6b4)`() const` {#classpeerstream_1_1core_1_1peerstream_1_1client_1_1_i_channel_1a2777ca6eba856f5e60a23e64a35ff6b4}

Method to retrieve the identity of the user on the channel.

#### `public bool `[`isConfirmed`](#classpeerstream_1_1core_1_1peerstream_1_1client_1_1_i_channel_1a91af01cd71ef070e324ea8d360ea1c35)`() const` {#classpeerstream_1_1core_1_1peerstream_1_1client_1_1_i_channel_1a91af01cd71ef070e324ea8d360ea1c35}

Method to retrieve whether or not the channel is confirmed.

#### `public `[`core::signals::ConnectionPtr`](doxygen/md/ConnectionPtr.md#namespacepeerstream_1_1core_1_1signals_1aca3fd2deaf3c0f573c485c8e8ab0b31d)` registerRawDataReceived `[`PS_SDK_NODISCARD`](#classpeerstream_1_1core_1_1peerstream_1_1client_1_1_i_channel_1a73900c08c53872a16b09d067509fe0f6)`(std::function< `[`OnRawReceived`](doxygen/md/OnRawReceived.md#classpeerstream_1_1core_1_1peerstream_1_1client_1_1_i_channel_1ac0656fc8becd2a270caf24da6e8f4806)` > handler)` {#classpeerstream_1_1core_1_1peerstream_1_1client_1_1_i_channel_1a73900c08c53872a16b09d067509fe0f6}

Register for raw data received notification 
#### Parameters
* `handler` The handler to call back when raw data is received

#### `public `[`core::signals::ConnectionPtr`](doxygen/md/ConnectionPtr.md#namespacepeerstream_1_1core_1_1signals_1aca3fd2deaf3c0f573c485c8e8ab0b31d)` registerMessageReceived `[`PS_SDK_NODISCARD`](#classpeerstream_1_1core_1_1peerstream_1_1client_1_1_i_channel_1a32f55285686dc0a56c19f78bdb80fa12)`(std::function< `[`OnMessageReceived`](doxygen/md/OnMessageReceived.md#classpeerstream_1_1core_1_1peerstream_1_1client_1_1_i_channel_1a501a4832044c18c92cb3dee7f9031e2a)` > handler)` {#classpeerstream_1_1core_1_1peerstream_1_1client_1_1_i_channel_1a32f55285686dc0a56c19f78bdb80fa12}

Register for a message received notification 
#### Parameters
* `handler` The handler to call back when a message is received

#### `public `[`core::signals::ConnectionPtr`](doxygen/md/ConnectionPtr.md#namespacepeerstream_1_1core_1_1signals_1aca3fd2deaf3c0f573c485c8e8ab0b31d)` registerChannelError `[`PS_SDK_NODISCARD`](#classpeerstream_1_1core_1_1peerstream_1_1client_1_1_i_channel_1aba9c8619ffc8e92e98be8d56083d61c9)`(std::function< `[`OnChannelError`](doxygen/md/OnChannelError.md#classpeerstream_1_1core_1_1peerstream_1_1client_1_1_i_channel_1ab7185f3bf9a8526717e3412e1037a1f7)` > handler)` {#classpeerstream_1_1core_1_1peerstream_1_1client_1_1_i_channel_1aba9c8619ffc8e92e98be8d56083d61c9}

Register for a channel error notification 
#### Parameters
* `handler` The handler to call back when a channel errors out

#### `public `[`core::signals::ConnectionPtr`](doxygen/md/ConnectionPtr.md#namespacepeerstream_1_1core_1_1signals_1aca3fd2deaf3c0f573c485c8e8ab0b31d)` registerVideoStreamRequested `[`PS_SDK_NODISCARD`](#classpeerstream_1_1core_1_1peerstream_1_1client_1_1_i_channel_1a6b6b02c4d87c77538451d89befe22882)`(std::function< `[`OnVideoStreamRequested`](doxygen/md/OnVideoStreamRequested.md#classpeerstream_1_1core_1_1peerstream_1_1client_1_1_i_channel_1a149f5ae1a6879582b001470a7ed1ab5b)` > handler)` {#classpeerstream_1_1core_1_1peerstream_1_1client_1_1_i_channel_1a6b6b02c4d87c77538451d89befe22882}

Register for a notification of a video stream that has been requested 
#### Parameters
* `handler` The handler to call back when a stream is requested

#### `public `[`core::signals::ConnectionPtr`](doxygen/md/ConnectionPtr.md#namespacepeerstream_1_1core_1_1signals_1aca3fd2deaf3c0f573c485c8e8ab0b31d)` registerVideoStreamShared `[`PS_SDK_NODISCARD`](#classpeerstream_1_1core_1_1peerstream_1_1client_1_1_i_channel_1a68cdc93ef5baa552706d9d7c1ab5cb71)`(std::function< `[`OnVideoStreamShared`](doxygen/md/OnVideoStreamShared.md#classpeerstream_1_1core_1_1peerstream_1_1client_1_1_i_channel_1a9a9dcd66c2704143ea31d62071f5b0db)` > handler)` {#classpeerstream_1_1core_1_1peerstream_1_1client_1_1_i_channel_1a68cdc93ef5baa552706d9d7c1ab5cb71}

Register for a notification of a video stream that has been shared 
#### Parameters
* `handler` The handler to call back when a stream is requested

#### `typedef `[`VideoStreamID`](#classpeerstream_1_1core_1_1peerstream_1_1client_1_1_i_channel_1a89281862df5123e78f66192c63ea786e) {#classpeerstream_1_1core_1_1peerstream_1_1client_1_1_i_channel_1a89281862df5123e78f66192c63ea786e}

#### `typedef `[`ChannelPtr`](#classpeerstream_1_1core_1_1peerstream_1_1client_1_1_i_channel_1ac73bf4ab72adf70c39f6996d88e67fa6) {#classpeerstream_1_1core_1_1peerstream_1_1client_1_1_i_channel_1ac73bf4ab72adf70c39f6996d88e67fa6}

#### `typedef `[`OnRawReceived`](#classpeerstream_1_1core_1_1peerstream_1_1client_1_1_i_channel_1ac0656fc8becd2a270caf24da6e8f4806) {#classpeerstream_1_1core_1_1peerstream_1_1client_1_1_i_channel_1ac0656fc8becd2a270caf24da6e8f4806}

#### `typedef `[`OnMessageReceived`](#classpeerstream_1_1core_1_1peerstream_1_1client_1_1_i_channel_1a501a4832044c18c92cb3dee7f9031e2a) {#classpeerstream_1_1core_1_1peerstream_1_1client_1_1_i_channel_1a501a4832044c18c92cb3dee7f9031e2a}

#### `typedef `[`OnChannelError`](#classpeerstream_1_1core_1_1peerstream_1_1client_1_1_i_channel_1ab7185f3bf9a8526717e3412e1037a1f7) {#classpeerstream_1_1core_1_1peerstream_1_1client_1_1_i_channel_1ab7185f3bf9a8526717e3412e1037a1f7}

#### `typedef `[`OnVideoStreamCreated`](#classpeerstream_1_1core_1_1peerstream_1_1client_1_1_i_channel_1a3c3b4350bf54e8bfbd48309a671d5fbc) {#classpeerstream_1_1core_1_1peerstream_1_1client_1_1_i_channel_1a3c3b4350bf54e8bfbd48309a671d5fbc}

#### `typedef `[`OnVideoStreamError`](#classpeerstream_1_1core_1_1peerstream_1_1client_1_1_i_channel_1afdfeffe4b3ddd0312a0f62d758dca945) {#classpeerstream_1_1core_1_1peerstream_1_1client_1_1_i_channel_1afdfeffe4b3ddd0312a0f62d758dca945}

#### `typedef `[`OnVideoStreamRequested`](#classpeerstream_1_1core_1_1peerstream_1_1client_1_1_i_channel_1a149f5ae1a6879582b001470a7ed1ab5b) {#classpeerstream_1_1core_1_1peerstream_1_1client_1_1_i_channel_1a149f5ae1a6879582b001470a7ed1ab5b}

#### `typedef `[`OnVideoStreamShared`](#classpeerstream_1_1core_1_1peerstream_1_1client_1_1_i_channel_1a9a9dcd66c2704143ea31d62071f5b0db) {#classpeerstream_1_1core_1_1peerstream_1_1client_1_1_i_channel_1a9a9dcd66c2704143ea31d62071f5b0db}

#### `typedef `[`OnVideoStreamDenied`](#classpeerstream_1_1core_1_1peerstream_1_1client_1_1_i_channel_1a0dce1d9f6119fe35d06c3c8792d448a1) {#classpeerstream_1_1core_1_1peerstream_1_1client_1_1_i_channel_1a0dce1d9f6119fe35d06c3c8792d448a1}

#### `typedef `[`OnChannelConfirmed`](#classpeerstream_1_1core_1_1peerstream_1_1client_1_1_i_channel_1a88da65c5df71887a97ddef7d53d8ceba) {#classpeerstream_1_1core_1_1peerstream_1_1client_1_1_i_channel_1a88da65c5df71887a97ddef7d53d8ceba}

#### `typedef `[`OnChannelRequestError`](#classpeerstream_1_1core_1_1peerstream_1_1client_1_1_i_channel_1a7d290a08af057c41dfdfde4f9987f580) {#classpeerstream_1_1core_1_1peerstream_1_1client_1_1_i_channel_1a7d290a08af057c41dfdfde4f9987f580}

