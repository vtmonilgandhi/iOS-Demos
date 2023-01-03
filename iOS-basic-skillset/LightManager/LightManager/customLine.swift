//
//  customLine.swift
//  LightManager
//
//  Created by Monil Gandhi on 21/06/18.
//  Copyright © 2018 Monil Gandhi. All rights reserved.
//

import Foundation
import UIKit
@IBDesignable class DottedVertical: UIView {
    @IBInspectable var dotColor: UIColor = UIColor.black
    @IBInspectable var lowerHalfOnly: Bool = false

    override func draw(_: CGRect) {
        // say you want 8 dots, with perfect fenceposting:
        let totalCount = 8 + 8 - 1
        let fullHeight = bounds.size.height
        let width = bounds.size.width
        let itemLength = fullHeight / CGFloat(totalCount)

        let path = UIBezierPath()

        let beginFromTop = CGFloat(0.0)
        let top = CGPoint(x: width / 2, y: beginFromTop)
        let bottom = CGPoint(x: width / 2, y: fullHeight)

        path.move(to: top)
        path.addLine(to: bottom)

        path.lineWidth = 8

//    let dashes: [CGFloat] = [itemLength, itemLength]
//    path.setLineDash(dashes, count: dashes.count, phase: 0)

        // for ROUNDED dots, simply change to....
        let dashes: [CGFloat] = [0.001, itemLength * 2]
        path.lineCapStyle = CGLineCap.round
        path.setLineDash(dashes, count: dashes.count, phase: 0)

        dotColor.setStroke()
        path.stroke()
    }
}
