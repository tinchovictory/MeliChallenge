//
//  ItemCoordinatorTest.swift
//  MeliChallengeTests
//
//  Created by Martin Victory on 12/05/2020.
//  Copyright © 2020 Martin Victory. All rights reserved.
//

import XCTest
@testable import MeliChallenge

class ItemCoordinatorTest: XCTestCase {

    var itemCoordinator: ItemCoordinator!
    var mockRouter: MockRouter!
    let itemId = "id1"
    
    override func setUpWithError() throws {
        mockRouter = MockRouter()
        itemCoordinator = ItemCoordinator(router: mockRouter, itemId: itemId)
    }

    override func tearDownWithError() throws {
        mockRouter = nil
        itemCoordinator = nil
    }

    func testStart() {
        itemCoordinator.start()
        
        XCTAssertEqual(mockRouter.childCoordinators, 1, "Coordinator should be added to router")
        XCTAssertEqual(mockRouter.viewControllers.count, 1, "Coordinator should be added to router")
    }
    
    func testDismiss() {
        let delegateSpy = ItemCoordinatorDelegateSpy()
        itemCoordinator.delegate = delegateSpy
        
        itemCoordinator.dismiss()
        
        // check if delegate funciton was called
        XCTAssertTrue(delegateSpy.didFinishCalled, "Delegate didFinish should be called")
        XCTAssertTrue(delegateSpy.itemCoordinator === itemCoordinator, "Delegate didFinish should be called with coordinator as parameter")
    }

    func testItemDidFinish() {
        itemCoordinator.start()
        let mockViewModel = MockItemVM()

        itemCoordinator.itemDidFinish(viewModel: mockViewModel)

        // coordinator should call router and remove itself
        XCTAssertEqual(mockRouter.childCoordinators, 0, "Coordinator should be removed from router")
        XCTAssertEqual(mockRouter.viewControllers.count, 0, "View controller should be removed from router")
    }
}

class ItemCoordinatorDelegateSpy: ItemCoordinatorDelegate {
    private(set) var didFinishCalled = false
    private(set) var itemCoordinator: ItemCoordinator?

    func itemCoordinatorDidFinish(itemCoordinator: ItemCoordinator) {
        didFinishCalled = true
        self.itemCoordinator = itemCoordinator
    }
}

class MockItemVM: ItemVM {
    var viewDelegate: ItemVMViewDelegate?
    var coordinatorDelegate: ItemVMCoordinatorDelegate?
    var model: ItemModel?
    var item: Item?
}
