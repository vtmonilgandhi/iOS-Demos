//
//  MainViewController.swift
//  LightManager
//
//  Created by Monil Gandhi on 20/06/18.
//  Copyright © 2018 Monil Gandhi. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    @IBAction func stackView(_: Any) {
        performSegue(withIdentifier: "first", sender: self)
    }

    @IBAction func withoutStackView(_: Any) {
        performSegue(withIdentifier: "second", sender: self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}
