# struct `peerstream::client::test::TestChannelConfig` {#structpeerstream_1_1client_1_1test_1_1_test_channel_config}

Use this structure for setting test variables for controlling how this test code operates

## Summary

 Members                        | Descriptions                                
--------------------------------|---------------------------------------------
`public size_t `[`numMessagesSent`](#structpeerstream_1_1client_1_1test_1_1_test_channel_config_1af3864085f1a33b63d8a24ad0df526a24) | Configuration for the number of messages sent, generally set to 0.
`public size_t `[`numMessagesSentFailureRate`](#structpeerstream_1_1client_1_1test_1_1_test_channel_config_1a2c3f3830b0d7e9cda32cc0ee796bde36) | Configuration for the number of messages sent before failing.
`public size_t `[`numImagesSent`](#structpeerstream_1_1client_1_1test_1_1_test_channel_config_1af0b5b41d07ef8a8dd38908a18db38a11) | Configuration for the number of images sent, generally set to 0.
`public size_t `[`numImagesSentFailureRate`](#structpeerstream_1_1client_1_1test_1_1_test_channel_config_1aa542175aad41fc04de3ee1b31afde251) | Configuration for the number of images sent before failing.
`public ChannelErrorID `[`nextChannelError`](#structpeerstream_1_1client_1_1test_1_1_test_channel_config_1a4833faaeb73d95938767cd4d0d1d2742) | This is for the next error that will be returned by the channel.
`public size_t `[`numStreamsShared`](#structpeerstream_1_1client_1_1test_1_1_test_channel_config_1acbefedf5858b19bad819a356e6e0f670) | Configuration for the number of streams shared, generally starts at 0.
`public size_t `[`numStreamsSharedFailureRate`](#structpeerstream_1_1client_1_1test_1_1_test_channel_config_1ad68bc794ad82bdaf6f1f8c7d4b882c0c) | Configuration for the number of streams shared before failing.
`public size_t `[`numStreamsRequested`](#structpeerstream_1_1client_1_1test_1_1_test_channel_config_1aed40a721cfacae162b550f19a7ecaf60) | Configuration for the number of streams requested, generally starts at 0.
`public size_t `[`numStreamsRequestedFailureRate`](#structpeerstream_1_1client_1_1test_1_1_test_channel_config_1a7fb1d5668cfed2b2cb7c77eeeadc67db) | Configuration for the number of streams requested before failing.
`public VideoStreamErrorID `[`nextStreamError`](#structpeerstream_1_1client_1_1test_1_1_test_channel_config_1ae6bc08c2f905f1c43f19c6ea1db8ba03) | This is for the next error that will be returned by the stream.
`public std::chrono::milliseconds `[`streamRequestedInterval`](#structpeerstream_1_1client_1_1test_1_1_test_channel_config_1a92b967570db1a0af05ef3ffbff8e624f) | At this interval, the channel will have a stream requested.

## Members

#### `public size_t `[`numMessagesSent`](#structpeerstream_1_1client_1_1test_1_1_test_channel_config_1af3864085f1a33b63d8a24ad0df526a24) {#structpeerstream_1_1client_1_1test_1_1_test_channel_config_1af3864085f1a33b63d8a24ad0df526a24}

Configuration for the number of messages sent, generally set to 0.

#### `public size_t `[`numMessagesSentFailureRate`](#structpeerstream_1_1client_1_1test_1_1_test_channel_config_1a2c3f3830b0d7e9cda32cc0ee796bde36) {#structpeerstream_1_1client_1_1test_1_1_test_channel_config_1a2c3f3830b0d7e9cda32cc0ee796bde36}

Configuration for the number of messages sent before failing.

#### `public size_t `[`numImagesSent`](#structpeerstream_1_1client_1_1test_1_1_test_channel_config_1af0b5b41d07ef8a8dd38908a18db38a11) {#structpeerstream_1_1client_1_1test_1_1_test_channel_config_1af0b5b41d07ef8a8dd38908a18db38a11}

Configuration for the number of images sent, generally set to 0.

#### `public size_t `[`numImagesSentFailureRate`](#structpeerstream_1_1client_1_1test_1_1_test_channel_config_1aa542175aad41fc04de3ee1b31afde251) {#structpeerstream_1_1client_1_1test_1_1_test_channel_config_1aa542175aad41fc04de3ee1b31afde251}

Configuration for the number of images sent before failing.

#### `public ChannelErrorID `[`nextChannelError`](#structpeerstream_1_1client_1_1test_1_1_test_channel_config_1a4833faaeb73d95938767cd4d0d1d2742) {#structpeerstream_1_1client_1_1test_1_1_test_channel_config_1a4833faaeb73d95938767cd4d0d1d2742}

This is for the next error that will be returned by the channel.

#### `public size_t `[`numStreamsShared`](#structpeerstream_1_1client_1_1test_1_1_test_channel_config_1acbefedf5858b19bad819a356e6e0f670) {#structpeerstream_1_1client_1_1test_1_1_test_channel_config_1acbefedf5858b19bad819a356e6e0f670}

Configuration for the number of streams shared, generally starts at 0.

#### `public size_t `[`numStreamsSharedFailureRate`](#structpeerstream_1_1client_1_1test_1_1_test_channel_config_1ad68bc794ad82bdaf6f1f8c7d4b882c0c) {#structpeerstream_1_1client_1_1test_1_1_test_channel_config_1ad68bc794ad82bdaf6f1f8c7d4b882c0c}

Configuration for the number of streams shared before failing.

#### `public size_t `[`numStreamsRequested`](#structpeerstream_1_1client_1_1test_1_1_test_channel_config_1aed40a721cfacae162b550f19a7ecaf60) {#structpeerstream_1_1client_1_1test_1_1_test_channel_config_1aed40a721cfacae162b550f19a7ecaf60}

Configuration for the number of streams requested, generally starts at 0.

#### `public size_t `[`numStreamsRequestedFailureRate`](#structpeerstream_1_1client_1_1test_1_1_test_channel_config_1a7fb1d5668cfed2b2cb7c77eeeadc67db) {#structpeerstream_1_1client_1_1test_1_1_test_channel_config_1a7fb1d5668cfed2b2cb7c77eeeadc67db}

Configuration for the number of streams requested before failing.

#### `public VideoStreamErrorID `[`nextStreamError`](#structpeerstream_1_1client_1_1test_1_1_test_channel_config_1ae6bc08c2f905f1c43f19c6ea1db8ba03) {#structpeerstream_1_1client_1_1test_1_1_test_channel_config_1ae6bc08c2f905f1c43f19c6ea1db8ba03}

This is for the next error that will be returned by the stream.

#### `public std::chrono::milliseconds `[`streamRequestedInterval`](#structpeerstream_1_1client_1_1test_1_1_test_channel_config_1a92b967570db1a0af05ef3ffbff8e624f) {#structpeerstream_1_1client_1_1test_1_1_test_channel_config_1a92b967570db1a0af05ef3ffbff8e624f}

At this interval, the channel will have a stream requested.

