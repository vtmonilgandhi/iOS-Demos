//
//  ViewController.swift
//  ToDo
//
//  Created by Monil.Gandhi on 25/10/18.
//  Copyright © 2018 Monil.Gandhi. All rights reserved.
//

import UIKit
import RealmSwift

class WelcomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        title = "Welcome"
        
        if let _ = SyncUser.current {
            // We have already logged in here!
            self.navigationController?.viewControllers = [ProjectsViewController()]
            //self.navigationController?.pushViewController(ItemsViewController(), animated: true)
        } else {
            
            let alertController = UIAlertController(title: "Login to Realm Cloud", message: "", preferredStyle: .alert)
            
            let saveAction = UIAlertAction(title: "Login", style: .default, handler: { [unowned self]
                alert -> Void in
                let txtName = alertController.textFields![0] as UITextField
                let txtPassword = alertController.textFields![1] as UITextField
                //                let creds = SyncCredentials.nickname(textField.text!, isAdmin: true)
                
                let credentials = SyncCredentials.usernamePassword(username: txtName.text!, password: txtPassword.text!)
                SyncUser.logIn(with: credentials, server: Constants.AUTH_URL, onCompletion: { [weak self](user, err) in
                    if let _ = user {
                        self?.navigationController?.viewControllers = [ProjectsViewController()]
                    } else {
//                        fatalError(error.localizedDescription)
                        let alert = UIAlertController(title: "Alert", message: "Please enter correct username and password", preferredStyle: UIAlertController.Style.alert)
//                        alert.addAction(UIAlertAction(title: "Click", style: UIAlertAction.Style.default, handler: nil))
                        self?.present(alert, animated: true, completion: nil)
                    }
                })
            })
            alertController.addTextField(configurationHandler: {(textField : UITextField!) -> Void in
                textField.placeholder = "Enter Username"
            })
            let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: { (action : UIAlertAction!) -> Void in })
            alertController.addTextField { (textField : UITextField!) -> Void in
                textField.placeholder = "Enter Password"
            }
            
            alertController.addAction(saveAction)
            alertController.addAction(cancelAction)
            
            self.present(alertController, animated: true, completion: nil)
        }
    }
}
