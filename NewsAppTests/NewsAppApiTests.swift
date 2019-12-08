//
//  NewsAppApiTests.swift
//  NewsAppTests
//
//  Created by David Phillips on 8/12/19.
//  Copyright © 2019 David Phillips. All rights reserved.
//

import XCTest
@testable import NewsApp

class NewsAppApiTests: XCTestCase, GetArticlesDelegate {
    
    private var apiExpectation: XCTestExpectation!
    private var articles: [NewsArticle] = []

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    // MARK: - Test API
       
    func testGetArticlesUseCase() {
        apiExpectation = expectation(description: "API")
        GetArticlesUseCase().request(delegate: self)
        
        waitForExpectations(timeout: 10)
        XCTAssertNotEqual(self.articles.count, 0)
    }
    
    func getArticlesResults(success: Bool, articles: [NewsArticle]) {
        if success {
            self.articles = articles
            apiExpectation.fulfill()
        }
    }

}
