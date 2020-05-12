//
//  MockRouter.swift
//  MeliChallengeTests
//
//  Created by Martin Victory on 12/05/2020.
//  Copyright © 2020 Martin Victory. All rights reserved.
//

import Foundation
import UIKit
@testable import MeliChallenge

class MockRouter: Router {
    private(set) var coordinators = [Coordinator]()
    private(set) var viewControllers = [UIViewController]()
    
    var childCoordinators: Int { coordinators.count }
    
    func push(_ vc: UIViewController, isAnimated: Bool, withCoordinator coordinator: Coordinator) {
        viewControllers.append(vc)
        coordinators.append(coordinator)
    }
    
    func pop(isAnimated: Bool) {
        viewControllers.removeLast()
        coordinators.removeLast()
    }
}
