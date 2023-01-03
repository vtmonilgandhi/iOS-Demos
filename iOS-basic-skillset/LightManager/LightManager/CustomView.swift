//
//  CustomView.swift
//  LightManager
//
//  Created by Monil Gandhi on 19/06/18.
//  Copyright © 2018 Monil Gandhi. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class CustomView: UIView {
    let border = CALayer()

    @IBInspectable var borderWidth: CGFloat = 0.0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }

    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }

    @IBInspectable var borderColor: UIColor = UIColor.clear {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
    }
}
