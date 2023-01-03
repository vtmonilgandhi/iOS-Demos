//
//  ViewController.swift
//  LightManager
//
//  Created by Monil Gandhi on 19/06/18.
//  Copyright © 2018 Monil Gandhi. All rights reserved.
//

import CocoaLumberjack
import TGPControls
import UIKit

class ViewController: UIViewController {
    @IBOutlet var topSwitch: UISwitch!
    @IBOutlet var bottomSwitch: UISwitch!
    @IBOutlet var topSwitchView: CustomView!
    @IBOutlet var bottomSwitchView: CustomView!

    @IBAction func topRedView(_: Any) {
        if topSwitch.isOn {
            DDLogInfo(String(topSwitch.isOn))
            topSwitchView.backgroundColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        }
    }

    @IBAction func okButton(_: Any) {
    }

    @IBAction func topSwitchAction(_ sender: UISwitch) {
        if !(sender.isOn) {
            topSwitchView.backgroundColor = UIColor.gray
        }
    }

    @IBAction func bottomSwitchAction(_ sender: UISwitch) {
        if !(sender.isOn) {
            bottomSwitchView.backgroundColor = UIColor.gray
        }
    }

    @IBAction func topGreenView(_: Any) {
        if topSwitch.isOn {
            topSwitchView.backgroundColor = #colorLiteral(red: 0.3882352941, green: 0.8549019608, blue: 0.2196078431, alpha: 1)
        }
    }

    @IBAction func topBlueView(_: Any) {
        if topSwitch.isOn {
            topSwitchView.backgroundColor = #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1)
        }
    }

    @IBAction func bottomRedView(_: Any) {
        if bottomSwitch.isOn {
            bottomSwitchView.backgroundColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        }
    }

    @IBAction func bottomGreenView(_: Any) {
        if bottomSwitch.isOn {
            bottomSwitchView.backgroundColor = #colorLiteral(red: 0.3882352941, green: 0.8549019608, blue: 0.2196078431, alpha: 1)
        }
    }

    @IBAction func bottomBlueView(_: Any) {
        if bottomSwitch.isOn {
            bottomSwitchView.backgroundColor = #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        DDLog.add(DDTTYLogger.sharedInstance)
    }

    @objc func tapOnView() {
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
