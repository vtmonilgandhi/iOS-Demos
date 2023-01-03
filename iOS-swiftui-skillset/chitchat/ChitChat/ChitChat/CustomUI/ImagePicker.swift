//
//  ImagePicker.swift
//  ChitChat
//
//  Created by Gandhi Monil on 19/07/19.
//  Copyright © 2019 Gandhi Monil. All rights reserved.
//

import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    
    let isShown: Binding<Bool>
    let image: Binding<Image>
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        
        let isShown: Binding<Bool>
        let image: Binding<Image>
        
        init(isShown: Binding<Bool>, image: Binding<Image>) {
            self.isShown = isShown
            self.image = image
        }
        
        func imagePickerController(_ picker: UIImagePickerController,
                                   didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            let uiImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
            image.wrappedValue = Image(uiImage: uiImage)
            isShown.wrappedValue = false
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            isShown.wrappedValue = false
        }
        
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(isShown: isShown, image: image)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController,
                                context: UIViewControllerRepresentableContext<ImagePicker>) {
        
    }
}
