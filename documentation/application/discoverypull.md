# Discovery Pull

## Definition
The client should read local configuration and use default list of discovery nodes send discovery request to get latest list of discovery nodes.

## Operation

Populate the version field and then pass to PSP via a circuit or stream.

C++ Example
```asm
static constexpr const char* discoveryVersion = "psp-discovery-1.0";

```

Having list of discovery nodes from config send request to receive discovery nodes
C++ Example
```asm

task_->push([this, bootstrapNodes]() {
    auto& streamMgr = container_.getRef<IStreamManager>();

    // Choose random node
    size_t randomIndex =
        container_.getRef<IRandomGenerator>().random(bootstrapNodes.size());

    const auto& discoveryNode = bootstrapNodes[randomIndex];

    connections_.push_back(streamMgr.registerStreamDestroyed(
        task_, [=](StreamID streamID) { streamConnections_.erase(streamID); }));

    streamMgr.getStreamToEndpoint(
        discoveryNode,
        StreamNamespaceID::discoveryProtocol,
        nullopt,
        task_->wrapByFuncSig<void(StreamPtr), StreamPtr>(
            [=](StreamPtr stream) { requestDiscovery(stream); }),
        [=](const CircuitException& ex) {
            PS_LOG_FATAL(logger_) << "Failed get to endpoint. " << ex;
        });
});
```

```asm
void DiscoveryManager::requestDiscovery(StreamPtr stream)
{
    auto streamID = stream->streamID();

    streamConnections_[streamID].push_back(stream->registerEscape<DiscoveryDirectory>(
        task_,
        EscapeMessageId::discoveryDirectoryMessage,
        [=](DiscoveryDirectory discoveryDir) {
            PS_LOG_INFO(logger_) << "Received discovery information from "
                                    "onion node on stream "
                                 << streamID;

            handleDiscoveryReceived(discoveryDir);
        }));

    PullDiscovery pullDisc;
    pullDisc.set_version(discoveryVersion);

    PS_LOG_TRACE(logger_) << "Requesting discovery from onion node on stream "
                          << stream->streamID();

    stream->escape(EscapeMessageId::discoveryPullMessage, move(pullDisc));
}

```

```asm
void DiscoveryManager::handleDiscoveryReceived(
    const protocol::DiscoveryDirectory& discoveryDir)
{
    auto discoveryListing =
        ProtobufHandler::toMsg<DiscoveryListing>(discoveryDir.directory());

    // TODO: Check version

    auto listExpiration = discoveryListing.expiration();

    for (const auto& item : discoveryListing.items())
    {
        auto discoveryItem = ProtobufHandler::toMsg<DiscoveryItem>(item);
...
```

## Payload

```
// internal messages
message PullDiscovery {
    string version = 1;
}

message DiscoveryItem {
    string version = 1;
    string identity = 2;
    string fingerprint = 3;
    string handshake = 4;
    string mode = 5;
    repeated string address = 6;
    uint64 expiration = 7;
}
```
