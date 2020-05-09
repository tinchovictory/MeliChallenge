//
//  SearchCoordinator.swift
//  MeliChallenge
//
//  Created by Martin Victory on 09/05/2020.
//  Copyright © 2020 Martin Victory. All rights reserved.
//

import UIKit

protocol SearchCoordinatorDelegate: class {
    func searchCoordinatorDidFinish(searchCoordinator: SearchCoordinator)
}

class SearchCoordinator: Coordinator {
    
    private let navigationController: UINavigationController
    weak var delegate: SearchCoordinatorDelegate?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let searchViewController = SearchViewController()
        self.navigationController.pushViewController(searchViewController, animated: false)
    }
}
