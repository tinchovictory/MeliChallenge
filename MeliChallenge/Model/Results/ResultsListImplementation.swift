//
//  ResultsListImplementation.swift
//  MeliChallenge
//
//  Created by Martin Victory on 09/05/2020.
//  Copyright © 2020 Martin Victory. All rights reserved.
//

import Foundation
import os.log

class ResultsListImplementation: ResultsList {
    private var items: [APISearchResult]
    private let searchWord: String
    private let networkManager: NetworkManager
   
    // Initialize with the search key word and inject API Service
    init(searchWord: String, networkManager: NetworkManager) {
        self.searchWord = searchWord
        self.networkManager = networkManager
        items = [APISearchResult]()
    }
    
    func results(_ completitionHandler: @escaping (Result<[APISearchResult], APIError>) -> Void) {
        DispatchQueue.global(qos: .utility).async { [weak self] in
            guard let self = self else {
                completitionHandler(.failure(APIError.defaultError))
                return
            }

            // items response
            self.networkManager.getSearchResults(q: self.searchWord) { response in
                os_log("ResultsListImplementation: results(): Network manager finished get serarch results", log: OSLog.network, type: .debug)

                switch response {
                case .failure(let err):
                    DispatchQueue.main.async {
                        completitionHandler(.failure(err))
                    }
                case .success(let apiSearchResults):
                    DispatchQueue.main.async {
                        // save the items
                        self.items = apiSearchResults
                        completitionHandler(.success(self.items))
                    }
                }
            }
        }
    }
}
