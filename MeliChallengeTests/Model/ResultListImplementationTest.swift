//
//  ResultListImplementationTest.swift
//  MeliChallengeTests
//
//  Created by Martin Victory on 12/05/2020.
//  Copyright © 2020 Martin Victory. All rights reserved.
//

import XCTest
@testable import MeliChallenge

class ResultListImplementationTest: XCTestCase {
    
    var model: ResultsListImplementation!
    var networkManager: MockNetworkManager!
    let searchWord = "searchWord"

    override func setUpWithError() throws {
        networkManager = MockNetworkManager()
        model = ResultsListImplementation(searchWord: searchWord, networkManager: networkManager)
    }

    override func tearDownWithError() throws {
        networkManager = nil
        model = nil
    }
    
    func testResultsFail() {
        networkManager.searchSuccess = false
        
        let promise = expectation(description: "completition handler")
        var success = false
        var done = false
        
        // model should return .failure(api error)
        model.results({ response in
            switch response {
            case .failure(_):
                success = false
            case .success(_):
                success = true
            }
            done = true
            promise.fulfill()
        })
        
        wait(for: [promise], timeout: 5)
        XCTAssertTrue(done)
        XCTAssertFalse(success)
    }
    
    func testResultsThumbnailsFail() {
        networkManager.imageSuccess = false
        
        let promise = expectation(description: "completition handler")
        var success = false
        var done = false
        var apiResults: [APISearchResult]?
        
        // model should return .success(but without image)
        model.results({ response in
            switch response {
            case .failure(_):
                success = false
            case .success(let results):
                success = true
                apiResults = results
            }
            done = true
            promise.fulfill()
        })
        
        wait(for: [promise], timeout: 5)
        XCTAssertTrue(done)
        XCTAssertTrue(success, "Result .success")
        XCTAssertNotNil(apiResults)
        
        if let apiResults = apiResults, let first = apiResults.first {
            XCTAssertEqual(first.id, networkManager.apiSearchResult.first?.id, "Id should match")
            XCTAssertNil(first.thumbnailData, "thumbnail data should be nil")
        } else {
            XCTAssertTrue(false)
        }
    }
    
    func testResultsSuccess() {
        let promise = expectation(description: "completition handler")
        var success = false
        var done = false
        var apiResults: [APISearchResult]?
        
        // model should return .success(but without image)
        model.results({ response in
            switch response {
            case .failure(_):
                success = false
            case .success(let results):
                success = true
                apiResults = results
            }
            done = true
            promise.fulfill()
        })
        
        wait(for: [promise], timeout: 5)
        XCTAssertTrue(done)
        XCTAssertTrue(success, "Result .success")
        XCTAssertNotNil(apiResults)
        
        if let apiResults = apiResults, let first = apiResults.first {
            XCTAssertEqual(first.id, networkManager.apiSearchResult.first?.id, "Id should match")
            XCTAssertNotNil(first.thumbnailData, "thumbnail data shouldn't be nil")
        } else {
            XCTAssertTrue(false)
        }
    }
}
