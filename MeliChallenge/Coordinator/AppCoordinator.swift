//
//  AppCoordinator.swift
//  MeliChallenge
//
//  Created by Martin Victory on 09/05/2020.
//  Copyright © 2020 Martin Victory. All rights reserved.
//

import UIKit
import os.log

class AppCoordinator: Coordinator {
    
    private let window: UIWindow
    private let router: Router

    init(window: UIWindow) {
        self.window = window
        let navigationController = UINavigationController()
        self.router = RouterImplementation(navigationController: navigationController)
        self.window.rootViewController = navigationController
    }
    
    func start() {
        os_log("AppCoordinator: start()", log: OSLog.navigation, type: .debug)
//        showSearch()
        ResultsCoordinator(router: router, searchWord: "Motorola").start()
    }

    func dismiss() {
        os_log("AppCoordinator: dismiss(): App coordinator shouldn't be dissmised", log: OSLog.navigation, type: .error)
        fatalError("Initial coordinator can't be dismised")
    }
}

extension AppCoordinator: SearchCoordinatorDelegate {
    private func showSearch() {
        let searchCoordinator = SearchCoordinator(router: self.router)
        searchCoordinator.delegate = self
        searchCoordinator.start()
    }
    
    func searchCoordinatorDidFinish(searchCoordinator: SearchCoordinator) {
        // nothing to be done when child coordinator ends
    }
    
}
