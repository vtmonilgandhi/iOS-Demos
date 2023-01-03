//
//  ViewController.swift
//  ImageDownloader
//
//  Created by Monil Gandhi on 26/09/18.
//  Copyright © 2018 Monil Gandhi. All rights reserved.
//

import UIKit
import AFNetworking

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    createDownloadTask()
  }

  private func createDownloadTask(){
    let configurations = URLSessionConfiguration.default
    let manager = AFURLSessionManager(sessionConfiguration: configurations)
    let url = URL(string: "https://koenig-media.raywenderlich.com/uploads/2016/12/fake.png")
    let request = URLRequest(url: url!)
    let task = manager.downloadTask(with: request, progress: { progress in
      print("\(progress)")
    }, destination: nil, completionHandler: { (response,url,error) in
      if error == nil{
        print(response)
      }else{
        print(error?.localizedDescription ?? "Error")
      }
    })
    task.resume()
  }

}

