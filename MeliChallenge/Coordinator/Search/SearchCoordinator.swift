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
    private var childCoordinator: Coordinator?
    weak var delegate: SearchCoordinatorDelegate?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let searchViewController = SearchViewController()
        let viewModel = SearchVMImplementation()
        viewModel.coordinatorDelegate = self

        searchViewController.viewModel = viewModel
        
        self.navigationController.pushViewController(searchViewController, animated: false)
    }
}

extension SearchCoordinator: SearchVMCoordinatorDelegate {
    func searchVMDidFinish(viewModel: SearchVM) {
        // I have the search word go to display the results
        print("go to results with word \(viewModel.search)")
        
        let resultsCoordinator = ResultsCoordinator(navigationController: self.navigationController, searchWord: viewModel.search)
        resultsCoordinator.delegate = self
        self.childCoordinator = resultsCoordinator
        
        resultsCoordinator.start()
    }
}

extension SearchCoordinator: ResultsCoordinatorDelegate {
    func resultsCoordinatorDidFinish(resultsCoordinator: ResultsCoordinator) {
        self.childCoordinator = nil
        self.navigationController.popViewController(animated: true)
    }
}
