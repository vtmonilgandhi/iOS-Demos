//
//  ViewController.swift
//  FaceVision
//
//  Created by Monil.Gandhi on 14/11/18.
//  Copyright © 2018 Monil.Gandhi. All rights reserved.
//
import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    fileprivate var selectedImage: UIImage! {
        didSet {
            imageView?.image = selectedImage
            let faceDetector = FaceDetector()
            DispatchQueue.global().async {
                faceDetector.highlightFaces(for: self.selectedImage) { (resultImage) in
                    DispatchQueue.main.async {
                        self.imageView?.image = resultImage
                    }
                }
            }
        }
    }
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBAction func selectImage(sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        present(picker, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedImage = UIImage(named: "tim")
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage
            else { fatalError("no image from image picker") }
        
        selectedImage = image
        
    }
}

