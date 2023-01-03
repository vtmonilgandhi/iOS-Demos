//
//  ViewController.swift
//  ShareMyFeed
//
//  Created by Monil Gandhi on 26/09/18.
//  Copyright © 2018 Monil Gandhi. All rights reserved.
//

import UIKit
import Social

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }

  @IBAction func shareFeedPressed(_ sender: UIButton) {
    if let vc = SLComposeViewController(forServiceType: SLServiceTypeFacebook) {
      vc.setInitialText("Look at this great picture!")
      vc.add(UIImage(named: "myImage")!)
      vc.add(URL(string: "https://www.hackingwithswift.com"))
      present(vc, animated: true)
    }
  }
}

