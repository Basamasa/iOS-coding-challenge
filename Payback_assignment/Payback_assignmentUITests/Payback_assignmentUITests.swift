//
//  Payback_assignmentUITests.swift
//  Payback_assignmentUITests
//
//  Created by Anzer Arkin on 26.07.22.
//

import XCTest

class Payback_assignmentUITests: XCTestCase {

    override func setUpWithError() throws {
    }

    func testExample() throws {
        let app = XCUIApplication()
        app.launch()
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
