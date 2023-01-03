//
//  AlrmofireTests.swift
//  AlrmofireTests
//
//  Created by Monil Gandhi on 20/06/18.
//  Copyright © 2018 Monil Gandhi. All rights reserved.
//

import Alamofire
import SwiftyJSON
import XCTest

class AlrmofireTests: XCTestCase {
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testExample() {
        let promise = expectation(description: "Status : 200")

        Alamofire.request("http://api.androidhive.info/contacts/").responseJSON { (responseData) -> Void in
            if (responseData.result.value) != nil {
                let swiftyJsonVar = JSON(responseData.result.value!)
                if responseData.response?.statusCode == 200 {
                    promise.fulfill()
                } else {
                    XCTFail("Error")
                }
            }
        }
        waitForExpectations(timeout: 5, handler: nil)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
}
