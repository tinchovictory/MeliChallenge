//
//  RouterImplementation.swift
//  MeliChallenge
//
//  Created by Martin Victory on 09/05/2020.
//  Copyright © 2020 Martin Victory. All rights reserved.
//

import UIKit
import os.log

class RouterImplementation: NSObject, Router {
    let navigationController: UINavigationController
    private var coordinators: [Coordinator]
    var childCoordinators: Int { coordinators.count }

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.coordinators = []
        super.init()
        self.navigationController.delegate = self
    }

    func push(_ vc: UIViewController, isAnimated: Bool, withCoordinator coordinator: Coordinator) {
        navigationController.pushViewController(vc, animated: isAnimated)
        coordinators.append(coordinator)
    }

    func pop(isAnimated: Bool) {
        if childCoordinators == 1 {
            fatalError("The root view controller can't be removed")
        }
        
        navigationController.popViewController(animated: isAnimated)
        if let lastCoordinator = coordinators.last {
            lastCoordinator.dismiss()
            coordinators.removeLast()
        }
        os_log("Router: pop(): manual coordinator dismiss", log: OSLog.navigation, type: .debug)
    }
}

extension RouterImplementation: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let fromVC = navigationController.transitionCoordinator?.viewController(forKey: .from) else {
            return
        }

        // if the last vc is still in the navigation controller stack it means i'm adding a new vc
        if navigationController.viewControllers.contains(fromVC) {
            return
        }

        if let lastCoordinator = coordinators.last {
            lastCoordinator.dismiss()
            coordinators.removeLast()
        }
        os_log("Router: navigationController(): automatic coordinator dismiss", log: OSLog.navigation, type: .debug)
    }
}
