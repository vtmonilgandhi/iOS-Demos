//
//  DeviceViewController.swift
//  LightManager
//
//  Created by Monil Gandhi on 21/06/18.
//  Copyright © 2018 Monil Gandhi. All rights reserved.
//

import TGPControls
import UIKit

class DeviceViewController: UIViewController {
    var boostFlag = true
    var standFlag = true
    var bleflag = true

    @IBOutlet var topView: UIView!
    @IBOutlet var middleView: UIView!
    @IBOutlet var bottomView: UIView!

    @IBOutlet var scentSlider: TGPDiscreteSlider! {
        didSet {
            scentSlider.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2)
        }
    }

    @IBOutlet var boostImage: UIImageView!
    @IBOutlet var standByImage: UIImageView!

    @IBOutlet var batteryImage: UIImageView!
    @IBOutlet var scentImage: UIImageView!
    @IBOutlet var scentValue: UILabel!
    @IBOutlet var decreaseScent: UIImageView!
    @IBOutlet var increaseScent: UIImageView!
    @IBOutlet var scentLabel: UILabel!
    @IBOutlet var BLEImage: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        scentLabel.numberOfLines = 2
        scentLabel.text = "Scent\nIntensity"
        topView.addBorder(toSide: .Top,
                          withColor: #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1),
                          andThickness: 1.0)
        middleView.addBorder(toSide: .Top,
                             withColor: #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1),
                             andThickness: 1.0)
        bottomView.addBorder(toSide: .Top,
                             withColor: #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1),
                             andThickness: 1.0)
        bottomView.addBorder(toSide: .Bottom,
                             withColor: #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1),
                             andThickness: 1.0)
        scentValue.text = String(describing: Int(scentSlider.value))
        scentSlider.maximumTrackTintColor = #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1)
        scentSlider.minimumTrackTintColor = #colorLiteral(red: 0.1637246664, green: 0.7000024491, blue: 0.1171676264, alpha: 1)
        boostImage.isUserInteractionEnabled = true
        let boostImageGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(changeBoostImage))
        boostImage.addGestureRecognizer(boostImageGestureRecognizer)

        BLEImage.isUserInteractionEnabled = true
        let BLEImageImageGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(changeBLEImage))
        BLEImage.addGestureRecognizer(BLEImageImageGestureRecognizer)

        scentSlider.addTarget(self, action: #selector(onSliderValChanged(slider:event:)), for: .valueChanged)

        standByImage.isUserInteractionEnabled = true
        let standByImageGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(changestandByImage))
        standByImage.addGestureRecognizer(standByImageGestureRecognizer)

        increaseScent.isUserInteractionEnabled = true
        let increaseScentGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(increaseScentClick))
        increaseScent.addGestureRecognizer(increaseScentGestureRecognizer)

        decreaseScent.isUserInteractionEnabled = true
        let decreaseScentGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(decreaseScentClick))
        decreaseScent.addGestureRecognizer(decreaseScentGestureRecognizer)

        scentSlider.addTarget(self,
                              action: #selector(chagedSlider),
                              for: .valueChanged)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        _ = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(changeImage), userInfo: nil, repeats: true)
    }

    @objc func chagedSlider() {
        scentValue.text = String(describing: Int(scentSlider.value))
    }

    @objc func changeImage() {
        if scentImage.image == #imageLiteral(resourceName: "RefillLevel50") {
            scentImage.image = #imageLiteral(resourceName: "RefillLevel100")
        } else {
            scentImage.image = #imageLiteral(resourceName: "RefillLevel50")
        }

        if batteryImage.image == #imageLiteral(resourceName: "BatteryLevel0") {
            batteryImage.image = #imageLiteral(resourceName: "BatteryLevel100")
        } else {
            batteryImage.image = #imageLiteral(resourceName: "BatteryLevel0")
        }
    }

    @objc func onSliderValChanged(slider _: UISlider, event: UIEvent) {
        if let touchEvent = event.allTouches?.first {
            switch touchEvent.phase {
            case .began:
                // handle drag began
                scentSlider.thumbImage = #imageLiteral(resourceName: "ScentSlider")
            case .moved:
                // handle drag moved
                scentSlider.thumbImage = #imageLiteral(resourceName: "ScentSlider")
            case .ended:
                // handle drag ended
                scentSlider.thumbImage = UIImage()
            default:
                break
            }
        }
    }

    @objc func increaseScentClick() {
        if scentSlider.value > 1 {
            scentSlider.thumbImage = #imageLiteral(resourceName: "ScentSlider")

            scentSlider.value = scentSlider.value - CGFloat(scentSlider.incrementValue)
            scentValue.text = String(describing: Int(scentSlider.value))
        }
    }

    @objc func decreaseScentClick() {
        if scentSlider.value < 10 {
            scentSlider.thumbImage = #imageLiteral(resourceName: "ScentSlider")
            scentSlider.value = scentSlider.value + CGFloat(scentSlider.incrementValue)
            scentValue.text = String(describing: Int(scentSlider.value))
        }
    }

    @objc func changeBoostImage() {
        if boostFlag {
            boostImage.image = #imageLiteral(resourceName: "Boost-NotReady")
            boostFlag = false
        } else {
            boostImage.image = #imageLiteral(resourceName: "Boost-Ready")
            boostFlag = true
        }
    }

    @objc func changeBLEImage() {
        if bleflag {
            BLEImage.image = #imageLiteral(resourceName: "BluetoothOff")
            bleflag = false
        } else {
            BLEImage.image = #imageLiteral(resourceName: "BluetoothOn")
            bleflag = true
        }
    }

    @objc func changestandByImage() {
        if standFlag {
            standByImage.image = #imageLiteral(resourceName: "StandbyOff")
            standFlag = false
        } else {
            standByImage.image = #imageLiteral(resourceName: "StandbyOn")
            standFlag = true
        }
    }
}

extension UIView {
    enum ViewSide {
        case Left, Right, Top, Bottom
    }

    func addBorder(toSide side: ViewSide, withColor color: CGColor, andThickness thickness: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color
        switch side {
        case .Left: border.frame = CGRect(x: 0, y: 0, width: thickness, height: frame.size.height)
        case .Right: border.frame = CGRect(x: frame.size.width - thickness, y: 0, width: thickness, height: frame.size.height)
        case .Top: border.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: thickness)
        case .Bottom: border.frame = CGRect(x: 0, y: frame.size.height - thickness, width: frame.size.width, height: thickness)
        }
        layer.addSublayer(border)
    }
}
