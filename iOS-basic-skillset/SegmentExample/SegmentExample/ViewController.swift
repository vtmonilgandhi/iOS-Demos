//
//  ViewController.swift
//  SegmentExample
//
//  Created by Monil Gandhi on 18/06/18.
//  Copyright © 2018 Monil Gandhi. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {
    @IBOutlet var slderCtrl: UISlider!
    @IBOutlet var stepperCtrl: UIStepper!
    @IBOutlet var segmentCtrl: UISegmentedControl!

    @IBAction func stepLabel(_: Any) {
        let currentValue = stepperCtrl.value

        txtLabel.text = "\(currentValue)"
    }

    @IBAction func inputLabel(_: Any) {
        let currentValue = slderCtrl.value

        txtLabel.text = "\(currentValue)"
    }

    @IBOutlet var txtLabel: UILabel!
    @IBAction func indexChanged(_: Any) {
        switch segmentCtrl.selectedSegmentIndex
        {
        case 0:
            slderCtrl.isHidden = true
            stepperCtrl.isHidden = false
        case 1:
            slderCtrl.isHidden = false
            stepperCtrl.isHidden = true
        default:
            break
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        didTapButton()
        slderCtrl.isHidden = true

        UNUserNotificationCenter.current().delegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }

    func didTapButton() {
        // Request Notification Settings
        UNUserNotificationCenter.current().getNotificationSettings { notificationSettings in
            switch notificationSettings.authorizationStatus {
            case .notDetermined:
                self.requestAuthorization(completionHandler: { success in
                    guard success else { return }

                    // Schedule Local Notification
                    self.scheduleLocalNotification()
                })
            case .authorized:
                // Schedule Local Notification
                self.scheduleLocalNotification()
            case .denied:
                print("Application Not Allowed to Display Notifications")
            }
        }
    }

    private func requestAuthorization(completionHandler: @escaping (_ success: Bool) -> Void) {
        // Request Authorization
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { success, error in
            if let error = error {
                print("Request Authorization Failed (\(error), \(error.localizedDescription))")
            }

            completionHandler(success)
        }
    }

    private func scheduleLocalNotification() {
        // Create Notification Content
        let notificationContent = UNMutableNotificationContent()

        // Configure Notification Content
        notificationContent.title = "Cocoacasts"
        notificationContent.subtitle = "Local Notifications"
        notificationContent.body = "In this tutorial, you learn how to schedule local notifications with the User Notifications framework."

        // Add Trigger
        let notificationTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 10.0, repeats: false)

        // Create Notification Request
        let notificationRequest = UNNotificationRequest(identifier: "cocoacasts_local_notification", content: notificationContent, trigger: notificationTrigger)

        // Add Request to User Notification Center
        UNUserNotificationCenter.current().add(notificationRequest) { error in
            if let error = error {
                print("Unable to Add Notification Request (\(error), \(error.localizedDescription))")
            }
        }
    }
}

extension ViewController: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_: UNUserNotificationCenter, willPresent _: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert])
    }
}
