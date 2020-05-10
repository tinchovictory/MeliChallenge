//
//  ItemCoordinator.swift
//  MeliChallenge
//
//  Created by Martin Victory on 09/05/2020.
//  Copyright © 2020 Martin Victory. All rights reserved.
//

import UIKit
import os.log

protocol ItemCoordinatorDelegate: class {
    func itemCoordinatorDidFinish(itemCoordinator: ItemCoordinator)
}

class ItemCoordinator: Coordinator {
    
    private let router: Router
    private let itemId: String
    weak var delegate: ItemCoordinatorDelegate?

    init(router: Router, itemId: String) {
        self.router = router
        self.itemId = itemId
    }
    
    func start() {
        let itemVC = ItemVC()
        let model = ItemModelImplementation(itemId: self.itemId)
        
        let viewModel = ItemVMImplementation()
        viewModel.coordinatorDelegate = self
        viewModel.model = model
        
        itemVC.viewModel = viewModel
        
        self.router.push(itemVC, isAnimated: true, withCoordinator: self)
        os_log("ItemCoordinator: start()", log: OSLog.navigation, type: .debug)
    }
    
    func dismiss() {
        // inform parent this coordinator is leaving
        self.delegate?.itemCoordinatorDidFinish(itemCoordinator: self)
        os_log("ItemCoordinator: dismiss()", log: OSLog.navigation, type: .debug)
    }
}

extension ItemCoordinator: ItemVMCoordinatorDelegate {
    func itemDidFinish(viewModel: ItemVM) {
        os_log("ItemCoordinator: itemDidFinish()", log: OSLog.navigation, type: .debug)
        router.pop(isAnimated: true)
    }
}
