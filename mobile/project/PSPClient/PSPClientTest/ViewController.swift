//
//  ViewController.swift
//  PSPClientTest
//
//  Created by Bastek on 3/20/19.
//  Copyright © 2019 PeerStream, Inc. All rights reserved.
//

import UIKit
import PSPClientKit


class ViewController: UIViewController, PSPClientAppObserver, PSPChannelObserver, PSPVideoStreamerObserver {

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

    // broadcasting
    var broadcasterView: PSPView?

    // viewing
    typealias VideoViewer = (String, PSPView)
    var viewers = Dictionary<String, VideoViewer>()
    
    /*
     * MARK: - Storyboard Controls
     */
    @IBOutlet weak var statusText: UITextView!
    @IBOutlet weak var registerButton: UIButton!

    @IBOutlet weak var createChannelView: UIView!
    @IBOutlet weak var inputField: UITextField!
    @IBOutlet weak var inputButton: UIButton!

    @IBOutlet weak var broadcasterHolder: UIView!
    @IBOutlet weak var viewerHolder: UIView!
    @IBOutlet weak var viewVideoButton: UIButton!

    @IBOutlet weak var keyboardOffsetConstraint: NSLayoutConstraint?


    /*
     * MARK: - Setup / Teardown
     */
    override func viewDidLoad() {
        super.viewDidLoad()

        log(">>> Creating PSP Client Instance...")
        let config = PSPClientAppConfig(
            nameSpace: "peerstream",
            subNameSpace: "client",
            node: PSPClientBootstrapNode(
                mode: "discovery",
                handshakeKey: "",
                fingerprint: "15BD35F29D087DC1E33F5E4B2A0C7551C8212A506CBB1E946D299F7CFE892578",
                identity: "psp.discovery.node.2h2CF1JrVkbYFn2ynq5atK4FV6kRLepHEZFMLmAxRAjQzm9AJX",
                address: "dev.peerstreamprotocol.com:6001"
            )
        )
        
        self.clientApp = PSPClientApp.create(config, observer: self)
        if let clientApp = self.clientApp {
            log(">>> Starting PSP Client...")
            clientApp.start()
        }

        // keyboard events:
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(onKeyboardChange(notification:)),
                                               name: UIResponder.keyboardWillChangeFrameNotification,
                                               object: nil)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    @objc func onKeyboardChange(notification: Notification) {
        if let userInfo = notification.userInfo {
            let endFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
            let endFrameY = endFrame?.origin.y ?? 0
            let duration:TimeInterval = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
            let animationCurveRawNSN = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber
            let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIView.AnimationOptions.curveEaseInOut.rawValue
            let animationCurve:UIView.AnimationOptions = UIView.AnimationOptions(rawValue: animationCurveRaw)
            if endFrameY >= UIScreen.main.bounds.size.height {
                self.keyboardOffsetConstraint?.constant = 0.0
            } else {
                self.keyboardOffsetConstraint?.constant = endFrame?.size.height ?? 0.0
            }
            UIView.animate(withDuration: duration,
                           delay: TimeInterval(0),
                           options: animationCurve,
                           animations: { self.view.layoutIfNeeded() },
                           completion: nil)
        }
    }


    /*
     * MARK: - Action Handlers
     */
    @IBAction func onRegisterButtonPressed() {
        self.register()
    }
    

    @IBAction func onInputButtonPressed() {
        if let channel = self.channel {
            self.sendMessage(channel: channel)
        } else {
            self.createChannel()
        }
    }


    @IBAction func onViewVideoPressed() {
//        let alert = UIAlertController(title: "Token Prompt",
//                                      message: "Paste a video token of a user to start viewing.",
//                                      preferredStyle: .alert)
//        alert.addTextField { (textField) in
//            textField.placeholder = "Token"
//        }
//
//        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
//            // do nothing.
//        }
//        alert.addAction(cancelAction)
//        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
//            if let token = alert.textFields?.first?.text {
//                NSLog(">>> STARTING TO VIEW VIDEO WITH TOKEN: \(token)")
//
//                // start the view process
//                self.videoStreamer?.startViewing(token, handler: VideoStreamRequestHandler({ (streamId) in
//                    self.log(">>> ON VIEW VIDEO STREAM STARTED: \(streamId)")
//                }, onFailure: { (errorId) in
//                    self.log(">>> ON VIEW VIDEO START STREAMING ERROR: \(errorId): \(errorId.rawValue)")
//                }))
//            }
//        }
//        alert.addAction(okAction)
//        self.show(alert, sender: self)
        if let channel = self.channel {
            NSLog(">>> Closing a channel...")
            channel.close()
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
        //FIXME: testing
//        self.startBroadcasting(hasAudio: true, hasVideo: true)
    }

    func login(userData: PSPClientRegistrationData) {
        log(">>> Login...")

        clientApp?.login(userData, handler: ClientLoginHandler({ (userId, data) in
            self.log(">>> ON LOGIN SUCCESS: \(userId)")

            DispatchQueue.main.async {
                self.registerButton.isHidden = true
                self.createChannelView.isHidden = false
            }
        }, onFailure: { (code) in
            self.log(">>> ON LOGIN FAILURE: \(code): \(code.rawValue)")
        }))
    }

    func createChannel() {
        guard let clientApp = self.clientApp, var userId = inputField.text else {
            return
        }

        userId = "peerstream.client.account.2BTCXmsE45bdLoCgRGHSeekY9bCHyCn3xa39SLwnkMb32Qo5wP"

        log(">>> Creating a Channel...")
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
            self.inputField.text = nil
            self.inputField.placeholder = nil
            self.inputButton.setTitle("Send Message", for: .normal)
        }
    }

    func sendMessage(channel: PSPChannel?) {
        guard let channel = channel, let message = inputField.text else {
            return
        }

        log(">>> Sending a Message...")
        channel.sendMessage(message)

        // reset controls
        self.inputField.text = nil
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
//                    self.broadcastButton.title = "Stop"
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
        //reset
        _videoStreamer = nil

        // update ui
//        self.broadcastButton.title = "Broadcast"
        broadcasterView?.removeFromSuperview()
        broadcasterView = nil
    }

    /*
     * PSPClientAppObserver
     */
    func onApplicationReady(_ clientId: String) {
        log(">>> ON APPLICATION READY.")
    }

    func onApplicationExit(_ code: PSPClientAppExitCode) {
        log(">>> ON APPLICATION EXIT: \(code): \(code.rawValue)")
    }

    func onChannelRequested(_ clientId: String, userId: String) {
        log(">>> ON CHANNEL REQUESTED -  USER ID: \(userId)")
        guard let clientApp = self.clientApp else {
            return
        }

        DispatchQueue.main.async {
            let alert = UIAlertController(
                title: "Channel Request",
                message: "You have received a channel request from: \(userId). Would you like to accept?",
                preferredStyle: .alert
            )
            let actionAccept = UIAlertAction(title: "Accept", style: .default) { (action) in
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
            }
            alert.addAction(actionAccept)
            let actionDeny = UIAlertAction(title: "Deny", style: .cancel) { (action) in
                self.log(">>> Denying Channel Request: \(userId)")
                clientApp.denyChannel(userId)
            }
            alert.addAction(actionDeny)
            self.show(alert, sender: self)
        }
    }

    func onNetworkStatus(_ clientId: String, status: PSPClientNetworkStatus) {
//        log(">>> ON NETWORK STATUS: \(status)")
    }

    func onUserPresenceChange(_ clientId: String, userId: String, isActive: Bool) {
        log(">>> ON USER PRESENCE CHANGE - USER ID: \(userId), ACTIVE: \(isActive)")
    }


    /*
     * PSPChannelObserver
     */
    func onStreamRequested(_ channelId: String) {
        log(">>> ON CHANNEL (\(channelId)) STREAM REQUESTED.")
    }

    func onStreamShared(_ channelId: String, streamId: String) {
        log(">>> ON CHANNEL (\(channelId)) STREAM SHARED: STREAM ID: \(streamId)")
    }

    func onRawReceived(_ channelId: String, data: Data) {
        log(">>> ON CHANNEL (\(channelId)) RAW DATA RECEIVED.")
    }

    func onImageReceived(_ channelId: String, img: Data) {
        log(">>> ON CHANNEL (\(channelId)) IMAGE RECEIVED.")
    }

    func onMessageReceived(_ channelId: String, msg: String) {
        log(">>> ON CHANNEL (\(channelId)) MESSAGE RECEIVED: \(msg)")
    }

    func onChannelError(_ channelId: String, errorId: PSPChannelErrorId) {
        log(">>> ON CHANNEL (\(channelId)) ERROR: \(errorId): \(errorId.rawValue)")
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
     * Private
     */
    private func processBroadcasterFrame(buffer: Data, width: Int32, height: Int32) {
        guard let broadcasterView = self.broadcasterView else {
            let w = self.broadcasterHolder.frame.width
            let h = self.broadcasterHolder.frame.height

            self.broadcasterView = PSPView(frame: CGRect(x: 0,
                                                         y: 0,
                                                         width: w,
                                                         height: h))
            self.broadcasterView?.clipsToBounds = true
            self.broadcasterHolder.addSubview(self.broadcasterView!)
            return
        }

        broadcasterView.update(buffer,
                               width: UInt(width),
                               height: UInt(height))
    }


    private func processViewerFrame(streamId: String, buffer: Data, width: Int32, height: Int32) {
        guard let (_, view) = viewers[streamId] else {
            // setting up YUV view and adding to hierarchy
            let w = self.viewerHolder.frame.width
            let h = self.viewerHolder.frame.height
            let view = PSPView(frame: CGRect(x: 0,
                                             y: 0,//CGFloat(viewers.count) * h,
                                             width: w,
                                             height: h))
            self.viewerHolder.addSubview(view)//viewerScrollView.documentView?.addSubview(view)

            // cleanup if necessary and adjuster hash
            self.cleanupViewer(streamId: streamId)
            viewers[streamId] = VideoViewer(streamId, view)

            // adjust scroll container
//            viewerScrollView.documentView?.setFrameSize(
//                NSSize(width: w,
//                       height: CGFloat(viewers.count) * h)
//            )
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
            self.statusText.text += message + "\n"
            self.scrollToBottom()
        }
    }


    private func scrollToBottom() {
        if statusText.text.count > 0 {
            let location = statusText.text.count - 1
            let bottom = NSMakeRange(location, 1)
            statusText.scrollRangeToVisible(bottom)
        }
    }
}


extension PSPClientRegistrationData {
    open override var description: String {
        return "[PSPClientRegistrationData] identity: \(identity), secret key: \(secretKey), certificate: \(certificate)"
    }
}


extension PSPClientNetworkStatus {
    open override var description: String {
        return "[PSPClientNetworkStatus] networkConnectivity: \(networkConnectivity), numEntryNodesConnected: \(numEntryNodesConnected)"
    }
}
