# class `peerstream::client::IVideoStreamer` {#classpeerstream_1_1client_1_1_i_video_streamer}

Interface for video streaming.

## Summary

 Members                        | Descriptions                                
--------------------------------|---------------------------------------------
`public inline virtual  `[`~IVideoStreamer`](#classpeerstream_1_1client_1_1_i_video_streamer_1a1c01aa0d596d6bd6b8cf4a80d9a96aa1)`()` | 
`public void `[`initialize`](#classpeerstream_1_1client_1_1_i_video_streamer_1a25ab33620bb25e464d20f5be12a0e19a)`(const `[`StreamingOptions`](doxygen/md/peerstream::client::StreamingOptions.md#structpeerstream_1_1client_1_1_streaming_options)` & options)` | Initialize media system with streaming options provided.
`public void `[`startStreaming`](#classpeerstream_1_1client_1_1_i_video_streamer_1a071f44b3a5e6674af2f401968884216b)`(std::function< void(`[`VideoStreamID`](doxygen/md/VideoStreamID.md#classpeerstream_1_1client_1_1_i_video_streamer_1a40772b0751b24d8f7328e36f50a1d372))`> onStarted,std::function< void(VideoStreamErrorID)> onError)` | Method to start streaming.
`public void `[`startViewing`](#classpeerstream_1_1client_1_1_i_video_streamer_1aa5a153fefecf9f3147d9f6578bf1a40e)`(const `[`VideoStreamID`](doxygen/md/VideoStreamID.md#classpeerstream_1_1client_1_1_i_video_streamer_1a40772b0751b24d8f7328e36f50a1d372)` & videoStreamID,std::function< void(`[`VideoStreamID`](doxygen/md/VideoStreamID.md#classpeerstream_1_1client_1_1_i_video_streamer_1a40772b0751b24d8f7328e36f50a1d372))`> onStarted,std::function< void(VideoStreamErrorID)> onError)` | Method to start viewing someone who is broadcasting.
`public void `[`stopStreaming`](#classpeerstream_1_1client_1_1_i_video_streamer_1a9bdf250b1bbd497b04f29aa0a405819d)`()` | Method to stop broadcasting.
`public void `[`stopViewing`](#classpeerstream_1_1client_1_1_i_video_streamer_1a11382f3803a1d69e0cf9140eeff934b0)`(const `[`VideoStreamID`](doxygen/md/VideoStreamID.md#classpeerstream_1_1client_1_1_i_video_streamer_1a40772b0751b24d8f7328e36f50a1d372)` & videoStreamID)` | Method to stop viewing a specified stream.
`public void `[`enableAudioCapture`](#classpeerstream_1_1client_1_1_i_video_streamer_1a0841cdc2d918513e320a7b56021108ce)`(bool isEnabled)` | Method to enable/disable audio capture.
`public void `[`enableVideoCapture`](#classpeerstream_1_1client_1_1_i_video_streamer_1afc9513144df3e52151363b6567c91623)`(bool isEnabled)` | Method to enable/disable video capture.
`public void `[`setMicrophoneVolume`](#classpeerstream_1_1client_1_1_i_video_streamer_1a89e6894164d172289d382e7999bfdb2b)`(int32_t val)` | Set the microphone volume. Valid values: 0 to 100.
`public void `[`setSpeakerVolume`](#classpeerstream_1_1client_1_1_i_video_streamer_1a27a2dd8a5fb7235ec47c3465585c15be)`(int32_t val)` | Set the speaker volume. Valid values: 0 to 100.
`public void `[`setAudioInputDeviceID`](#classpeerstream_1_1client_1_1_i_video_streamer_1a904a15df37e2903afadf013516a5c316)`(int32_t index)` | Updates the audio input device ID.
`public void `[`setAudioOutputDeviceID`](#classpeerstream_1_1client_1_1_i_video_streamer_1aca5385e8068101953ae541bc01e07ca5)`(int32_t index)` | Updates the audio output device ID.
`public void `[`setVideoDevice`](#classpeerstream_1_1client_1_1_i_video_streamer_1af450c8323a50a7079578e6b578761526)`(int32_t index)` | Set the video capability by index.
`public void `[`setVideoCapability`](#classpeerstream_1_1client_1_1_i_video_streamer_1ab3e76e4b94452a390ae11c150f8196f5)`(int32_t index)` | Set the video capability by index.
`public int32_t `[`selectedAudioInputDeviceID`](#classpeerstream_1_1client_1_1_i_video_streamer_1acbb9eea5b7c1f2d88a054c0425b7ce15)`()` | Retrieves the current audio input device ID.
`public int32_t `[`selectedAudioOutputDeviceID`](#classpeerstream_1_1client_1_1_i_video_streamer_1a54bfeaf589cd223373b633c05685464c)`()` | Retrieves the current audio output device ID.
`public int32_t `[`selectedVideoDevice`](#classpeerstream_1_1client_1_1_i_video_streamer_1acff1e95a7200200b380f192c544347f5)`()` | Retrieves the current video device ID.
`public int32_t `[`selectedVideoCapability`](#classpeerstream_1_1client_1_1_i_video_streamer_1ae7d01ddd85da78ac170fcd047d89b75d)`()` | Retrieves the current video capability by index.
`public std::vector< std::string > `[`getAudioInputDevices`](#classpeerstream_1_1client_1_1_i_video_streamer_1a936b2cad47dc89c2ed1f5cda0e0d74be)`()` | Returns a list of audio input devices.
`public std::vector< std::string > `[`getAudioOutputDevices`](#classpeerstream_1_1client_1_1_i_video_streamer_1a392b8b6effdf0729aeb5b6e517cbcf5c)`()` | Returns a list of audio output devices.
`public std::vector< `[`VideoDevice`](doxygen/md/peerstream::client::VideoDevice.md#structpeerstream_1_1client_1_1_video_device)` > `[`getVideoDevices`](#classpeerstream_1_1client_1_1_i_video_streamer_1aa6945596967b57d076d4746947273f54)`()` | Returns a list of video capabilities.
`public std::vector< `[`VideoCapability`](doxygen/md/peerstream::client::VideoCapability.md#structpeerstream_1_1client_1_1_video_capability)` > `[`getVideoCapabilities`](#classpeerstream_1_1client_1_1_i_video_streamer_1a314d857de307b874eccca35ddace69ed)`(int32_t deviceIndex)` | Returns a list of video capabilities.
`public void `[`retrieveBroadcastVideoStreamID`](#classpeerstream_1_1client_1_1_i_video_streamer_1a86b684c23c58b9eadcfa499078c09ec8)`(std::function< `[`OnRetrieveBroadcastVideoStream`](doxygen/md/OnRetrieveBroadcastVideoStream.md#classpeerstream_1_1client_1_1_i_video_streamer_1ad6e8dbecac2bcd26d17f1fdd9c20f841)` > onRetrieved)` | Returns the broadcast stream ID.
`public `[`core::signals::ConnectionPtr`](doxygen/md/ConnectionPtr.md#namespacepeerstream_1_1core_1_1signals_1aca3fd2deaf3c0f573c485c8e8ab0b31d)` registerDisplayFrameReceived `[`PS_SDK_NODISCARD`](#classpeerstream_1_1client_1_1_i_video_streamer_1af95e468ffa27b3b2c063c34333a485dc)`(std::function< `[`OnDisplayFrameReceived`](doxygen/md/OnDisplayFrameReceived.md#classpeerstream_1_1client_1_1_i_video_streamer_1a397c9711990a47b32bddec8610c75b4d)` > onFrameReceived)` | Register for when a display frame is received.
`public `[`core::signals::ConnectionPtr`](doxygen/md/ConnectionPtr.md#namespacepeerstream_1_1core_1_1signals_1aca3fd2deaf3c0f573c485c8e8ab0b31d)` registerVideoStreamDestroyed `[`PS_SDK_NODISCARD`](#classpeerstream_1_1client_1_1_i_video_streamer_1ae3327cc64c97d6790d6c2800de62ba1c)`(std::function< `[`OnVideoStreamDestroyed`](doxygen/md/OnVideoStreamDestroyed.md#classpeerstream_1_1client_1_1_i_video_streamer_1a78fd8b03727c5afd70ac753babde9bbc)` > onVideoStreamDestroyed)` | Register for when the video stream is destroyed.
`public `[`core::signals::ConnectionPtr`](doxygen/md/ConnectionPtr.md#namespacepeerstream_1_1core_1_1signals_1aca3fd2deaf3c0f573c485c8e8ab0b31d)` registerVideoStreamParameters `[`PS_SDK_NODISCARD`](#classpeerstream_1_1client_1_1_i_video_streamer_1a51fc40a29573b71f84b6e58eab6c8846)`(std::function< `[`OnVideoStreamParameters`](doxygen/md/OnVideoStreamParameters.md#classpeerstream_1_1client_1_1_i_video_streamer_1a468e1f42cb6bbddc40b8df2fdd1ce009)` > onVideoStreamParameters)` | Register for when video stream parameters are changed.
`typedef `[`VideoStreamID`](#classpeerstream_1_1client_1_1_i_video_streamer_1a40772b0751b24d8f7328e36f50a1d372) | 
`typedef `[`SharedConstBuffer`](#classpeerstream_1_1client_1_1_i_video_streamer_1a02ab4c2468a6f3c6901daa1f1f5331f5) | 
`typedef `[`OnDisplayFrameReceived`](#classpeerstream_1_1client_1_1_i_video_streamer_1a397c9711990a47b32bddec8610c75b4d) | 
`typedef `[`OnVideoStreamDestroyed`](#classpeerstream_1_1client_1_1_i_video_streamer_1a78fd8b03727c5afd70ac753babde9bbc) | 
`typedef `[`OnRetrieveBroadcastVideoStream`](#classpeerstream_1_1client_1_1_i_video_streamer_1ad6e8dbecac2bcd26d17f1fdd9c20f841) | 
`typedef `[`OnVideoStreamParameters`](#classpeerstream_1_1client_1_1_i_video_streamer_1a468e1f42cb6bbddc40b8df2fdd1ce009) | 

## Members

#### `public inline virtual  `[`~IVideoStreamer`](#classpeerstream_1_1client_1_1_i_video_streamer_1a1c01aa0d596d6bd6b8cf4a80d9a96aa1)`()` {#classpeerstream_1_1client_1_1_i_video_streamer_1a1c01aa0d596d6bd6b8cf4a80d9a96aa1}

#### `public void `[`initialize`](#classpeerstream_1_1client_1_1_i_video_streamer_1a25ab33620bb25e464d20f5be12a0e19a)`(const `[`StreamingOptions`](doxygen/md/peerstream::client::StreamingOptions.md#structpeerstream_1_1client_1_1_streaming_options)` & options)` {#classpeerstream_1_1client_1_1_i_video_streamer_1a25ab33620bb25e464d20f5be12a0e19a}

Initialize media system with streaming options provided.

#### `public void `[`startStreaming`](#classpeerstream_1_1client_1_1_i_video_streamer_1a071f44b3a5e6674af2f401968884216b)`(std::function< void(`[`VideoStreamID`](doxygen/md/VideoStreamID.md#classpeerstream_1_1client_1_1_i_video_streamer_1a40772b0751b24d8f7328e36f50a1d372))`> onStarted,std::function< void(VideoStreamErrorID)> onError)` {#classpeerstream_1_1client_1_1_i_video_streamer_1a071f44b3a5e6674af2f401968884216b}

Method to start streaming.

#### `public void `[`startViewing`](#classpeerstream_1_1client_1_1_i_video_streamer_1aa5a153fefecf9f3147d9f6578bf1a40e)`(const `[`VideoStreamID`](doxygen/md/VideoStreamID.md#classpeerstream_1_1client_1_1_i_video_streamer_1a40772b0751b24d8f7328e36f50a1d372)` & videoStreamID,std::function< void(`[`VideoStreamID`](doxygen/md/VideoStreamID.md#classpeerstream_1_1client_1_1_i_video_streamer_1a40772b0751b24d8f7328e36f50a1d372))`> onStarted,std::function< void(VideoStreamErrorID)> onError)` {#classpeerstream_1_1client_1_1_i_video_streamer_1aa5a153fefecf9f3147d9f6578bf1a40e}

Method to start viewing someone who is broadcasting.

#### `public void `[`stopStreaming`](#classpeerstream_1_1client_1_1_i_video_streamer_1a9bdf250b1bbd497b04f29aa0a405819d)`()` {#classpeerstream_1_1client_1_1_i_video_streamer_1a9bdf250b1bbd497b04f29aa0a405819d}

Method to stop broadcasting.

#### `public void `[`stopViewing`](#classpeerstream_1_1client_1_1_i_video_streamer_1a11382f3803a1d69e0cf9140eeff934b0)`(const `[`VideoStreamID`](doxygen/md/VideoStreamID.md#classpeerstream_1_1client_1_1_i_video_streamer_1a40772b0751b24d8f7328e36f50a1d372)` & videoStreamID)` {#classpeerstream_1_1client_1_1_i_video_streamer_1a11382f3803a1d69e0cf9140eeff934b0}

Method to stop viewing a specified stream.

#### `public void `[`enableAudioCapture`](#classpeerstream_1_1client_1_1_i_video_streamer_1a0841cdc2d918513e320a7b56021108ce)`(bool isEnabled)` {#classpeerstream_1_1client_1_1_i_video_streamer_1a0841cdc2d918513e320a7b56021108ce}

Method to enable/disable audio capture.

#### `public void `[`enableVideoCapture`](#classpeerstream_1_1client_1_1_i_video_streamer_1afc9513144df3e52151363b6567c91623)`(bool isEnabled)` {#classpeerstream_1_1client_1_1_i_video_streamer_1afc9513144df3e52151363b6567c91623}

Method to enable/disable video capture.

#### `public void `[`setMicrophoneVolume`](#classpeerstream_1_1client_1_1_i_video_streamer_1a89e6894164d172289d382e7999bfdb2b)`(int32_t val)` {#classpeerstream_1_1client_1_1_i_video_streamer_1a89e6894164d172289d382e7999bfdb2b}

Set the microphone volume. Valid values: 0 to 100.

#### `public void `[`setSpeakerVolume`](#classpeerstream_1_1client_1_1_i_video_streamer_1a27a2dd8a5fb7235ec47c3465585c15be)`(int32_t val)` {#classpeerstream_1_1client_1_1_i_video_streamer_1a27a2dd8a5fb7235ec47c3465585c15be}

Set the speaker volume. Valid values: 0 to 100.

#### `public void `[`setAudioInputDeviceID`](#classpeerstream_1_1client_1_1_i_video_streamer_1a904a15df37e2903afadf013516a5c316)`(int32_t index)` {#classpeerstream_1_1client_1_1_i_video_streamer_1a904a15df37e2903afadf013516a5c316}

Updates the audio input device ID.

#### `public void `[`setAudioOutputDeviceID`](#classpeerstream_1_1client_1_1_i_video_streamer_1aca5385e8068101953ae541bc01e07ca5)`(int32_t index)` {#classpeerstream_1_1client_1_1_i_video_streamer_1aca5385e8068101953ae541bc01e07ca5}

Updates the audio output device ID.

#### `public void `[`setVideoDevice`](#classpeerstream_1_1client_1_1_i_video_streamer_1af450c8323a50a7079578e6b578761526)`(int32_t index)` {#classpeerstream_1_1client_1_1_i_video_streamer_1af450c8323a50a7079578e6b578761526}

Set the video capability by index.

#### `public void `[`setVideoCapability`](#classpeerstream_1_1client_1_1_i_video_streamer_1ab3e76e4b94452a390ae11c150f8196f5)`(int32_t index)` {#classpeerstream_1_1client_1_1_i_video_streamer_1ab3e76e4b94452a390ae11c150f8196f5}

Set the video capability by index.

#### `public int32_t `[`selectedAudioInputDeviceID`](#classpeerstream_1_1client_1_1_i_video_streamer_1acbb9eea5b7c1f2d88a054c0425b7ce15)`()` {#classpeerstream_1_1client_1_1_i_video_streamer_1acbb9eea5b7c1f2d88a054c0425b7ce15}

Retrieves the current audio input device ID.

#### `public int32_t `[`selectedAudioOutputDeviceID`](#classpeerstream_1_1client_1_1_i_video_streamer_1a54bfeaf589cd223373b633c05685464c)`()` {#classpeerstream_1_1client_1_1_i_video_streamer_1a54bfeaf589cd223373b633c05685464c}

Retrieves the current audio output device ID.

#### `public int32_t `[`selectedVideoDevice`](#classpeerstream_1_1client_1_1_i_video_streamer_1acff1e95a7200200b380f192c544347f5)`()` {#classpeerstream_1_1client_1_1_i_video_streamer_1acff1e95a7200200b380f192c544347f5}

Retrieves the current video device ID.

#### `public int32_t `[`selectedVideoCapability`](#classpeerstream_1_1client_1_1_i_video_streamer_1ae7d01ddd85da78ac170fcd047d89b75d)`()` {#classpeerstream_1_1client_1_1_i_video_streamer_1ae7d01ddd85da78ac170fcd047d89b75d}

Retrieves the current video capability by index.

#### `public std::vector< std::string > `[`getAudioInputDevices`](#classpeerstream_1_1client_1_1_i_video_streamer_1a936b2cad47dc89c2ed1f5cda0e0d74be)`()` {#classpeerstream_1_1client_1_1_i_video_streamer_1a936b2cad47dc89c2ed1f5cda0e0d74be}

Returns a list of audio input devices.

#### `public std::vector< std::string > `[`getAudioOutputDevices`](#classpeerstream_1_1client_1_1_i_video_streamer_1a392b8b6effdf0729aeb5b6e517cbcf5c)`()` {#classpeerstream_1_1client_1_1_i_video_streamer_1a392b8b6effdf0729aeb5b6e517cbcf5c}

Returns a list of audio output devices.

#### `public std::vector< `[`VideoDevice`](doxygen/md/peerstream::client::VideoDevice.md#structpeerstream_1_1client_1_1_video_device)` > `[`getVideoDevices`](#classpeerstream_1_1client_1_1_i_video_streamer_1aa6945596967b57d076d4746947273f54)`()` {#classpeerstream_1_1client_1_1_i_video_streamer_1aa6945596967b57d076d4746947273f54}

Returns a list of video capabilities.

#### `public std::vector< `[`VideoCapability`](doxygen/md/peerstream::client::VideoCapability.md#structpeerstream_1_1client_1_1_video_capability)` > `[`getVideoCapabilities`](#classpeerstream_1_1client_1_1_i_video_streamer_1a314d857de307b874eccca35ddace69ed)`(int32_t deviceIndex)` {#classpeerstream_1_1client_1_1_i_video_streamer_1a314d857de307b874eccca35ddace69ed}

Returns a list of video capabilities.

#### `public void `[`retrieveBroadcastVideoStreamID`](#classpeerstream_1_1client_1_1_i_video_streamer_1a86b684c23c58b9eadcfa499078c09ec8)`(std::function< `[`OnRetrieveBroadcastVideoStream`](doxygen/md/OnRetrieveBroadcastVideoStream.md#classpeerstream_1_1client_1_1_i_video_streamer_1ad6e8dbecac2bcd26d17f1fdd9c20f841)` > onRetrieved)` {#classpeerstream_1_1client_1_1_i_video_streamer_1a86b684c23c58b9eadcfa499078c09ec8}

Returns the broadcast stream ID.

#### `public `[`core::signals::ConnectionPtr`](doxygen/md/ConnectionPtr.md#namespacepeerstream_1_1core_1_1signals_1aca3fd2deaf3c0f573c485c8e8ab0b31d)` registerDisplayFrameReceived `[`PS_SDK_NODISCARD`](#classpeerstream_1_1client_1_1_i_video_streamer_1af95e468ffa27b3b2c063c34333a485dc)`(std::function< `[`OnDisplayFrameReceived`](doxygen/md/OnDisplayFrameReceived.md#classpeerstream_1_1client_1_1_i_video_streamer_1a397c9711990a47b32bddec8610c75b4d)` > onFrameReceived)` {#classpeerstream_1_1client_1_1_i_video_streamer_1af95e468ffa27b3b2c063c34333a485dc}

Register for when a display frame is received.

#### `public `[`core::signals::ConnectionPtr`](doxygen/md/ConnectionPtr.md#namespacepeerstream_1_1core_1_1signals_1aca3fd2deaf3c0f573c485c8e8ab0b31d)` registerVideoStreamDestroyed `[`PS_SDK_NODISCARD`](#classpeerstream_1_1client_1_1_i_video_streamer_1ae3327cc64c97d6790d6c2800de62ba1c)`(std::function< `[`OnVideoStreamDestroyed`](doxygen/md/OnVideoStreamDestroyed.md#classpeerstream_1_1client_1_1_i_video_streamer_1a78fd8b03727c5afd70ac753babde9bbc)` > onVideoStreamDestroyed)` {#classpeerstream_1_1client_1_1_i_video_streamer_1ae3327cc64c97d6790d6c2800de62ba1c}

Register for when the video stream is destroyed.

#### `public `[`core::signals::ConnectionPtr`](doxygen/md/ConnectionPtr.md#namespacepeerstream_1_1core_1_1signals_1aca3fd2deaf3c0f573c485c8e8ab0b31d)` registerVideoStreamParameters `[`PS_SDK_NODISCARD`](#classpeerstream_1_1client_1_1_i_video_streamer_1a51fc40a29573b71f84b6e58eab6c8846)`(std::function< `[`OnVideoStreamParameters`](doxygen/md/OnVideoStreamParameters.md#classpeerstream_1_1client_1_1_i_video_streamer_1a468e1f42cb6bbddc40b8df2fdd1ce009)` > onVideoStreamParameters)` {#classpeerstream_1_1client_1_1_i_video_streamer_1a51fc40a29573b71f84b6e58eab6c8846}

Register for when video stream parameters are changed.

#### `typedef `[`VideoStreamID`](#classpeerstream_1_1client_1_1_i_video_streamer_1a40772b0751b24d8f7328e36f50a1d372) {#classpeerstream_1_1client_1_1_i_video_streamer_1a40772b0751b24d8f7328e36f50a1d372}

#### `typedef `[`SharedConstBuffer`](#classpeerstream_1_1client_1_1_i_video_streamer_1a02ab4c2468a6f3c6901daa1f1f5331f5) {#classpeerstream_1_1client_1_1_i_video_streamer_1a02ab4c2468a6f3c6901daa1f1f5331f5}

#### `typedef `[`OnDisplayFrameReceived`](#classpeerstream_1_1client_1_1_i_video_streamer_1a397c9711990a47b32bddec8610c75b4d) {#classpeerstream_1_1client_1_1_i_video_streamer_1a397c9711990a47b32bddec8610c75b4d}

#### `typedef `[`OnVideoStreamDestroyed`](#classpeerstream_1_1client_1_1_i_video_streamer_1a78fd8b03727c5afd70ac753babde9bbc) {#classpeerstream_1_1client_1_1_i_video_streamer_1a78fd8b03727c5afd70ac753babde9bbc}

#### `typedef `[`OnRetrieveBroadcastVideoStream`](#classpeerstream_1_1client_1_1_i_video_streamer_1ad6e8dbecac2bcd26d17f1fdd9c20f841) {#classpeerstream_1_1client_1_1_i_video_streamer_1ad6e8dbecac2bcd26d17f1fdd9c20f841}

#### `typedef `[`OnVideoStreamParameters`](#classpeerstream_1_1client_1_1_i_video_streamer_1a468e1f42cb6bbddc40b8df2fdd1ce009) {#classpeerstream_1_1client_1_1_i_video_streamer_1a468e1f42cb6bbddc40b8df2fdd1ce009}

