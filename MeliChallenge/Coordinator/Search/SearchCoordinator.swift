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
    weak var delegate: SearchCoordinatorDelegate?
    
    init(router: Router) {
        self.router = router
    }
    
    func start() {
        let viewModel = SearchVMImplementation()
        viewModel.coordinatorDelegate = self

        let searchViewController = SearchViewController()
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
        resultsCoordinator.start()
    }
}

extension SearchCoordinator: ResultsCoordinatorDelegate {
    func resultsCoordinatorDidFinish(resultsCoordinator: ResultsCoordinator) {
        // nothing to be done when the child coordinator ends
        // TODO: clear searchbar
    }
}
