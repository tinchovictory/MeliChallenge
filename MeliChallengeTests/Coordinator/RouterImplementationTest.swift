//
//  RouterImplementationTest.swift
//  MeliChallengeTests
//
//  Created by Martin Victory on 12/05/2020.
//  Copyright © 2020 Martin Victory. All rights reserved.
//

import XCTest
@testable import MeliChallenge

class RouterImplementationTest: XCTestCase {
    
    var router: RouterImplementation!
    var mockNavigationController: MockNavigationController!
    
    override func setUpWithError() throws {
        mockNavigationController = MockNavigationController()
        router = RouterImplementation(navigationController: mockNavigationController)
    }

    override func tearDownWithError() throws {
        mockNavigationController = nil
        router = nil
    }

    func testInitialState() {
        // navigation controller assigned
        XCTAssertEqual(router.navigationController, mockNavigationController, "Navigation controller should be assigned on init")
        
        // coordinators should be empty
        XCTAssertEqual(router.childCoordinators, 0, "Coordinators should be empty on startup")
    }
    
    func testPush() {
        let mockCoordinator = MockCoordinator()
        let viewController = UIViewController()
        
        router.push(viewController, isAnimated: false, withCoordinator: mockCoordinator)
        
        // should add coordinator to internal array and push the vc to the navigation controller
        XCTAssertEqual(router.childCoordinators, 1, "Coordinator should be added")
        XCTAssertEqual(mockNavigationController.pushedViewController, viewController, "View controller should be pushed to the navigation controller")
    }
    
    func testPopEmpty() {
        router.pop(isAnimated: false)
        XCTAssertEqual(router.childCoordinators, 0)
    }
    
    func testPop() {
        let mockCoordinator1 = MockCoordinator()
        let rootViewController = UIViewController()
        let mockCoordinator2 = MockCoordinator()
        let viewController = UIViewController()
        router.push(rootViewController, isAnimated: false, withCoordinator: mockCoordinator1)
        router.push(viewController, isAnimated: false, withCoordinator: mockCoordinator2)
        
        router.pop(isAnimated: false)
        
        // should remove coordinator and pop from navigation controller
        XCTAssertEqual(router.childCoordinators, 1, "Coordinator should be removed")
        XCTAssertEqual(mockNavigationController.children.count, 1)
        XCTAssertEqual(mockNavigationController.popedViewController, viewController, "View controller should be poped to the navigation controller")
    }
}

class MockNavigationController: UINavigationController {
    private(set) var pushedViewController: UIViewController?
    private(set) var popedViewController: UIViewController?
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        pushedViewController = viewController
        super.pushViewController(viewController, animated: animated)
    }
    
    override func popViewController(animated: Bool) -> UIViewController? {
        popedViewController = super.popViewController(animated: animated)
        return popedViewController
    }
}

class MockCoordinator: Coordinator {
    private(set) var coorindatorStarted = false
    private(set) var coorindatorDismissed = false
    
    func start() {
        coorindatorStarted = true
    }
    
    func dismiss() {
        coorindatorDismissed = true
    }
}
