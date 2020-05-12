//
//  ItemVMImplementation.swift
//  MeliChallenge
//
//  Created by Martin Victory on 09/05/2020.
//  Copyright © 2020 Martin Victory. All rights reserved.
//

import Foundation
import os.log

fileprivate enum ModelStatus {
    case loading, done, error
}

class ItemVMImplementation: ItemVM {
    weak var viewDelegate: ItemVMViewDelegate? {
        didSet {
            if modelStatus == .done, let item = item {
                viewDelegate?.itemDidUpdate(viewModel: self, item: item)
            }
            if modelStatus == .error {
                viewDelegate?.loadDidFail(viewModel: self)
            }
        }
    }
    weak var coordinatorDelegate: ItemVMCoordinatorDelegate?

    private var modelStatus: ModelStatus = .loading
   
    // load item on model initialization
    var model: ItemModel? {
        didSet {
            model?.item { [weak self] response in
                guard let self = self else { return }
                
                switch response {
                case .failure:
                    self.modelStatus = .error
                    self.viewDelegate?.loadDidFail(viewModel: self)
                    os_log("ItemVMImplementation: model: api error", log: OSLog.buisnessLogic, type: .debug)
                case .success(let apiItem):
                    self.modelStatus = .done
                    self.item = ItemImplementation(apiItem: apiItem)
                }
            }
        }
    }
    
    var item: Item? {
        didSet {
            if let item = item {
                viewDelegate?.itemDidUpdate(viewModel: self, item: item)
            }
        }
    }
}
