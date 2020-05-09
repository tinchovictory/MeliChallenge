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
    
//    private var coordinators: [Coordinator]
    private var childCoordinator: Coordinator?
    
    init(window: UIWindow) {
        self.window = window
        self.navigationController = UINavigationController()
        self.window.rootViewController = self.navigationController
        
//        self.coordinators = [Coordinator]()
    }
    
    func start() {
        showSearch()
    }

}

extension AppCoordinator: SearchCoordinatorDelegate {
    private func showSearch() {
        let searchCoordinator = SearchCoordinator(navigationController: self.navigationController)
        searchCoordinator.delegate = self
        
        self.childCoordinator = searchCoordinator
        
        searchCoordinator.start()
    }
    
    func searchCoordinatorDidFinish(searchCoordinator: SearchCoordinator) {
        self.childCoordinator = nil
    }
    
}
