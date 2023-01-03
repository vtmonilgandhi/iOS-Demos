//
//  CustomTextFiled.swift
//  GhostyTextField
//
//  Created by Monil Gandhi on 19/06/18.
//  Copyright © 2018 Monil Gandhi. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class CustomUITextField: UITextField {
    let animationDuration = 0.3
    var title = UILabel()

    // MARK: - Properties

    override var accessibilityLabel: String? {
        get {
            if let txt = text, txt.isEmpty {
                return title.text
            } else {
                return text
            }
        }
        set {
            self.accessibilityLabel = newValue
        }
    }

    override var placeholder: String? {
        didSet {
            title.text = placeholder
            title.sizeToFit()
        }
    }

    override var attributedPlaceholder: NSAttributedString? {
        didSet {
            title.text = attributedPlaceholder?.string
            title.sizeToFit()
        }
    }

    var titleFont: UIFont = UIFont.systemFont(ofSize: 12.0) {
        didSet {
            title.font = titleFont
            title.sizeToFit()
        }
    }

    @IBInspectable var hintYPadding: CGFloat = 0.0

    @IBInspectable var titleYPadding: CGFloat = 0.5 {
        didSet {
            var r = title.frame
            r.origin.y = titleYPadding
            title.frame = r
        }
    }

    @IBInspectable var titleTextColour: UIColor = UIColor.gray {
        didSet {
            if !isFirstResponder {
                title.textColor = titleTextColour
            }
        }
    }

    @IBInspectable var titleActiveTextColour: UIColor! {
        didSet {
            if isFirstResponder {
                title.textColor = titleActiveTextColour
            }
        }
    }

    // MARK: - Init

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    // MARK: - Overrides

    override func layoutSubviews() {
        super.layoutSubviews()
        setTitlePositionForTextAlignment()
        let isResp = isFirstResponder
        if let txt = text, !txt.isEmpty && isResp {
            title.textColor = titleActiveTextColour
        } else {
            title.textColor = titleTextColour
        }
        // Should we show or hide the title label?
        if let txt = text, txt.isEmpty {
            // Hide
            hideTitle(isResp)
        } else {
            // Show
            showTitle(isResp)
        }
    }

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        var r = super.textRect(forBounds: bounds)
        if let txt = text, !txt.isEmpty {
            var top = ceil(title.font.lineHeight + hintYPadding)
            top = min(top, maxTopInset())
            r = UIEdgeInsetsInsetRect(r, UIEdgeInsetsMake(top, 0.0, 0.0, 0.0))
        }
        return r.integral
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        var r = super.editingRect(forBounds: bounds)
        if let txt = text, !txt.isEmpty {
            var top = ceil(title.font.lineHeight + hintYPadding)
            top = min(top, maxTopInset())
            r = UIEdgeInsetsInsetRect(r, UIEdgeInsetsMake(top, 0.0, 0.0, 0.0))
        }
        return r.integral
    }

    override func clearButtonRect(forBounds bounds: CGRect) -> CGRect {
        var r = super.clearButtonRect(forBounds: bounds)
        if let txt = text, !txt.isEmpty {
            var top = ceil(title.font.lineHeight + hintYPadding)
            top = min(top, maxTopInset())
            r = CGRect(x: r.origin.x, y: r.origin.y + (top * 0.5), width: r.size.width, height: r.size.height)
        }
        return r.integral
    }

    // MARK: - Public Methods

    // MARK: - Private Methods

    fileprivate func setup() {
        borderStyle = UITextBorderStyle.none
        titleActiveTextColour = tintColor
        // Set up title label
        title.alpha = 0.0
        title.font = titleFont
        title.textColor = titleTextColour
        if let str = placeholder, !str.isEmpty {
            title.text = str
            title.sizeToFit()
        }
        addSubview(title)
    }

    fileprivate func maxTopInset() -> CGFloat {
        if let fnt = font {
            return max(0, floor(bounds.size.height - fnt.lineHeight - 4.0))
        }
        return 0
    }

    fileprivate func setTitlePositionForTextAlignment() {
        let r = textRect(forBounds: bounds)
        var x = r.origin.x
        if textAlignment == NSTextAlignment.center {
            x = r.origin.x + (r.size.width * 0.5) - title.frame.size.width
        } else if textAlignment == NSTextAlignment.right {
            x = r.origin.x + r.size.width - title.frame.size.width
        }
        title.frame = CGRect(x: x, y: title.frame.origin.y, width: title.frame.size.width, height: title.frame.size.height)
    }

    func showTitle(_ animated: Bool) {
        let dur = animated ? animationDuration : 0
        UIView.animate(withDuration: dur, delay: 0, options: [UIViewAnimationOptions.beginFromCurrentState, UIViewAnimationOptions.curveEaseOut], animations: {
            // Animation
            self.title.alpha = 1.0
            var r = self.title.frame
            r.origin.y = self.titleYPadding
            self.title.frame = r
        }, completion: nil)
    }

    func hideTitle(_ animated: Bool) {
        let dur = animated ? animationDuration : 0
        UIView.animate(withDuration: dur, delay: 0, options: [UIViewAnimationOptions.beginFromCurrentState, UIViewAnimationOptions.curveEaseIn], animations: {
            // Animation
            self.title.alpha = 0.0
            var r = self.title.frame
            r.origin.y = self.title.font.lineHeight + self.hintYPadding
            self.title.frame = r
        }, completion: nil)
    }

    override var tintColor: UIColor! {
        didSet {
            setNeedsDisplay()
        }
    }

    override func draw(_ rect: CGRect) {
        let startingPoint = CGPoint(x: rect.minX, y: rect.maxY)
        let endingPoint = CGPoint(x: rect.maxX, y: rect.maxY)

        let path = UIBezierPath()

        path.move(to: startingPoint)
        path.addLine(to: endingPoint)
        path.lineWidth = 1.0
        UIColor.lightGray.setStroke()
        tintColor.setStroke()
        path.stroke()
    }

    // Provides left padding for images
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var textRect = super.leftViewRect(forBounds: bounds)
        textRect.origin.x += leadingPadding
        return textRect
    }

    // Provides right padding for images
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        var textRect = super.rightViewRect(forBounds: bounds)
        textRect.origin.x += leadingPadding
        return textRect
    }

    @IBInspectable var leadingImage: UIImage? {
        didSet {
            updateView()
        }
    }

    @IBInspectable var leadingPadding: CGFloat = 0

    @IBInspectable var color: UIColor = UIColor.lightGray {
        didSet {
            updateView()
        }
    }

    @IBInspectable var colorImage: UIColor = #colorLiteral(red: 1, green: 0.3300932944, blue: 0.2421161532, alpha: 1) {
        didSet {
            updateView()
        }
    }

    @IBInspectable var rtl: Bool = false {
        didSet {
            updateView()
        }
    }

    func updateView() {
        //
        //      let errorLabel = UILabel(frame: CGRect(x: 0, y: bounds.size.height, width: frame.size.width, height: frame.size.height))
        ////      errorLabel.translatesAutoresizingMaskIntoConstraints = true
        ////      errorLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        ////      errorLabel.setContentHuggingPriority(.required, for: .vertical)
        //      errorLabel.text = "Error"
        //      errorLabel.textAlignment = .left
        //      errorLabel.numberOfLines = 0
        //      errorLabel.textColor = #colorLiteral(red: 1, green: 0.3300932944, blue: 0.2421161532, alpha: 1)
        //      addSubview(errorLabel)

        let toolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0,
                                                         y: 0,
                                                         width: frame.size.width,
                                                         height: 30))

        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                        target: nil,
                                        action: nil)

        let doneBtn = UIBarButtonItem(title: "Done",
                                      style: .done, target: self,
                                      action: #selector(doneButtonAction))
        toolbar.setItems([flexSpace, doneBtn], animated: false)
        toolbar.sizeToFit()

        inputAccessoryView = toolbar
        rightViewMode = UITextFieldViewMode.never
        rightView = nil
        leftViewMode = UITextFieldViewMode.never
        leftView = nil

        if let image = leadingImage {
            let view = UIView(frame: CGRect(x: 0, y: 1, width: 25, height: 20))
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
            imageView.image = image
            imageView.tintColor = colorImage
            view.addSubview(imageView)

            if rtl {
                rightViewMode = UITextFieldViewMode.always
                rightView = view
            } else {
                leftViewMode = UITextFieldViewMode.always
                leftView = view
            }
        }

        clearButtonMode = .whileEditing
        // Placeholder text color
        attributedPlaceholder = NSAttributedString(string: placeholder != nil ? placeholder! : "", attributes: [NSAttributedStringKey.foregroundColor: color])
    }

    @objc func doneButtonAction() {
        endEditing(true)
    }
}
