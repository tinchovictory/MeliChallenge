//
//  ItemCoordinator.swift
//  MeliChallenge
//
//  Created by Martin Victory on 09/05/2020.
//  Copyright © 2020 Martin Victory. All rights reserved.
//

import UIKit

protocol ItemCoordinatorDelegate: class {
    func itemCoordinatorDidFinish(itemCoordinator: ItemCoordinator)
}

class ItemCoordinator: Coordinator {
    
    private let navigationController: UINavigationController
    private let itemId: String
    weak var delegate: ItemCoordinatorDelegate?

    init(navigationController: UINavigationController, itemId: String) {
        self.navigationController = navigationController
        self.itemId = itemId
    }
    
    func start() {
        let itemVC = ItemVC()
        let model = ItemModelImplementation(itemId: self.itemId)
        
        let viewModel = ItemVMImplementation()
        viewModel.coordinatorDelegate = self
        viewModel.model = model
        
        itemVC.viewModel = viewModel
        
        self.navigationController.pushViewController(itemVC, animated: true)
    }
}

extension ItemCoordinator: ItemVMCoordinatorDelegate {
    func itemDidFinish(viewModel: ItemVM) {
        self.delegate?.itemCoordinatorDidFinish(itemCoordinator: self)
    }
}
