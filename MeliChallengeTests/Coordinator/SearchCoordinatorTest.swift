//
//  SearchCoordinatorTest.swift
//  MeliChallengeTests
//
//  Created by Martin Victory on 12/05/2020.
//  Copyright © 2020 Martin Victory. All rights reserved.
//

import XCTest
@testable import MeliChallenge

class SearchCoordinatorTest: XCTestCase {
    
    var searchCoordinator: SearchCoordinator!
    var mockRouter: MockRouter!

    override func setUpWithError() throws {
        mockRouter = MockRouter()
        searchCoordinator = SearchCoordinator(router: mockRouter)
    }

    override func tearDownWithError() throws {
        mockRouter = nil
        searchCoordinator = nil
    }
    
    func testStart() {
        searchCoordinator.start()
        
        XCTAssertEqual(mockRouter.childCoordinators, 1)
        XCTAssertEqual(mockRouter.viewControllers.count, 1)
    }
    
    func testDismiss() {
        searchCoordinator.dismiss()
        // nothing to be tested
        XCTAssertTrue(true)
    }
    
    func testVMDidFinish() {
        searchCoordinator.start()
        let mockViewModel = MockSearchVM()
        
        searchCoordinator.searchVMDidFinish(viewModel: mockViewModel)
        
        // next coordinator should be pushed
        XCTAssertEqual(mockRouter.childCoordinators, 2)
        XCTAssertEqual(mockRouter.viewControllers.count, 2)
    }

    func testResultsCoordinatorDidFinish() {
        searchCoordinator.resultsCoordinatorDidFinish(resultsCoordinator: ResultsCoordinator(router: mockRouter, searchWord: ""))
        // nothing to be tested
        XCTAssertTrue(true)
    }
}

class MockSearchVM: SearchVM {
    var coordinatorDelegate: SearchVMCoordinatorDelegate?
    
    var search: String = ""
    
    func submit() {
        // submit pressed
    }
}
