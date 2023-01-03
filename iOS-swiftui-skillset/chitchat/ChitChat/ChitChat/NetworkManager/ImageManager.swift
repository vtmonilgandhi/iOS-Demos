//
//  ImageManager.swift
//  ChitChat
//
//  Created by Monil Gandhi on 29/08/19.
//  Copyright © 2019 Gandhi Monil. All rights reserved.
//

import Foundation
import Alamofire
import SwiftUI

class ImageManager {
    
    static let shared = ImageManager()
    
    // With Alamofire
    func uploadImage(image: UIImage, completion: @escaping () -> Void) {
        
        let imageData =  image.pngData()
            
        guard let url = URL(string: "https://api.imgur.com/3/upload") else {
            return
        }
        Alamofire.request(url,
                          method: .post,
                          parameters: ["Authorization": "Client-ID 0a06d71e21fde68",
                                       "image":imageData ?? ""])
            .validate()
            .responseJSON { response in
                guard response.result.isSuccess else {
                    print("Error while fetching remote rooms: \(String(describing: response.result.error))")
                    return
                }
                
                print(response)
                print(response.result.value)
//                guard let value = response.result.value as? [String: Any],
//                    let rows = value["rows"] as? [[String: Any]] else {
//                        print("Malformed data received from fetchAllRooms service")
//                        return
//                }
                
                //        let rooms = rows.flatMap { roomDict in return RemoteRoom(jsonData: roomDict) }
                //        completion(rooms)
        }
    }
    
    
}
