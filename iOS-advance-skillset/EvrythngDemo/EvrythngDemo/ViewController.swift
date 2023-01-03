//
//  ViewController.swift
//  EvrythngDemo
//
//  Created by Monil Gandhi on 17/10/18.
//  Copyright © 2018 Monil Gandhi. All rights reserved.
//

import UIKit
import SwiftMQTT
import Alamofire

class ViewController: UIViewController {

  var mqttSession: MQTTSession!
  @IBOutlet var bulbSwitch: UISwitch!

  override func viewDidLoad() {
    super.viewDidLoad()

    mqttSession = MQTTSession(host: "mqtt.evrythng.com",
                              port: 8883,
                              clientID: String(Date().timeIntervalSince1970),
                              cleanSession: true,
                              keepAlive: 15,
                              useSSL: true)
    mqttSession.username = "authorization"
    mqttSession.password = "8jiSuRj2DtBQ1ouqytVKJ9zJtfvokTg8WuuPez2dPFvRbC9tOrBtsvePkGJyC2hmjikUAhjPa72yaSol"

    mqttSession.connect { error in

      if error == .none {
        print("Connected!")
        let topic = "/thngs/UpMg9dXYfc4f9cRaRkn6thsn/properties"
        self.mqttSession.subscribe(to: topic, delivering: .atLeastOnce) { error in
          if error == .none {
            print("Subscribed to \(topic)!")
            self.getIntialData()
          } else {
            print(error.description)
          }
        }

      } else {
        print(error.localizedDescription)
      }

    }

    mqttSession.delegate = self
  }

  private func getIntialData(){
    Alamofire.request("https://api.evrythng.com/thngs?access_token=8jiSuRj2DtBQ1ouqytVKJ9zJtfvokTg8WuuPez2dPFvRbC9tOrBtsvePkGJyC2hmjikUAhjPa72yaSol").responseData { (data) in
      do{
        let response = try JSON(data: data.data!)
        if response.arrayValue[0]["properties"]["status"] == "on"{
          self.bulbSwitch.setOn(true, animated: true)
        }else if response.arrayValue[0]["properties"]["status"] == "off"{
          self.bulbSwitch.setOn(false, animated: true)
        }
        print("Bulb is \(response.arrayValue[0]["properties"]["status"]).")
      }catch let error{
        print(error.localizedDescription)
      }
    }
  }

  @IBAction func toggleBulb(_ sender: UISwitch) {
    let json = [["value": sender.isOn ? "on" : "off",
                 "timestamp": String(Int64(Date().timeIntervalSince1970 * 1000))]]
    let data = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
    let topic = "/thngs/UpMg9dXYfc4f9cRaRkn6thsn/properties/status"
    mqttSession.publish(data!, in: topic, delivering: .atLeastOnce, retain: false) { error in
      if error == .none {
        print("Published data in \(topic).")
      } else {
        print(error.description)
      }
    }
  }
}

extension ViewController: MQTTSessionDelegate{
  func mqttDidReceive(message: MQTTMessage, from session: MQTTSession) {
    do{
      let response = try JSON(data: message.payload)
      if response.arrayValue[0]["value"] == "on"{
        bulbSwitch.setOn(true, animated: true)
      }else if response.arrayValue[0]["value"] == "off"{
        bulbSwitch.setOn(false, animated: true)
      }
      print("Bulb is \(response.arrayValue[0]["value"]).")
    }catch let error{
      print(error.localizedDescription)
    }
  }

  func mqttDidAcknowledgePing(from session: MQTTSession) {

  }

  func mqttDidDisconnect(session: MQTTSession, error: MQTTSessionError) {

  }


}
