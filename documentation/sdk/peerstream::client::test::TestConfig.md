# struct `peerstream::client::test::TestConfig` {#structpeerstream_1_1client_1_1test_1_1_test_config}

Use this structure for setting test variables for controlling how this test code operates

## Summary

 Members                        | Descriptions                                
--------------------------------|---------------------------------------------
`public std::chrono::milliseconds `[`networkStatusInterval`](#structpeerstream_1_1client_1_1test_1_1_test_config_1a7bbf67a76cf2b13297a396f1449ad9d5) | How often network status is reported.
`public size_t `[`numEntryNodes`](#structpeerstream_1_1client_1_1test_1_1_test_config_1aed4a55ffc9f16fcd1e04af91d8c11440) | The number of entry nodes for the network, which is used as a basis for 100% network status in the test case
`public size_t `[`numNodesConnected`](#structpeerstream_1_1client_1_1test_1_1_test_config_1abcc2578600524cb8a88561998361177f) | The number of nodes currently connected in the network, used as the numerator for the network status, generally leave this at the default
`public std::chrono::milliseconds `[`nodeDropInterval`](#structpeerstream_1_1client_1_1test_1_1_test_config_1a8766b413341e37de42a84a3fd578e491) | At this interval, a node will drop, which will affect network status.
`public std::chrono::milliseconds `[`nodeReconnectInterval`](#structpeerstream_1_1client_1_1test_1_1_test_config_1accbd41bb92455110e7e93358088ed32d) | At this interval, all nodes will reconnect, leading to ideally 100% network status unless another node drops in between
`public int `[`numChannelsCreated`](#structpeerstream_1_1client_1_1test_1_1_test_config_1ac5d221fa473eab506ba00c687d1b75c2) | The number of channels that have currently been created. Generally leave this at 0
`public int `[`channelCreationFailureRate`](#structpeerstream_1_1client_1_1test_1_1_test_config_1a49b9403fe10cd7dc991cfa667e63d785) | This is the failure rate, so that for every Nth item, we have a failure.
`public ChannelRequestErrorID `[`nextChannelRequestError`](#structpeerstream_1_1client_1_1test_1_1_test_config_1a123f6730fc7db93e9524ece3cb67938e) | When there is a channel creation failure, it cycles through error codes starting with the value here. Generally leave this at the default
`public std::chrono::milliseconds `[`channelRequestInterval`](#structpeerstream_1_1client_1_1test_1_1_test_config_1a73b1787c664892a8c3986b00c0643f87) | Once per interval, a mock user will request to connect to you.
`public std::chrono::milliseconds `[`userPresenceInterval`](#structpeerstream_1_1client_1_1test_1_1_test_config_1a6edc5a7318c15331d0bac1444b7fe9f8) | Interval of when to do the next user presence notification.
`public bool `[`initialUserPresenceStatus`](#structpeerstream_1_1client_1_1test_1_1_test_config_1adb4bce6df1633caaba8eb2f594dd60e0) | Initial user presence when a new user is added.
`public std::size_t `[`nextUserPresence`](#structpeerstream_1_1client_1_1test_1_1_test_config_1a4bb78fe77ea2ad97f2d75f9da33a5606) | Index to start receiving user presence from. Generally, should leave at 0.
`public bool `[`nextUserPresenceStatus`](#structpeerstream_1_1client_1_1test_1_1_test_config_1ab59714120fec9e69dde678f821a59a71) | Next user presence status for the assigned user that will be shown. Will flip each timer.
`public std::string `[`identity`](#structpeerstream_1_1client_1_1test_1_1_test_config_1aa802324586d43114c0747e40862cecbb) | The identity of the simulated user.
`public `[`TestChannelConfig`](doxygen/md/peerstream::client::test::TestChannelConfig.md#structpeerstream_1_1client_1_1test_1_1_test_channel_config)` `[`channelTestConfig`](#structpeerstream_1_1client_1_1test_1_1_test_config_1aa2566b78194912aac50373ddcdcdce0f) | Test configuration that relates explicitly to channels.

## Members

#### `public std::chrono::milliseconds `[`networkStatusInterval`](#structpeerstream_1_1client_1_1test_1_1_test_config_1a7bbf67a76cf2b13297a396f1449ad9d5) {#structpeerstream_1_1client_1_1test_1_1_test_config_1a7bbf67a76cf2b13297a396f1449ad9d5}

How often network status is reported.

#### `public size_t `[`numEntryNodes`](#structpeerstream_1_1client_1_1test_1_1_test_config_1aed4a55ffc9f16fcd1e04af91d8c11440) {#structpeerstream_1_1client_1_1test_1_1_test_config_1aed4a55ffc9f16fcd1e04af91d8c11440}

The number of entry nodes for the network, which is used as a basis for 100% network status in the test case

#### `public size_t `[`numNodesConnected`](#structpeerstream_1_1client_1_1test_1_1_test_config_1abcc2578600524cb8a88561998361177f) {#structpeerstream_1_1client_1_1test_1_1_test_config_1abcc2578600524cb8a88561998361177f}

The number of nodes currently connected in the network, used as the numerator for the network status, generally leave this at the default

#### `public std::chrono::milliseconds `[`nodeDropInterval`](#structpeerstream_1_1client_1_1test_1_1_test_config_1a8766b413341e37de42a84a3fd578e491) {#structpeerstream_1_1client_1_1test_1_1_test_config_1a8766b413341e37de42a84a3fd578e491}

At this interval, a node will drop, which will affect network status.

#### `public std::chrono::milliseconds `[`nodeReconnectInterval`](#structpeerstream_1_1client_1_1test_1_1_test_config_1accbd41bb92455110e7e93358088ed32d) {#structpeerstream_1_1client_1_1test_1_1_test_config_1accbd41bb92455110e7e93358088ed32d}

At this interval, all nodes will reconnect, leading to ideally 100% network status unless another node drops in between

#### `public int `[`numChannelsCreated`](#structpeerstream_1_1client_1_1test_1_1_test_config_1ac5d221fa473eab506ba00c687d1b75c2) {#structpeerstream_1_1client_1_1test_1_1_test_config_1ac5d221fa473eab506ba00c687d1b75c2}

The number of channels that have currently been created. Generally leave this at 0

#### `public int `[`channelCreationFailureRate`](#structpeerstream_1_1client_1_1test_1_1_test_config_1a49b9403fe10cd7dc991cfa667e63d785) {#structpeerstream_1_1client_1_1test_1_1_test_config_1a49b9403fe10cd7dc991cfa667e63d785}

This is the failure rate, so that for every Nth item, we have a failure.

#### `public ChannelRequestErrorID `[`nextChannelRequestError`](#structpeerstream_1_1client_1_1test_1_1_test_config_1a123f6730fc7db93e9524ece3cb67938e) {#structpeerstream_1_1client_1_1test_1_1_test_config_1a123f6730fc7db93e9524ece3cb67938e}

When there is a channel creation failure, it cycles through error codes starting with the value here. Generally leave this at the default

#### `public std::chrono::milliseconds `[`channelRequestInterval`](#structpeerstream_1_1client_1_1test_1_1_test_config_1a73b1787c664892a8c3986b00c0643f87) {#structpeerstream_1_1client_1_1test_1_1_test_config_1a73b1787c664892a8c3986b00c0643f87}

Once per interval, a mock user will request to connect to you.

#### `public std::chrono::milliseconds `[`userPresenceInterval`](#structpeerstream_1_1client_1_1test_1_1_test_config_1a6edc5a7318c15331d0bac1444b7fe9f8) {#structpeerstream_1_1client_1_1test_1_1_test_config_1a6edc5a7318c15331d0bac1444b7fe9f8}

Interval of when to do the next user presence notification.

#### `public bool `[`initialUserPresenceStatus`](#structpeerstream_1_1client_1_1test_1_1_test_config_1adb4bce6df1633caaba8eb2f594dd60e0) {#structpeerstream_1_1client_1_1test_1_1_test_config_1adb4bce6df1633caaba8eb2f594dd60e0}

Initial user presence when a new user is added.

#### `public std::size_t `[`nextUserPresence`](#structpeerstream_1_1client_1_1test_1_1_test_config_1a4bb78fe77ea2ad97f2d75f9da33a5606) {#structpeerstream_1_1client_1_1test_1_1_test_config_1a4bb78fe77ea2ad97f2d75f9da33a5606}

Index to start receiving user presence from. Generally, should leave at 0.

#### `public bool `[`nextUserPresenceStatus`](#structpeerstream_1_1client_1_1test_1_1_test_config_1ab59714120fec9e69dde678f821a59a71) {#structpeerstream_1_1client_1_1test_1_1_test_config_1ab59714120fec9e69dde678f821a59a71}

Next user presence status for the assigned user that will be shown. Will flip each timer.

#### `public std::string `[`identity`](#structpeerstream_1_1client_1_1test_1_1_test_config_1aa802324586d43114c0747e40862cecbb) {#structpeerstream_1_1client_1_1test_1_1_test_config_1aa802324586d43114c0747e40862cecbb}

The identity of the simulated user.

#### `public `[`TestChannelConfig`](doxygen/md/peerstream::client::test::TestChannelConfig.md#structpeerstream_1_1client_1_1test_1_1_test_channel_config)` `[`channelTestConfig`](#structpeerstream_1_1client_1_1test_1_1_test_config_1aa2566b78194912aac50373ddcdcdce0f) {#structpeerstream_1_1client_1_1test_1_1_test_config_1aa2566b78194912aac50373ddcdcdce0f}

Test configuration that relates explicitly to channels.

