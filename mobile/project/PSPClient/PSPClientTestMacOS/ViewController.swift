//
//  ViewController.swift
//  PSPClientTestMacOS
//
//  Created by Bastek on 4/22/19.
//  Copyright © 2019 PeerStream, Inc. All rights reserved.
//

import Cocoa
import AVFoundation
import PSPClientSDK


class ViewController: NSViewController, PSPClientAppObserver, PSPChannelObserver, PSPVideoStreamerObserver {

    // PSP
    var clientApp: PSPClientApp?
    var channel: PSPChannel?

    private var _videoStreamer: PSPVideoStreamer?
    var videoStreamer: PSPVideoStreamer? {
        get {
            if _videoStreamer == nil {
                _videoStreamer = clientApp?.getVideoStreamer()
            }
            return _videoStreamer
        }
    }

    // viewing
    typealias VideoViewer = (String, PSPView)
    var viewers = Dictionary<String, VideoViewer>()

    /*
     * MARK: - Storyboard Controls
     */
    // logging controls
    @IBOutlet weak var netStatusLabel: NSTextFieldCell!
    @IBOutlet weak var statusScrollView: NSScrollView!
    @IBOutlet weak var statusTextView: NSTextView!

    // app flow controls
    @IBOutlet weak var registerButton: NSButton!
    @IBOutlet weak var channelIdInput: NSTextField!
    @IBOutlet weak var channelIdButton: NSButton!
    @IBOutlet weak var messageScrollView: NSScrollView!
    @IBOutlet weak var messageTextView: NSTextView!
    @IBOutlet weak var messageInput: NSTextField!
    @IBOutlet weak var messageButton: NSButton!

    // video controls
    @IBOutlet weak var broadcasterView: PSPView!
    @IBOutlet weak var audioToggleButton: NSButton!
    @IBOutlet weak var videoToggleButton: NSButton!
    @IBOutlet weak var broadcastButton: NSButton!
    @IBOutlet weak var viewerIdInput: NSTextField!
    @IBOutlet weak var viewerButton: NSButton!
    @IBOutlet weak var viewerScrollView: NSScrollView!


    /*
     * MARK: - Setup / Teardown
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getAudioAccess()
    }


    func getAudioAccess() {
        switch AVCaptureDevice.authorizationStatus(for: .audio) {
        case .authorized: // The user has previously granted access to the camera.
            self.getVideoAccess()

        case .notDetermined: // The user has not yet been asked for camera access.
            AVCaptureDevice.requestAccess(for: .audio) { granted in
                if granted {
                    self.getVideoAccess()
                }
            }

        case .denied: // The user has previously denied access.
            log(">>> Cannot access video - previously denied.")
            return
        case .restricted: // The user can't grant access due to restrictions.
            log(">>> Cannot access video due to restrictions.")
            return
        }
    }


    func getVideoAccess() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized: // The user has previously granted access to the camera.
            self.setup()

        case .notDetermined: // The user has not yet been asked for camera access.
            AVCaptureDevice.requestAccess(for: .video) { granted in
                if granted {
                    self.setup()
                }
            }

        case .denied: // The user has previously denied access.
            log(">>> Cannot access video - previously denied.")
            return
        case .restricted: // The user can't grant access due to restrictions.
            log(">>> Cannot access video due to restrictions.")
            return
        }
    }


    func setup() {
        log(">>> Creating PSP Client Instance...")
        let config = PSPClientAppConfig(
            nameSpace: "peerstream",
            subNameSpace: "client",
            node: PSPClientBootstrapNode(
                mode: "discovery",
                handshakeKey: "",
                fingerprint: "15BD35F29D087DC1E33F5E4B2A0C7551C8212A506CBB1E946D299F7CFE892578",
                identity: "psp.discovery.node.2h2CF1JrVkbYFn2ynq5atK4FV6kRLepHEZFMLmAxRAjQzm9AJX",
                address: "dev.peerstreamprotocol.com:6996"
            )
        )

        self.clientApp = PSPClientApp.create(config, observer: self)
        if let clientApp = self.clientApp {
            log(">>> Starting PSP Client...")
            clientApp.start()
        }
    }


    /*
     * MARK: - Action Handlers
     */
    @IBAction func onRegister(_ sender: Any) {
        self.register()
    }


    @IBAction func onCreateChannel(_ sender: Any) {
        self.createChannel()
    }


    @IBAction func onSendMessage(_ sender: Any) {
        if let channel = self.channel {
            self.sendMessage(channel: channel)
        }
    }


    @IBAction func onAudioToggle(_ sender: Any) {
        videoStreamer?.enableAudioCapture(audioToggleButton.state == .on)
    }


    @IBAction func onVideoToggle(_ sender: Any) {
        videoStreamer?.enableVideoCapture(videoToggleButton.state == .on)
    }


    @IBAction func onBroadcast(_ sender: Any) {
        if self.broadcastButton.title == "Stop" {
            self.stopBroadcasting()
        } else {
            self.startBroadcasting(hasAudio: audioToggleButton.state == .on,
                                   hasVideo: videoToggleButton.state == .on)
        }
    }


    @IBAction func onViewVideo(_ sender: Any) {
         if let vid = self.videoStreamer {
            let streamId = viewerIdInput.stringValue

            // start the view process
            vid.startViewing(streamId, handler: VideoStreamRequestHandler({ (streamId) in
                self.log(">>> ON VIEW VIDEO STREAM STARTED: \(streamId)")
            }, onFailure: { (errorId) in
                self.log(">>> ON VIEW VIDEO START STREAMING ERROR: \(errorId): \(errorId.rawValue)")
            }))
        }
    }


    /*
     * MARK: -
     */
    func register() {
        log(">>> Registering...")

        clientApp?.registerUser(ClientRegisterHandler({ (userData) in
            self.log(">>> ON REGISTER SUCCESS: \(userData)")
            self.login(userData: userData)
        }, onFailure: { (code) in
            self.log(">>> ON REGISTER FAILURE: \(code): \(code.rawValue)")
        }))
    }

    func login(userData: PSPClientRegistrationData) {
        log(">>> Login...")

        clientApp?.login(userData, handler: ClientLoginHandler({ (userId, data) in
            self.log(">>> ON LOGIN SUCCESS: \(userId)")

            DispatchQueue.main.async {
                self.registerButton.isHidden = true
                self.channelIdInput.isHidden = false
                self.channelIdButton.isHidden = false
            }
        }, onFailure: { (code) in
            self.log(">>> ON LOGIN FAILURE: \(code): \(code.rawValue)")
        }))
    }

    func createChannel() {
        guard let clientApp = self.clientApp else {
            return
        }

        let userId = channelIdInput.stringValue
        log(">>> Creating a Channel: \(userId)")

        clientApp.createChannel(
            userId,
            security: .secure,
            handler: ClientChannelHandler({ (clientId, channel) in
                self.log(">>> ON CHANNEL CREATED: \(channel.getIdentity())")
                self.updateWithChannel(channel: channel)
            }, onFailure: { (clientId, errorId) in
                self.log(">>> ON CHANNEL CREATION ERROR: \(errorId): \(errorId.rawValue)")
            })
        )
    }

    func updateWithChannel(channel: PSPChannel) {
        log(">>> Updating to Channel Instance: \(channel.getIdentity())")
        self.channel = channel
        self.channel?.setObserver(self)

        DispatchQueue.main.async {
            self.channelIdInput.isHidden = true
            self.channelIdButton.isHidden = true
            self.messageScrollView.isHidden = false
            self.messageInput.isHidden = false
            self.messageButton.isHidden = false
        }
    }

    func resetChannel() {
        self.channel?.setObserver(nil)
        self.channel?.close()
        self.channel = nil

        DispatchQueue.main.async {
            self.channelIdInput.isHidden = false
            self.channelIdButton.isHidden = false
            self.messageScrollView.isHidden = true
            self.messageInput.isHidden = true
            self.messageButton.isHidden = true
        }
    }

    func sendMessage(channel: PSPChannel?) {
        guard let channel = channel else {
            return
        }

        log(">>> Sending a Message...")
        let message = messageInput.stringValue
        channel.sendMessage(message)

        // log and reset
        self.logMessage(message, outgoing: true)
        self.messageInput.stringValue = ""
    }

    func startBroadcasting(hasAudio: Bool, hasVideo: Bool) {
        if let vid = self.videoStreamer {
            log(">>> VIDEO STREAMER: \(vid)")

            let options = PSPVideoStreamOptions(
                audioCaptureEnabled: hasAudio,
                initialSpeakerVolume: 10,
                initialMicVolume: 100,
                videoCaptureEnabled: hasVideo,
                streamingWidth: 640,
                streamingHeight: 480,
                orientation: PSPVideoFrameOrientation.rotate0
            )

            vid.initialize(
                options,
                observer: self
            )

            // FIXME: not sure why PSP requires us to excplicitly call these??
            vid.enableAudioCapture(hasAudio)
            vid.enableVideoCapture(hasVideo)

            vid.startStreaming(VideoStreamRequestHandler({ (streamId) in
                self.log(">>> ON VIDEO STREAM STARTED: \(streamId)")

                // let's notify the channel
                if let channel = self.channel {
                    self.log(">>> Sharing my video stream...")
                    channel.shareStream(ChannelStreamHandler({ (streamId) in
                        self.log(">>> On video stream shared response: \(streamId)")
                    }, onFailure: { (eid: PSPVideoStreamErrorId) in
                        self.log(">>> On video stream shared error: \(eid): \(eid.rawValue)")
                    }))
                }

                DispatchQueue.main.async {
                    // update ui
                    self.broadcastButton.title = "Stop"
                }
            }, onFailure: { (errorId) in
                self.log(">>> ON VIDEO START STREAMING ERROR: \(errorId): \(errorId.rawValue)")
            }))
        }
    }


    func stopBroadcasting() {
        log(">>> Stopping broadcast...")

        if let videoStreamer = self.videoStreamer {
            // stop to stream
            videoStreamer.stopStreaming()

            // turn off broadcasting
            videoStreamer.enableAudioCapture(false)
            videoStreamer.enableVideoCapture(false)
        }
        _videoStreamer = nil

        // update ui
        self.broadcastButton.title = "Broadcast"
        broadcasterView?.cleanup()
    }

    /*
     * MARK: - PSPClientAppObserver
     */
    func onApplicationReady(_ clientId: String) {
        log(">>> ON APPLICATION READY.")
    }

    func onApplicationExit(_ code: PSPClientAppExitCode) {
        log(">>> ON APPLICATION FAILED: \(code): \(code.rawValue)")
    }

    func onChannelRequested(_ clientId: String, userId: String) {
        log(">>> ON CHANNEL REQUESTED -  USER ID: \(userId)")
        guard let clientApp = self.clientApp else {
            return
        }

        DispatchQueue.main.async {
            let accepted = self.showRequestDialog(
                title: "Channel Request",
                message: "You have received a channel request from: \n\n\(userId)\n\nWould you like to accept?"
            )
            if accepted {
                self.log(">>> Accepting Channel Request: \(userId)")
                clientApp.confirmChannel(
                    userId,
                    security: .secure,
                    handler: ClientChannelHandler({ (clientId, channel) in
                        self.log(">>> ON CHANNEL CONFIRMED: \(channel.getIdentity())")
                        self.updateWithChannel(channel: channel)
                    }, onFailure: { (clientId, errorId) in
                        self.log(">>> ON CHANNEL CONFIRM ERROR: \(errorId): \(errorId.rawValue)")
                    })
                )
            } else {
                self.log(">>> Denying Channel Request: \(userId)")
                clientApp.denyChannel(userId)
            }
        }
    }

    func onNetworkStatus(_ clientId: String, status: PSPClientNetworkStatus) {
        DispatchQueue.main.async {
            let strength = (status.networkConnectivity * 100).rounded() / 100
            self.netStatusLabel.stringValue = "Network Strength: \(strength)%\t\t Connected Nodes: \(status.numEntryNodesConnected)"
        }
    }

    func onUserPresenceChange(_ clientId: String, userId: String, isActive: Bool) {
        log(">>> ON USER PRESENCE CHANGE - USER ID: \(userId), ACTIVE: \(isActive)")
    }


    /*
     * MARK: - PSPChannelObserver
     */
    func onStreamRequested(_ channelId: String) {
        log(">>> ON CHANNEL (\(channelId)) STREAM REQUESTED.")
        guard let channel = self.channel, channel.getIdentity() == channelId else {
            log(">>> Received onStreamRequested callback, but channel IDs do not match, ignoring: \(channelId)")
            return
        }

        DispatchQueue.main.async {
            let accepted = self.showRequestDialog(
                title: "Channel Stream Requested",
                message: "A video stream has been requested on this channel: \n\n\(channelId)\n\nWould you like to accept it?"
            )
            if accepted {
                self.log(">>> Confirming Video Stream: \(channelId)")
                channel.confirmVideoStreamRequest(ChannelStreamHandler({ (streamId) in
                    self.log(">>> ON CHANNEL CONFIRM RESPONSE: \(streamId)")
                    // FIXME: not sure what to do here..
                }, onFailure: { (eid: PSPVideoStreamErrorId) in
                    self.log(">>> ON CHANNEL STREAM CONFIRM ERROR: \(eid): \(eid.rawValue)")
                }))
            } else {
                self.log(">>> Denying Channel Video Stream Request: \(channelId)")
                channel.denyVideoStreamRequest()
            }
        }
    }

    func onStreamShared(_ channelId: String, streamId: String) {
        log(">>> ON CHANNEL (\(channelId)) STREAM SHARED: STREAM ID: \(streamId)")
        guard let channel = self.channel, channel.getIdentity() == channelId else {
            log(">>> Received onStreamShared callback, but channel IDs do not match, ignoring: \(channelId)")
            return
        }

        DispatchQueue.main.async {
            let accepted = self.showRequestDialog(
                title: "Channel Stream Shared",
                message: "A video stream has been shared on this channel: \n\n\(channelId)\n\nWould you like to request it?"
            )
            if accepted {
                self.log(">>> Requesting Video Stream: \(channelId)")
                channel.requestStream(ChannelStreamHandler({ (streamId) in
                    self.log(">>> ON CHANNEL REQUEST RESPONSE: \(streamId)")
                    // FIXME: view the stream
                }, onFailure: { (eid: PSPVideoStreamErrorId) in
                    self.log(">>> ON CHANNEL STREAM ERROR: \(eid): \(eid.rawValue)")
                }))
            }
        }
    }

    func onRawReceived(_ channelId: String, data: Data) {
        log(">>> ON CHANNEL (\(channelId)) RAW DATA RECEIVED.")
    }

    func onImageReceived(_ channelId: String, img: Data) {
        log(">>> ON CHANNEL (\(channelId)) IMAGE RECEIVED.")
    }

    func onMessageReceived(_ channelId: String, msg: String) {
        log(">>> ON CHANNEL (\(channelId)) MESSAGE RECEIVED: \(msg)")
        self.logMessage(msg, outgoing: false)
    }

    func onChannelError(_ channelId: String, errorId: PSPChannelErrorId) {
        log(">>> ON CHANNEL (\(channelId)) ERROR: \(errorId): \(errorId.rawValue)")
        if errorId == .channelClosed {
            //TODO: reset controls so we can do the dance again
            self.resetChannel()
        }
        // FIXME: other error IDs
    }


    /*
     * MARK: - PSPVideoStreamerObserver
     */
    func onVideoStreamDisplayFrameReceived(_ streamId: String,
                                           buffer: Data,
                                           width: Int32,
                                           height: Int32,
                                           orientation: PSPVideoFrameOrientation)
    {
        DispatchQueue.main.async {
            if streamId.isEmpty {
                self.processBroadcasterFrame(buffer: buffer,
                                             width: width,
                                             height: height)
            } else {
                self.processViewerFrame(streamId: streamId,
                                        buffer: buffer,
                                        width: width,
                                        height: height)
            }
        }
    }

    func onVideoStreamDestroyed(_ streamId: String) {
        log(">>> Video stream destroyed: \(streamId)")

        DispatchQueue.main.async {
            self.cleanupViewer(streamId: streamId)
        }
    }


    /*
     * MARK: - Private
     */
    private func processBroadcasterFrame(buffer: Data, width: Int32, height: Int32) {
        self.broadcasterView.update(buffer,
                                    width: UInt(width),
                                    height: UInt(height))
    }


    private func processViewerFrame(streamId: String, buffer: Data, width: Int32, height: Int32) {
        guard let (_, view) = viewers[streamId] else {
            // setting up YUV view and adding to hierarchy
            let w = self.broadcasterView.frame.width
            let h = self.broadcasterView.frame.height
            let frame = CGRect(x: 0,
                               y: CGFloat(viewers.count) * h,
                               width: w,
                               height: h)
            let view = PSPView(frame: frame)
            viewerScrollView.documentView?.addSubview(view)

            // cleanup if necessary and adjuster hash
            self.cleanupViewer(streamId: streamId)
            viewers[streamId] = VideoViewer(streamId, view)

            // adjust scroll container
            viewerScrollView.documentView?.setFrameSize(
                NSSize(width: w,
                       height: CGFloat(viewers.count) * h)
            )
            return
        }

        view.update(buffer,
                    width: UInt(width),
                    height: UInt(height))
    }


    private func cleanupViewer(streamId: String) {
        if let (_, view) = viewers[streamId] {
            view.removeFromSuperview()
            viewers[streamId] = nil
        }
    }


    private func log(_ message: String) {
        NSLog(message)

        DispatchQueue.main.async {
            let attributes = [NSAttributedString.Key.foregroundColor: NSColor.textColor,
                              NSAttributedString.Key.backgroundColor: NSColor.textBackgroundColor]
            self.statusTextView.textStorage?.append(
                NSAttributedString(string: message + "\n", attributes: attributes)
            )
            self.scrollToBottom(textView: self.statusTextView)
        }
    }


    private func logMessage(_ message: String, outgoing: Bool) {
        DispatchQueue.main.async {
            let msg = "\(outgoing ? "SENT:" : "RECEIVED:") \(message)\n\n"

            let attributes = [NSAttributedString.Key.foregroundColor: NSColor.textColor,
                              NSAttributedString.Key.backgroundColor: NSColor.textBackgroundColor]
            self.messageTextView.textStorage?.append(
                NSAttributedString(string: msg, attributes: attributes)
            )
            self.scrollToBottom(textView: self.messageTextView)
        }
    }


    private func scrollToBottom(textView: NSTextView) {
        textView.scrollRangeToVisible(
            NSRange(location: self.statusTextView.string.count, length: 0)
        )
    }


    private func showRequestDialog(title: String, message: String) -> Bool {
        let alert = NSAlert()
        alert.messageText = title
        alert.informativeText = message
        alert.alertStyle = .informational
        alert.addButton(withTitle: "Accept")
        alert.addButton(withTitle: "Deny")
        return alert.runModal() == .alertFirstButtonReturn
    }
}


/*
 * MARK: - PSPClientRegistrationData
 */
extension PSPClientRegistrationData {
    open override var description: String {
        return "[PSPClientRegistrationData] identity: \(identity), secret key: \(secretKey), certificate: \(certificate)"
    }
}


/*
 * MARK: - PSPClientNetworkStatus
 */
extension PSPClientNetworkStatus {
    open override var description: String {
        return "[PSPClientNetworkStatus] networkConnectivity: \(networkConnectivity), numEntryNodesConnected: \(numEntryNodesConnected)"
    }
}


/*
 * MARK: - VideoContainerView
 */
// scroll view hack to append videos top to bottom
class VideoContainerView: NSClipView {
    override var isFlipped: Bool {
        return true
    }
}
