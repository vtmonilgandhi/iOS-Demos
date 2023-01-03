//
//  FilterService.swift
//  CameraFilter
//
//  Created by Monil Gandhi on 06/01/21.
//

import Foundation
import UIKit
import CoreImage
import RxSwift

class FiltersService {
    private var context: CIContext
    
    init() {
        self.context = CIContext()
    }
    
    func applyFilter(to inputImage: UIImage) -> Observable<UIImage> {
        return Observable<UIImage>.create { observer in
            self.applyFilter(to: inputImage) { (filterdImage) in
                observer.onNext(filterdImage)
            }
            return Disposables.create()
        }
    }
    
    private func applyFilter(to inputImage: UIImage, completion: @escaping ((UIImage) -> ())) {
        let fliter = CIFilter(name: "CICMYKHalftone")!
        fliter.setValue(5.0, forKey: kCIInputWidthKey)
        
        if let sourceImage = CIImage(image: inputImage) {
            fliter.setValue(sourceImage, forKey: kCIInputImageKey)
            
            if let cgImage = self.context.createCGImage(fliter.outputImage!, from: fliter.outputImage!.extent) {
                let processedImage = UIImage(cgImage: cgImage, scale: inputImage.scale, orientation: inputImage.imageOrientation)
                completion(processedImage)
            }
        }
        
    }
}
