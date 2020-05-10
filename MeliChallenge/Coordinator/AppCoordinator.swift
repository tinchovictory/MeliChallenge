//
//  AppCoordinator.swift
//  MeliChallenge
//
//  Created by Martin Victory on 09/05/2020.
//  Copyright © 2020 Martin Victory. All rights reserved.
//

import UIKit

class AppCoordinator: Coordinator {
    
    private let window: UIWindow
//    private let navigationController: UINavigationController
    private let router: Router
    
    private var childCoordinator: Coordinator?
    
    init(window: UIWindow) {
        self.window = window
        let navigationController = UINavigationController()
        self.router = RouterImplementation(navigationController: navigationController)
        self.window.rootViewController = navigationController
    }
    
    func start() {
        showSearch()
    }

    func dismiss() {
        fatalError("Initial coordinator can't be dismised")
    }
}

extension AppCoordinator: SearchCoordinatorDelegate {
    private func showSearch() {
        let searchCoordinator = SearchCoordinator(router: self.router)
        searchCoordinator.delegate = self
    
        // keep track of the child coordinator to avoid loosing the pointer
        self.childCoordinator = searchCoordinator
        
        searchCoordinator.start()
    }
    
    func searchCoordinatorDidFinish(searchCoordinator: SearchCoordinator) {
        // this should never be called since it's the initial vc
        // self.childCoordinator = nil
    }
    
}
