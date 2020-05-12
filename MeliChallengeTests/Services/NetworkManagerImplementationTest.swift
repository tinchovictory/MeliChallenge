//
//  NetworkManagerImplementationTest.swift
//  MeliChallengeTests
//
//  Created by Martin Victory on 12/05/2020.
//  Copyright © 2020 Martin Victory. All rights reserved.
//

import XCTest
import Moya
@testable import MeliChallenge

class NetworkManagerImplementationTest: XCTestCase {

    var networkManager: NetworkManagerImplementation!
    
    override func setUpWithError() throws {
        networkManager = NetworkManagerImplementation(provider: MoyaProvider<MeliAPI>(stubClosure: MoyaProvider.immediatelyStub))
    }

    override func tearDownWithError() throws {
        networkManager = nil
    }
    
    func testSearchResults() {
        let promise = expectation(description: "completition handler")
        
        var done = false
        var apiSearchResults: [APISearchResult]?
        
        networkManager.getSearchResults(q: "id1") { response in
            switch response {
            case .failure(_): break
            case .success(let searchResults): apiSearchResults = searchResults
            }
            done = true
            promise.fulfill()
        }
        
        wait(for: [promise], timeout: 5)
        XCTAssertTrue(done)
        XCTAssertNotNil(apiSearchResults)
    }
    
    func testItem() {
        let promise = expectation(description: "completition handler")
        
        var done = false
        var apiItem: APIItem?
        
        networkManager.getItem(withId: "id1") { response in
            switch response {
            case .failure(_): break
            case .success(let item): apiItem = item
            }
            done = true
            promise.fulfill()
        }
        
        wait(for: [promise], timeout: 5)
        XCTAssertTrue(done)
        XCTAssertNotNil(apiItem)
        
    }
    
    func testDescription() {
        let promise = expectation(description: "completition handler")
        
        var done = false
        var apiItemDescription: APIItemDescription?

        networkManager.getItemDescription(withId: "id1") { response in
            switch response {
            case .failure(_): break
            case .success(let description): apiItemDescription = description
            }
            done = true
            promise.fulfill()
        }
        
        wait(for: [promise], timeout: 5)
        XCTAssertTrue(done)
        XCTAssertNotNil(apiItemDescription)
    }
}
