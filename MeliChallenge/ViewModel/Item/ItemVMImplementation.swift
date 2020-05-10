//
//  ItemVMImplementation.swift
//  MeliChallenge
//
//  Created by Martin Victory on 09/05/2020.
//  Copyright © 2020 Martin Victory. All rights reserved.
//

import Foundation

class ItemVMImplementation: ItemVM {
    weak var viewDelegate: ItemVMViewDelegate?
    weak var coordinatorDelegate: ItemVMCoordinatorDelegate?
   
    // load item on model initialization
    var model: ItemModel? {
        didSet {
            print("seting item model")
            model?.item { self.item = $0 }
        }
    }
    
    var item: Item? {
        didSet {
            print("item model finished")
            viewDelegate?.itemDidUpdate(viewModel: self)
        }
    }
}
