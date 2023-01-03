//
//  customPageControl.swift
//  LightManager
//
//  Created by Monil Gandhi on 20/06/18.
//  Copyright © 2018 Monil Gandhi. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class CustomPageControl: UIPageControl {
    @IBInspectable var vertical: Bool = true {
        didSet {
            transform.rotated(by: .pi / 2)
        }
    }
}
