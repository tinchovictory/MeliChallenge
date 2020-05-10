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
    
    private let router: Router
    private let searchWord: String
    private var childCoordinator: Coordinator?
    weak var delegate: ResultsCoordinatorDelegate?
    
    init(router: Router, searchWord: String) {
        self.router = router
        self.searchWord = searchWord
    }
    
    func start() {
        let resultsVC = ResultsVC()
        
        let model = ResultsListImplementation(searchWord: self.searchWord)
        
        let viewModel = ResultsVMImplementation()
        viewModel.coordinatorDelegate = self
        viewModel.model = model

        resultsVC.viewModel = viewModel
        
        self.router.push(resultsVC, isAnimated: true, withCoordinator: self)
    }
   
    func dismiss() {
        // inform parent this coordinator is leaving
        delegate?.resultsCoordinatorDidFinish(resultsCoordinator: self)
    }
}

extension ResultsCoordinator: ResultsVMCoordinatorDelegate {
    func resultsDidSelectItem(viewModel: ResultsVM, item: ResultItem) {
        // move to item screen
        print("item \(item.id) selected, moving to item screen")
        
        let itemCoordinator = ItemCoordinator(router: self.router, itemId: item.id)
        itemCoordinator.delegate = self
        self.childCoordinator = itemCoordinator

        itemCoordinator.start()
    }
    
    func resultsStopSearching(viewModel: ResultsVM) {
        // go back to the previous screen
        router.pop(isAnimated: true)
    }
}

extension ResultsCoordinator: ItemCoordinatorDelegate {
    func itemCoordinatorDidFinish(itemCoordinator: ItemCoordinator) {
        self.childCoordinator = nil
    }
}
