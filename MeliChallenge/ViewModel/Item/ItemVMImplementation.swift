//
//  ItemVMImplementation.swift
//  MeliChallenge
//
//  Created by Martin Victory on 09/05/2020.
//  Copyright © 2020 Martin Victory. All rights reserved.
//

import Foundation
import os.log

class ItemVMImplementation: ItemVM {
    weak var viewDelegate: ItemVMViewDelegate?
    weak var coordinatorDelegate: ItemVMCoordinatorDelegate?
   
    // load item on model initialization
    var model: ItemModel? {
        didSet {
            model?.item { [weak self] response in
                guard let self = self else { return }
                
                switch response {
                case .failure:
                    self.viewDelegate?.loadDidFail(viewModel: self)
                    os_log("ItemVMImplementation: model: api error", log: OSLog.buisnessLogic, type: .debug)
                case .success(let apiItem):
                    self.item = ItemImplementation(apiItem: apiItem)
                }
            }
        }
    }
    
    var item: Item? {
        didSet {
            viewDelegate?.itemDidUpdate(viewModel: self)
        }
    }
}
