//
//  ResultsVMImplementationTest.swift
//  MeliChallengeTests
//
//  Created by Martin Victory on 12/05/2020.
//  Copyright © 2020 Martin Victory. All rights reserved.
//

import XCTest
@testable import MeliChallenge

class ResultsVMImplementationTest: XCTestCase {
    
    var viewModel: ResultsVMImplementation!

    override func setUpWithError() throws {
        viewModel = ResultsVMImplementation()
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }
    
    func testDefault() {
        XCTAssertEqual(viewModel.numberOfItems, 0)
        XCTAssertNil(viewModel.model)
        XCTAssertNil(viewModel.viewDelegate)
        XCTAssertNil(viewModel.coordinatorDelegate)
    }

    func testSetModel() {
        viewModel.model = MockResultsList()

        // view model should convert the api results to the basic model
        XCTAssertEqual(viewModel.numberOfItems, 5)
    }

    func testSetModelFail() {
        let viewDelegate = ResultsVMViewDelegateSpy()
        viewModel.model = MockResultsListFail()
        viewModel.viewDelegate = viewDelegate
        
        // view model should inform view the error
        XCTAssertEqual(viewModel.numberOfItems, 0)
        XCTAssertTrue(viewDelegate.didError)
        XCTAssertTrue(viewDelegate.viewModel === viewModel)
    }
    
    func testModelUpdate() {
        let viewDelegate = ResultsVMViewDelegateSpy()
        viewModel.model = MockResultsList()
        viewModel.viewDelegate = viewDelegate
        
        // view model should inform the view of the model change
        XCTAssertTrue(viewDelegate.didUpdate)
        XCTAssertTrue(viewDelegate.viewModel === viewModel)
    }
    
    func testItemAt() {
        let model = MockResultsList()
        viewModel.model = model
        
        XCTAssertNil(viewModel.itemAt(index: -1), "Invalid index should return nil")
        XCTAssertNil(viewModel.itemAt(index: 5), "Invalid index should return nil")
        XCTAssertEqual(viewModel.itemAt(index: 2)?.id, model.results[2].id, "Item id doesn't match")
    }
    
    func testSelectItemAt() {
        let model = MockResultsList()
        let coordinatorDelegate = ResultsVMCoordinatorDelegateSpy()
        viewModel.model = model
        viewModel.coordinatorDelegate = coordinatorDelegate
        
        viewModel.selectItemAt(index: 2)

        // view model should inform coordinator on item select
        XCTAssertTrue(coordinatorDelegate.didSelectItem)
        XCTAssertTrue(coordinatorDelegate.viewModel === viewModel)
        XCTAssertEqual(coordinatorDelegate.item?.id, model.results[2].id)
    }
}

class MockResultsList: ResultsList {
    let results = [
        APISearchResult(id: "1", title: "Title1", price: 1, thumbnail: "url1", thumbnailData: nil),
        APISearchResult(id: "2", title: "Title2", price: 2, thumbnail: "url2", thumbnailData: nil),
        APISearchResult(id: "3", title: "Title3", price: 3, thumbnail: "url3", thumbnailData: nil),
        APISearchResult(id: "4", title: "Title4", price: 4, thumbnail: "url4", thumbnailData: nil),
        APISearchResult(id: "5", title: "Title5", price: 5, thumbnail: "url5", thumbnailData: nil),
    ]
    
    func results(_ completitionHandler: @escaping (Result<[APISearchResult], APIError>) -> Void) {
        completitionHandler(.success(results))
    }
    
}

class MockResultsListFail: ResultsList {
    func results(_ completitionHandler: @escaping (Result<[APISearchResult], APIError>) -> Void) {
        completitionHandler(.failure(APIError.defaultError))
    }
}

class ResultsVMViewDelegateSpy: ResultsVMViewDelegate {
    private(set) var didUpdate = false
    private(set) var didError = false
    private(set) var viewModel: ResultsVM?
    
    func resultsDidUpdate(viewModel: ResultsVM) {
        didUpdate = true
        self.viewModel = viewModel
    }
    
    func restulsDidError(viewModel: ResultsVM) {
        didError = true
        self.viewModel = viewModel
    }
}

class ResultsVMCoordinatorDelegateSpy: ResultsVMCoordinatorDelegate {
    private(set) var didSelectItem = false
    private(set) var didStopSearching = false
    private(set) var viewModel: ResultsVM?
    private(set) var item: ResultItem?
    
    func resultsDidSelectItem(viewModel: ResultsVM, item: ResultItem) {
        didSelectItem = true
        self.viewModel = viewModel
        self.item = item
    }
    
    func resultsStopSearching(viewModel: ResultsVM) {
        didStopSearching = true
        self.viewModel = viewModel
    }
}
