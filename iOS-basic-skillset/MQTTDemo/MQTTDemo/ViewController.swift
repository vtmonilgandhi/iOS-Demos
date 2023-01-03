//
//  ViewController.swift
//  MQTTDemo
//
//  Created by Monil Gandhi on 20/06/18.
//  Copyright © 2018 Monil Gandhi. All rights reserved.
//

import CocoaMQTT
import UIKit

class ViewController: UIViewController {
    var mqtt: CocoaMQTT!

    override func viewDidLoad() {
        super.viewDidLoad()
        let clientID = "drnedwni"
        let mqtt = CocoaMQTT(clientID: clientID, host: "m12.cloudmqtt.com", port: 14752)
        mqtt.username = "drnedwni"
        mqtt.password = "IeMqj97jHY7G"
//    mqtt.willMessage = CocoaMQTTWill(topic: "/will", message: "dieout")
        mqtt.keepAlive = 60
        mqtt.delegate = self
        mqtt.allowUntrustCACertificate = true
        mqtt.connect()
        print(mqtt.connect())
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mqtt.didConnectAck = { mqtt, ack in
            if ack == .accept {
                mqtt.subscribe("testTopic")
            }
        }
    }
}

extension ViewController: CocoaMQTTDelegate {
    func mqtt(_: CocoaMQTT, didConnectAck _: CocoaMQTTConnAck) {
    }

    func mqtt(_: CocoaMQTT, didPublishMessage _: CocoaMQTTMessage, id _: UInt16) {
    }

    func mqtt(_: CocoaMQTT, didPublishAck _: UInt16) {
    }

    func mqtt(_: CocoaMQTT, didReceiveMessage message: CocoaMQTTMessage, id _: UInt16) {
        print("Message Recieved")
        print(message.string!)
    }

    func mqtt(_: CocoaMQTT, didSubscribeTopic topic: String) {
        print("Subscribed Topic : \(topic)")
    }

    func mqtt(_: CocoaMQTT, didUnsubscribeTopic topic: String) {
        print("UnSubscribed Topic : \(topic)")
    }

    func mqttDidPing(_: CocoaMQTT) {
    }

    func mqttDidReceivePong(_: CocoaMQTT) {
    }

    func mqttDidDisconnect(_: CocoaMQTT, withError _: Error?) {
    }
}
