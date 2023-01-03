//
//  ConcentrationThemeChooserViewController.swift
//  Concentration
//
//  Created by Monil Gandhi on 4/30/18.
//  Copyright © 2018 Monil Gandhi. All rights reserved.
//

import UIKit

class ConcentrationThemeChooserViewController: UIViewController, UISplitViewControllerDelegate {
    let themes = [
        "Sports": "⚽️🏈🏑🏓🎾🏉🎱🏏",
        "Animals": "🐶🐱🐭🐹🐰🦊🐯🐷",
        "Faces": "😊😇😍😙🙃😎🤠🤡😣",
    ]

    private var splitViewDetaisConcentartionCiewController: ConcentrationViewController? {
        return splitViewController?.viewControllers.last as? ConcentrationViewController
    }

    private var lastSeguedToConcentrationViewController: ConcentrationViewController?

    @IBAction func changeTheme(_ sender: Any) {
        if let cvc = splitViewDetaisConcentartionCiewController {
            if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName] {
                cvc.theme = theme
            }
        } else if let cvc = lastSeguedToConcentrationViewController {
            if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName] {
                cvc.theme = theme
            }
            navigationController?.pushViewController(cvc, animated: true)
        } else {
            performSegue(withIdentifier: "Choose Theme", sender: sender)
        }
    }

    override func awakeFromNib() {
        splitViewController?.delegate = self
    }

    func splitViewController(_: UISplitViewController,
                             collapseSecondary secondaryViewController: UIViewController,
                             onto _: UIViewController) -> Bool {
        if let cvc = secondaryViewController as? ConcentrationViewController {
            if cvc.theme == nil {
                return true
            }
        }
        return false
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Choose Theme" {
            if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName] {
                if let cvc = segue.destination as? ConcentrationViewController {
                    cvc.theme = theme
                    lastSeguedToConcentrationViewController = cvc
                }
            }
        }
    }
}
