//
//  ResultsVM.swift
//  MeliChallenge
//
//  Created by Martin Victory on 09/05/2020.
//  Copyright © 2020 Martin Victory. All rights reserved.
//

import Foundation

protocol ResultsVMViewDelegate: class {
    func resultsDidUpdate(viewModel: ResultsVM)
}

protocol ResultsVMCoordinatorDelegate: class {
    func resultsDidSelectItem(viewModel: ResultsVM, item: ResultItem)
    func resultsStopSearching(viewModel: ResultsVM)
}

protocol ResultsVM: class {
    // vc double binding
    var viewDelegate: ResultsVMViewDelegate? { get set }
    
    // keep track of the coorinator in order to end the current screen
    var coordinatorDelegate: ResultsVMCoordinatorDelegate? { get set }
    
    var model: ResultsList? { get set }
   
    // list
    var numberOfItems: Int { get }
    func itemAt(index: Int) -> ResultItem?
    func selectItemAt(index: Int)
}
