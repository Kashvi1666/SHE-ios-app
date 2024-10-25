//
//  sheUITests.swift
//  sheUITests
//
//  Created by Kashvi Swami on 8/15/23.
//

import XCTest

final class sheUITests: XCTestCase {

    override func setUpWithError() throws {
        // setup code here
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        // method called after each test method in the class
    }

    func testExample() throws {
        // UI tests launch the application 
        let app = XCUIApplication()
        app.launch()

        // XCTAssert and related functions to verify results
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // measures time to launch 
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
