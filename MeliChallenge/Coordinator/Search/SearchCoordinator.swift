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
    
    private let router: Router
    private var childCoordinator: Coordinator?
    weak var delegate: SearchCoordinatorDelegate?
    
    init(router: Router) {
        self.router = router
    }
    
    func start() {
        let searchViewController = SearchViewController()
        let viewModel = SearchVMImplementation()
        viewModel.coordinatorDelegate = self

        searchViewController.viewModel = viewModel
        
        router.push(searchViewController, isAnimated: false, withCoordinator: self)
    }
    
    func dismiss() {
        // search screen shouldnt be dissmised
    }
}

extension SearchCoordinator: SearchVMCoordinatorDelegate {
    func searchVMDidFinish(viewModel: SearchVM) {
        // I have the search word go to display the results
        print("go to results with word \(viewModel.search)")
        
        let resultsCoordinator = ResultsCoordinator(router: self.router, searchWord: viewModel.search)
        resultsCoordinator.delegate = self
        self.childCoordinator = resultsCoordinator
        
        resultsCoordinator.start()
    }
}

extension SearchCoordinator: ResultsCoordinatorDelegate {
    func resultsCoordinatorDidFinish(resultsCoordinator: ResultsCoordinator) {
        self.childCoordinator = nil
    }
}
