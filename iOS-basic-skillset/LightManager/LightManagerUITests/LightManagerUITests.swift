//
//  LightManagerUITests.swift
//  LightManagerUITests
//
//  Created by Monil Gandhi on 20/06/18.
//  Copyright © 2018 Monil Gandhi. All rights reserved.
//

import XCTest

class LightManagerUITests: XCTestCase {
    override func setUp() {
        super.setUp()

        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testExample() {
        let app = XCUIApplication()
        let element = app.otherElements.containing(.navigationBar, identifier: "LightManager.View").children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
        element.children(matching: .other).element(boundBy: 0).switches["1"].tap()

        let element2 = element.children(matching: .other).element(boundBy: 2).children(matching: .other).element
        element2.children(matching: .button).element(boundBy: 0).tap()
        element2.children(matching: .button).element(boundBy: 1).tap()
        element2.children(matching: .button).element(boundBy: 2).tap()
        element.children(matching: .other).element(boundBy: 3).switches["1"].tap()
        app.navigationBars["LightManager.View"].buttons["Back"].tap()
        app.buttons["Without StackView LightManager"].tap()

        let element3 = app.otherElements.containing(.navigationBar, identifier: "LightManager.SecondView").children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
        element3.children(matching: .other).element(boundBy: 0).switches["1"].tap()
        app.switches["1"].tap()
        element3.children(matching: .other).element(boundBy: 1).children(matching: .button).element(boundBy: 0).tap()
        app.navigationBars["LightManager.SecondView"].buttons["Back"].tap()

        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
}
