//
//  FirestoreModel.swift
//  ChitChat
//
//  Created by Monil Gandhi on 26/08/19.
//  Copyright © 2019 Gandhi Monil. All rights reserved.
//

import Firebase
import Foundation
import FirebaseFirestore

class FirestoreModel {
    
    static let shared = FirestoreModel()
    var db = Firestore.firestore()
    let decoder = JSONDecoder()
    var user = User()
    let clientId = "Client-ID 0a06d71e21fde68"
    
    func addData(name: String, email: String, birthdate: String, phone:String, city: String, password: String,success successCallback: @escaping () -> Void, error errorCallback: @escaping (Swift.Error) -> Void) {
        //        var ref: DocumentReference? = nil
        db.collection("users").document(email).getDocument { (snapshot, error) in
            if snapshot!.exists {
                errorCallback(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "Data Already Exists"]))
            } else {
                self.db.collection("users").document(email).setData([
                    "name": name,
                    "email": email,
                    "birthdate": birthdate,
                    "city": city,
                    "phone": phone,
                    "password": password])
                { err in
                    if let err = err {
                        print("Error adding document: \(err)")
                        errorCallback(err)
                    } else {
                        print("Document added ")
                        successCallback()
                    }
                }
            }
        }
    }
    
    func login(email: String, password: String,success successCallback: @escaping () -> Void, error errorCallback: @escaping (Swift.Error) -> Void) {
        db.collection("users").document(email).getDocument { (snapshot, error) in
            if snapshot!.exists {
                if (snapshot?.get("email") as? String == email && snapshot?.get("password") as? String == password ){
                    successCallback()
                } else {
                    errorCallback(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "Please check your Email and Password"]))
                }
            }  else {
                errorCallback(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "Please check your Email"]))
            }
        }
    }
    
    func getUserData(email: String) {
        
        db.collection("users").document(email).getDocument { (snapshot, error) in
            if snapshot!.exists {
                do {
                    let jsonData = try? JSONSerialization.data(withJSONObject: snapshot?.data() ?? ["":""])
                    let data = try self.decoder.decode(User.self, from: jsonData!)
                    self.user = data
                } catch let error  {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    //MARK: - Upload image
      
    func uploadImage() {
       
    }
}
