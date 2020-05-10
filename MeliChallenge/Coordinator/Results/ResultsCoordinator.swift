//
//  ResultsCoordinator.swift
//  MeliChallenge
//
//  Created by Martin Victory on 09/05/2020.
//  Copyright © 2020 Martin Victory. All rights reserved.
//

import UIKit

protocol ResultsCoordinatorDelegate: class {
    func resultsCoordinatorDidFinish(resultsCoordinator: ResultsCoordinator)
}

class ResultsCoordinator: Coordinator {
    
    private let navigationController: UINavigationController
    private let searchWord: String
    weak var delegate: ResultsCoordinatorDelegate?
    
    init(navigationController: UINavigationController, searchWord: String) {
        self.navigationController = navigationController
        self.searchWord = searchWord
    }
    
    func start() {
        let resultsVC = ResultsVC()
        
        let model = ResultsListImplementation(searchWord: self.searchWord)
        
        let viewModel = ResultsVMImplementation()
        viewModel.coordinatorDelegate = self
        viewModel.model = model

        resultsVC.viewModel = viewModel
        
        self.navigationController.pushViewController(resultsVC, animated: true)
    }
}

extension ResultsCoordinator: ResultsVMCoordinatorDelegate {
    func resultsDidSelectItem(viewModel: ResultsVM, item: ResultItem) {
        // move to item screen
    }
    
    func resultsStopSearching(viewModel: ResultsVM) {
        // go back to the previous screen
        delegate?.resultsCoordinatorDidFinish(resultsCoordinator: self)
    }

}
