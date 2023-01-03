//
//  CassiniViewController.swift
//  Cassini
//
//  Created by Monil Gandhi on 5/1/18.
//  Copyright © 2018 Monil Gandhi. All rights reserved.
//

import UIKit

class CassiniViewController: UIViewController {

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if let url = DemoURLs.NASA[identifier] {
                var destination = segue.destination
                if let navcon = destination as? UINavigationController {
                    destination = navcon.visibleViewController ?? navcon
                }
                if let imageVC = destination as? ImageViewController {
                    imageVC.imageURL = url
                    imageVC.title = (sender as? UIButton)?.currentTitle
                }
            }
        }
    }
}
