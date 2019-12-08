//
//  NewsAppTests.swift
//  NewsAppTests
//
//  Created by David Phillips on 1/12/19.
//  Copyright © 2019 David Phillips. All rights reserved.
//

import XCTest
import ObjectMapper
@testable import NewsApp

class NewsAppTests: XCTestCase {

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
    
    // MARK: - Test Mapping data
    
    func testNewsArticleMapsData() {
        let jsonDictionary: [String: Any] = ["headline": "News News News", "theAbstract": "A lot of news in here.", "byLine": "Bob Frank", "timeStamp": 5123986376213]
        let article = Mapper<NewsArticle>().map(JSON: jsonDictionary)

        XCTAssertEqual(article?.headline, "News News News")
        XCTAssertEqual(article?.abstract, "A lot of news in here.")
        XCTAssertEqual(article?.byLine, "Bob Frank")
        XCTAssertEqual(article?.timeStamp, 5123986376213)
    }
    
    func testFindingSmallestImageAndRelatedImagesMapping() {
        let jsonDictionary: [String: Any] = ["headline": "News News News", "theAbstract": "A lot of news in here.", "byLine": "Bob Frank", "relatedImages":[
            ["url": "https://www.url.com", "width": 500, "height": 600],
            ["url": "https://www.url2.com", "width": 100, "height": 250],
            ["url": "https://www.url3.com", "width": 1500, "height": 600],
            ["url": "https://www.url4.com", "width": 400, "height": 400]]
        ]
        let article = Mapper<NewsArticle>().map(JSON: jsonDictionary)
        
        XCTAssertEqual(article?.thumbnail, "https://www.url2.com")
    }
    
    func testNewsArticleImageMapsData() {
        let jsonDictionary: [String: Any] = ["url": "https://www.url.com", "width": 500, "height": 600]
        let image = Mapper<NewsArticleImage>().map(JSON: jsonDictionary)

        XCTAssertEqual(image?.url, "https://www.url.com")
        XCTAssertEqual(image?.width, 500)
        XCTAssertEqual(image?.height, 600)
    }
    
    func testNewsArticleImageMapsDataAndSetsSize() {
        let jsonDictionary: [String: Any] = ["url": "https://www.url.com", "width": 500, "height": 600]
        let image = Mapper<NewsArticleImage>().map(JSON: jsonDictionary)

        XCTAssertEqual(image?.url, "https://www.url.com")
        XCTAssertEqual(image?.width, 500)
        XCTAssertEqual(image?.height, 600)
        XCTAssertEqual(image?.size, 300000)
    }
    
    
    // MARK: - TimeStamp to Date
    
    func testDateStringFromTimeStampNotNil() {
        let timeStamp = 15750188503372019
        
        XCTAssertNotNil(DateUtils.convertTimeStampIntToDateString(timeStamp))
    }
    
    func testGetsDateStringFromTimeStamp() {
        let timeStamp = 15750188503372019
        
        XCTAssertEqual(DateUtils.convertTimeStampIntToDateString(timeStamp), "20:02 - 09 Aug")
    }

}
