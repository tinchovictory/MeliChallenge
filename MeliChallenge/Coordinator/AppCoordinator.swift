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
    private let navigationController: UINavigationController
    
    private var childCoordinator: Coordinator?
    
    init(window: UIWindow) {
        self.window = window
        self.navigationController = UINavigationController()
        self.window.rootViewController = self.navigationController
    }
    
    func start() {
        showSearch()
    }

}

extension AppCoordinator: SearchCoordinatorDelegate {
    private func showSearch() {
        let searchCoordinator = SearchCoordinator(navigationController: self.navigationController)
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
