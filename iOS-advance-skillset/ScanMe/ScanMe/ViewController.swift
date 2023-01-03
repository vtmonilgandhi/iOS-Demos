//
//  ViewController.swift
//  ScanMe
//
//  Created by Monil.Gandhi on 15/11/18.
//  Copyright © 2018 Monil.Gandhi. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    
    // MARK: - Outlets
    @IBOutlet weak var viewPreview: UIView!
    @IBOutlet weak var lblString: UILabel!
    @IBOutlet weak var btnStartStop: UIButton!
    var captureSession: AVCaptureSession?
    var videoPreviewLayer: AVCaptureVideoPreviewLayer!
    var isReading: Bool = false
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewPreview.layer.cornerRadius = 5;
        btnStartStop.layer.cornerRadius = 5;
        captureSession = nil;
        lblString.text = "Barcode discription...";
    }
    
    // MARK: - IBAction Method
    @IBAction func startStopClick(_ sender: UIButton) {
        if !isReading {
            if (self.startReading()) {
                btnStartStop.setTitle("Stop", for: .normal)
                lblString.text = "Scanning for QR Code..."
            }
        }
        else {
            stopReading()
            btnStartStop.setTitle("Start", for: .normal)
        }
        isReading = !isReading
    }
    
    // MARK: - Custom Method
    func startReading() -> Bool {
        let captureDevice = AVCaptureDevice.default(for: AVMediaType.video)
        do {
            let input = try AVCaptureDeviceInput(device: captureDevice!)
            captureSession = AVCaptureSession()
            captureSession?.addInput(input)
            // Do the rest of your work...
        } catch let error as NSError {
            // Handle any errors
            print(error)
            return false
        }
        
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
        videoPreviewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        videoPreviewLayer.frame = viewPreview.layer.bounds
        viewPreview.layer.addSublayer(videoPreviewLayer)
        
        /* Check for metadata */
        let captureMetadataOutput = AVCaptureMetadataOutput()
        captureSession?.addOutput(captureMetadataOutput)
        captureMetadataOutput.metadataObjectTypes = captureMetadataOutput.availableMetadataObjectTypes
        print(captureMetadataOutput.availableMetadataObjectTypes)
        captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        captureSession?.startRunning()
        
        return true
    }
    
    @objc func stopReading() {
        captureSession?.stopRunning()
        captureSession = nil
        videoPreviewLayer.removeFromSuperlayer()
    }
    
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {
        for data in metadataObjects {
            let metaData = data as! AVMetadataObject
            print(metaData.description)
            let transformed = videoPreviewLayer?.transformedMetadataObject(for: metaData) as? AVMetadataMachineReadableCodeObject
            if let unwraped = transformed {
                print(unwraped.stringValue!)
                lblString.text = unwraped.stringValue
                btnStartStop.setTitle("Start", for: .normal)
                self.performSelector(onMainThread: #selector(stopReading), with: nil, waitUntilDone: false)
                isReading = false;
            }
        }
    }
}
