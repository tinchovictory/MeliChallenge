//
//  SearchVMImplementationTest.swift
//  MeliChallengeTests
//
//  Created by Martin Victory on 12/05/2020.
//  Copyright © 2020 Martin Victory. All rights reserved.
//

import XCTest
@testable import MeliChallenge

class SearchVMImplementationTest: XCTestCase {
    
    var viewModel: SearchVMImplementation!

    override func setUpWithError() throws {
        viewModel = SearchVMImplementation()
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }

    func testSubmit() {
        let delegate = SearchVMCoordinatorDelegateSpy()
        viewModel.coordinatorDelegate = delegate
        
        viewModel.submit()
        
        // check if the delegate was called
        XCTAssertTrue(delegate.didFinish, "Delegate method should be called on submit")
        XCTAssertTrue(delegate.didFinishVM === viewModel, "Delegate method should be called with self parameter")
    }
}

class SearchVMCoordinatorDelegateSpy: SearchVMCoordinatorDelegate {
    private(set) var didFinish = false
    private(set) var didFinishVM: SearchVM?
    
    func searchVMDidFinish(viewModel: SearchVM) {
        didFinish = true
        didFinishVM = viewModel
    }
}
