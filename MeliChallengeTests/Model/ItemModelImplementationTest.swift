//
//  ItemModelImplementationTest.swift
//  MeliChallengeTests
//
//  Created by Martin Victory on 12/05/2020.
//  Copyright © 2020 Martin Victory. All rights reserved.
//

import XCTest
@testable import MeliChallenge

class ItemModelImplementationTest: XCTestCase {

    var model: ItemModelImplementation!
    var networkManager: MockNetworkManager!
    let itemId = "id1"
    
    override func setUpWithError() throws {
        networkManager = MockNetworkManager()
        model = ItemModelImplementation(itemId: itemId, networkManager: networkManager)
    }
    
    override func tearDownWithError() throws {
        networkManager = nil
        model = nil
    }
    
    func testItemFail() {
        networkManager.itemSuccess = false
        
        let promise = expectation(description: "completition handler")
        var success = false
        var done = false
        
        // model should return .failure(api error)
        model.item({ response in
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
    
    func testItemImgFail() {
        networkManager.imageSuccess = false
        
        let promise = expectation(description: "completition handler")
        var success = false
        var done = false
        var apiItem: APIItem?
        
        // model should return .success(but without image)
        model.item({ response in
            switch response {
            case .failure(_):
                success = false
            case .success(let item):
                success = true
                apiItem = item
            }
            done = true
            promise.fulfill()
        })
        
        wait(for: [promise], timeout: 5)
        XCTAssertTrue(done)
        XCTAssertTrue(success, "Result .success")
        XCTAssertNotNil(apiItem)
        
        if let apiItem = apiItem {
            XCTAssertEqual(apiItem.id, networkManager.apiItem.id, "Id should match")
            XCTAssertNil(apiItem.pictureData, "picture data should be nil")
            XCTAssertNotNil(apiItem.description, "description shouldn't be nil")
        } else {
            XCTAssertTrue(false)
        }
    }
    
    func testItemDescriptionFail() {
        networkManager.descriptionSuccess = false
        
        let promise = expectation(description: "completition handler")
        var success = false
        var done = false
        var apiItem: APIItem?
        
        // model should return .success(but without image)
        model.item({ response in
            switch response {
            case .failure(_):
                success = false
            case .success(let item):
                success = true
                apiItem = item
            }
            done = true
            promise.fulfill()
        })
        
        wait(for: [promise], timeout: 5)
        XCTAssertTrue(done)
        XCTAssertTrue(success, "Result .success")
        XCTAssertNotNil(apiItem)
        
        if let apiItem = apiItem {
            XCTAssertEqual(apiItem.id, networkManager.apiItem.id, "Id should match")
            XCTAssertNotNil(apiItem.pictureData, "picture data shouldn't be nil")
            XCTAssertNil(apiItem.description, "description should be nil")
        } else {
            XCTAssertTrue(false)
        }
    }
    
    func testResultsSuccess() {
        let promise = expectation(description: "completition handler")
        var success = false
        var done = false
        var apiItem: APIItem?
        
        // model should return .success(but without image)
        model.item({ response in
            switch response {
            case .failure(_):
                success = false
            case .success(let item):
                success = true
                apiItem = item
            }
            done = true
            promise.fulfill()
        })
        
        wait(for: [promise], timeout: 5)
        XCTAssertTrue(done)
        XCTAssertTrue(success, "Result .success")
        XCTAssertNotNil(apiItem)
        
        if let apiItem = apiItem {
            XCTAssertEqual(apiItem.id, networkManager.apiItem.id, "Id should match")
            XCTAssertNotNil(apiItem.pictureData, "picture data shouldn't be nil")
            XCTAssertNotNil(apiItem.description, "description shouldn't be nil")
        } else {
            XCTAssertTrue(false)
        }
    }
}
