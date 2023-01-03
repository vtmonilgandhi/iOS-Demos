//
//  ViewController.swift
//  Alrmofire
//
//  Created by Monil Gandhi on 14/06/18.
//  Copyright © 2018 Monil Gandhi. All rights reserved.
//

import Alamofire
import SwiftyJSON
import UIKit

class ViewController: UIViewController {
    @IBOutlet var tblJSON: UITableView!
    var arrRes = [[String: AnyObject]]() // Array of dictionary

    override func viewDidLoad() {
        super.viewDidLoad()
        tblJSON.delegate = self
        tblJSON.dataSource = self
        Alamofire.request("http://api.androidhive.info/contacts/").responseJSON { (responseData) -> Void in
            if (responseData.result.value) != nil {
                let swiftyJsonVar = JSON(responseData.result.value!)

                if let resData = swiftyJsonVar["contacts"].arrayObject {
                    self.arrRes = resData as! [[String: AnyObject]]
                }
                if self.arrRes.count > 0 {
                    self.tblJSON.reloadData()
                }
            }
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "jsonCell")!
        var dict = arrRes[indexPath.row]
        cell.textLabel?.text = dict["name"] as? String
        cell.detailTextLabel?.text = dict["email"] as? String
        return cell
    }

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return arrRes.count
    }
}
