//
//  SearchVM.swift
//  MeliChallenge
//
//  Created by Martin Victory on 09/05/2020.
//  Copyright © 2020 Martin Victory. All rights reserved.
//

import Foundation

protocol SearchVMCoordinatorDelegate: class {
    func searchVMDidFinish(viewModel: SearchVM)
}

protocol SearchVM: class {
    // keep track of the coorinator in order to end the current screen
    var coordinatorDelegate: SearchVMCoordinatorDelegate? { get set }
   
    // search field word
    var search: String { get set }

    func submit()
}
