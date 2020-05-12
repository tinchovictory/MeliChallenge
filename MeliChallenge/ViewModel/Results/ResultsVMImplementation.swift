//
//  ResultsVMImplementation.swift
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

class ResultsVMImplementation: ResultsVM {
    weak var viewDelegate: ResultsVMViewDelegate? {
        didSet {
            if modelStatus == .done {
                self.viewDelegate?.resultsDidUpdate(viewModel: self)
            }
            if modelStatus == .error {
                self.viewDelegate?.restulsDidError(viewModel: self)
            }
        }
    }
    weak var coordinatorDelegate: ResultsVMCoordinatorDelegate?
    
    private var modelStatus: ModelStatus = .loading

    // load the results on model initialization and save them on the items array
    var model: ResultsList? {
        didSet {
            model?.results { [weak self] response in
                guard let self = self else { return }
                
                switch response {
                case .failure:
                    self.modelStatus = .error
                    self.viewDelegate?.restulsDidError(viewModel: self)
                    os_log("ResultsVMImplementation: model: api error", log: OSLog.buisnessLogic, type: .debug)
                case .success(let apiSearchResults):
                    self.modelStatus = .done
                    self.items = apiSearchResults.map { ResultItemImplementation(apiSearchResult: $0) }
                }
            }
        }
    }
    
    // internal items state, updating the view on change
    private var items: [ResultItem]? {
        didSet {
            viewDelegate?.resultsDidUpdate(viewModel: self)
        }
    }
    
    var numberOfItems: Int { items?.count ?? 0 }
    
    func itemAt(index: Int) -> ResultItem? {
        if let items = items, index >= 0 && index < items.count {
            return items[index]
        }
        return nil
    }
    
    func selectItemAt(index: Int) {
        os_log("ResultsVMImplementation: selectItemAt(): index=%{PUBLIC}@", log: OSLog.buisnessLogic, type: .debug, String(index))
        if let item = itemAt(index: index) {
            coordinatorDelegate?.resultsDidSelectItem(viewModel: self, item: item)
        }
    }

}
