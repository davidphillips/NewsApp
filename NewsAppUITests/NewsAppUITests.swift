//
//  NewsAppUITests.swift
//  NewsAppUITests
//
//  Created by David Phillips on 1/12/19.
//  Copyright © 2019 David Phillips. All rights reserved.
//

import XCTest

class NewsAppUITests: XCTestCase {
    
    var app: XCUIApplication!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        app = XCUIApplication()

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLaunchPerformance() {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
    
    func testCollectionViewExists() {
        app.launch()
        XCTAssertTrue(app.collectionViews.element(boundBy: 0).exists)
    }
    
    func testCollectionViewFirstElementExists() {
        app.launch()
        let firstChild = app.collectionViews.children(matching: .any).element(boundBy: 0)
        XCTAssertTrue(firstChild.exists)
    }
    
    // Tap first element of collectionView
    func testOpeningUrl() {
        app.launch()
        let firstChild = app.collectionViews.children(matching: .any).element(boundBy: 0)
        if firstChild.exists {
            firstChild.tap()
        }
    }
}
