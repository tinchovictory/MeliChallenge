//
//  SearchCoordinator.swift
//  MeliChallenge
//
//  Created by Martin Victory on 09/05/2020.
//  Copyright © 2020 Martin Victory. All rights reserved.
//

import UIKit
import os.log

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

        let searchViewController = SearchVC(viewModel: viewModel)

        router.push(searchViewController, isAnimated: false, withCoordinator: self)
        os_log("SearchCoordinator: start()", log: OSLog.navigation, type: .debug)
    }
    
    func dismiss() {
        // search screen shouldnt be dissmised
        os_log("SearchCoordinator: dismiss(): Search coordinator shouldn't be dismiss", log: OSLog.navigation, type: .error)
    }
}

extension SearchCoordinator: SearchVMCoordinatorDelegate {
    func searchVMDidFinish(viewModel: SearchVM) {
        // I have the search word go to display the results
        os_log("SearchCoordinator: searchVMDidFinish(): move to results screen, search=%{PUBLIC}@", log: OSLog.navigation, type: .debug, viewModel.search)
        
        let resultsCoordinator = ResultsCoordinator(router: self.router, searchWord: viewModel.search)
        resultsCoordinator.delegate = self
        resultsCoordinator.start()
    }
}

extension SearchCoordinator: ResultsCoordinatorDelegate {
    func resultsCoordinatorDidFinish(resultsCoordinator: ResultsCoordinator) {
        // nothing to be done when the child coordinator ends
    }
}
