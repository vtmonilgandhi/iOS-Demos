//
//  TextFieldCollectionViewCellViewController.swift
//  EmojiArt
//
//  Created by Monil Gandhi on 5/7/18.
//  Copyright © 2018 Monil Gandhi. All rights reserved.
//

import UIKit

class TextFieldCollectionViewCell: UICollectionViewCell, UITextFieldDelegate {
    @IBOutlet var textField: UITextField! {
        didSet {
            textField.delegate = self
        }
    }

    var resignationHandler: (() -> Void)?

    func textFieldDidEndEditing(_: UITextField) {
        resignationHandler?()
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
