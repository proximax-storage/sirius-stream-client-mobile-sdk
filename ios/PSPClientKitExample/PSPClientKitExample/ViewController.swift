//
//  ViewController.swift
//  PSPClientKitExample
//
//  Created by Bastek on 10/2/18.
//  Copyright © 2018 PeerStream, Inc. All rights reserved.
//

import UIKit
import PSPClientKit


class ViewController: UIViewController, PSPClientAppObserver, PSPChannelObserver {

    var clientApp: PSPClientApp?
    var channel: PSPChannel?

    @IBOutlet weak var statusText: UITextView!
    @IBOutlet weak var registerButton: UIButton!

    @IBOutlet weak var createChannelView: UIView!
    @IBOutlet weak var inputField: UITextField!
    @IBOutlet weak var inputButton: UIButton!

    @IBOutlet weak var keyboardOffsetConstraint: NSLayoutConstraint?


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
                address: "dev.peerstreamprotocol.com:6996"
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


    func register() {
        log(">>> Registering...")

        clientApp?.registerUser(ClientRegisterObserver({ (userData) in
            self.log(">>> ON REGISTER SUCCESS: \(userData)")
            self.login(userData: userData)
        }, onFailure: { (code) in
            self.log(">>> ON REGISTER FAILURE: \(code): \(code.rawValue)")
        }))
    }

    func login(userData: PSPClientRegistrationData) {
        log(">>> Login...")

        clientApp?.login(userData, observer: ClientLoginObserver({ (userId) in
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
        guard let clientApp = self.clientApp, let userId = inputField.text else {
            return
        }

        log(">>> Creating a Channel...")
        clientApp.createChannel(
            userId,
            security: .secure,
            observer: ClientChannelObserver({ (channel) in
                self.log(">>> ON CHANNEL CREATED: \(channel.getIdentity())")
                self.updateWithChannel(channel: channel)
            }, onFailure: { (errorId) in
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

    /*
     * PSPClientAppObserver
     */
    func onApplicationReady(_ clientId: String) {
        log(">>> ON APPLICATION READY.")
    }

    func onApplicationFailed(_ errorId: PSPClientAppFailureCode) {
        log(">>> ON APPLICATION FAILED: \(errorId): \(errorId.rawValue)")
    }

    func onChannelRequested(_ clientId: String, userId: String) {
        log(">>> ON CHANNEL REQUESTED -  USER ID: \(userId)")
        guard let clientApp = self.clientApp else {
            return
        }

        log(">>> Accepting Channel Request...")
        clientApp.confirmChannel(
            userId,
            security: .secure,
            observer: ClientChannelObserver({ (channel) in
                self.log(">>> ON CHANNEL CONFIRMED: \(channel.getIdentity())")
                self.updateWithChannel(channel: channel)
            }, onFailure: { (errorId) in
                self.log(">>> ON CHANNEL CONFIRM ERROR: \(errorId): \(errorId.rawValue)")
            })
        )
    }

    func onNetworkStatus(_ clientId: String, status: PSPClientNetworkStatus) {
        log(">>> ON NETWORK STATUS: \(status)")
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
        log(">>> ON CHANNEL (\(channelId)) RAW RECEIVED.")
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
     * Private
     */
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
