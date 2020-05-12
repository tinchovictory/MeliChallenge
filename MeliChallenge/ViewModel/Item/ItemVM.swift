//
//  ItemVM.swift
//  MeliChallenge
//
//  Created by Martin Victory on 09/05/2020.
//  Copyright © 2020 Martin Victory. All rights reserved.
//

import Foundation

protocol ItemVMViewDelegate: class {
    func itemDidUpdate(viewModel: ItemVM, item: Item)
    func loadDidFail(viewModel: ItemVM) // add error type
}

protocol ItemVMCoordinatorDelegate: class {
    func itemDidFinish(viewModel: ItemVM)
}

protocol ItemVM: class {
    // vc double binding
    var viewDelegate: ItemVMViewDelegate? { get set }
    
    // keep track of the coorinator in order to end the current screen
    var coordinatorDelegate: ItemVMCoordinatorDelegate? { get set }
    
    var model: ItemModel? { get set }
    
    var item: Item? { get }
}
