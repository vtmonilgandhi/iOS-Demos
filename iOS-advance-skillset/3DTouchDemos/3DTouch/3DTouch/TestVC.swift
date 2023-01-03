//
//  ViewController.swift
//  3DTouch
//
//  Created by Monil.Gandhi on 19/11/18.
//  Copyright © 2018 Monil.Gandhi. All rights reserved.
//
import UIKit

class TestVC: UIViewController {
    
    
    weak var orngVC: OrangeVC?
    
    override var previewActionItems: [UIPreviewActionItem] {
        
        let shareAction = UIPreviewAction.init(title: "share", style: .default) { (shareAction, viewController) in
            if let orngVC = self.orngVC {
                orngVC.presentAlert()
            }
        }
        return [shareAction]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
