//
//  ResultsCoordinatorTest.swift
//  MeliChallengeTests
//
//  Created by Martin Victory on 12/05/2020.
//  Copyright © 2020 Martin Victory. All rights reserved.
//

import XCTest
@testable import MeliChallenge

class ResultsCoordinatorTest: XCTestCase {

    var resultsCoordinator: ResultsCoordinator!
    var mockRouter: MockRouter!
    let searchWord = "SearchWord"
    
    override func setUpWithError() throws {
        mockRouter = MockRouter()
        resultsCoordinator = ResultsCoordinator(router: mockRouter, searchWord: searchWord)
    }

    override func tearDownWithError() throws {
        mockRouter = nil
        resultsCoordinator = nil
    }
    
    func testStart() {
        resultsCoordinator.start()
        
        XCTAssertEqual(mockRouter.childCoordinators, 1, "Coordinator should be added to router")
        XCTAssertEqual(mockRouter.viewControllers.count, 1, "Coordinator should be added to router")
    }
    
    func testDismiss() {
        let delegateSpy = ResultsCoordinatorDelegateSpy()
        resultsCoordinator.delegate = delegateSpy
        
        resultsCoordinator.dismiss()
        
        // check if delegate funciton was called
        XCTAssertTrue(delegateSpy.didFinishCalled)
        XCTAssertTrue(delegateSpy.resultsCoordinator === resultsCoordinator)
    }

    func testResultDidSelectItem() {
        resultsCoordinator.start()
        let mockViewModel = MockResultsVM()
        let mockItem = MockResultItem()

        resultsCoordinator.resultsDidSelectItem(viewModel: mockViewModel, item: mockItem)

        // next coordinator should be pushed
        XCTAssertEqual(mockRouter.childCoordinators, 2)
        XCTAssertEqual(mockRouter.viewControllers.count, 2)
    }
    
    func testResultsStopSearching() {
        resultsCoordinator.start()
        let mockViewModel = MockResultsVM()
        
        resultsCoordinator.resultsStopSearching(viewModel: mockViewModel)

        // coordinator should call router and remove itself
        XCTAssertEqual(mockRouter.childCoordinators, 0)
        XCTAssertEqual(mockRouter.viewControllers.count, 0)
    }
    
    func testItemCoordinatorDidFinish() {
        resultsCoordinator.itemCoordinatorDidFinish(itemCoordinator: ItemCoordinator(router: mockRouter, itemId: "id"))
        // nothing to be tested
        XCTAssertTrue(true)
    }

}

class ResultsCoordinatorDelegateSpy: ResultsCoordinatorDelegate {
    private(set) var didFinishCalled = false
    private(set) var resultsCoordinator: ResultsCoordinator?
    
    func resultsCoordinatorDidFinish(resultsCoordinator: ResultsCoordinator) {
        didFinishCalled = true
        self.resultsCoordinator = resultsCoordinator
    }
}

class MockResultsVM: ResultsVM {
    var viewDelegate: ResultsVMViewDelegate?
    var coordinatorDelegate: ResultsVMCoordinatorDelegate?
    var model: ResultsList?
    var numberOfItems: Int { return 1 }
    
    func itemAt(index: Int) -> ResultItem? {
        return MockResultItem()
    }
    
    func selectItemAt(index: Int) {
        // nothing to be done
    }
}

class MockResultItem: ResultItem {
    var id: String = "id1"
    var title: String = "title1"
    var price: Float = 1
    var thumbnail: UIImage?
}
