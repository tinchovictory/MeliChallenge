//
//  ResultsListImplementation.swift
//  MeliChallenge
//
//  Created by Martin Victory on 09/05/2020.
//  Copyright © 2020 Martin Victory. All rights reserved.
//

import Foundation

class ResultsListImplementation: ResultsList {
    private var items: [ResultItem]
    private var searchWord: String
   
    // Initialize with the search key word and inject API Service
    init(searchWord: String) {
        self.searchWord = searchWord
        items = [ResultItem]()
    }
    
    func results(_ completitionHandler: @escaping ([ResultItem]) -> Void) {
        // go load items from the api
        loadItems(q: searchWord)
        completitionHandler(self.items)
    }
    
    private func loadItems(q: String) {
        items.append(ResultItemImplementation(id: "1", title: "Result1", price: 1000, thumbnail: "url"))
        items.append(ResultItemImplementation(id: "2", title: "Result2", price: 2000, thumbnail: "url"))
        items.append(ResultItemImplementation(id: "3", title: "Result3", price: 3000, thumbnail: "url"))
        items.append(ResultItemImplementation(id: "4", title: "Result4", price: 4000, thumbnail: "url"))
        items.append(ResultItemImplementation(id: "5", title: "Result5", price: 5000, thumbnail: "url"))
        items.append(ResultItemImplementation(id: "6", title: "Result6", price: 6000, thumbnail: "url"))
        items.append(ResultItemImplementation(id: "7", title: "Result7", price: 7000, thumbnail: "url"))
        items.append(ResultItemImplementation(id: "8", title: "Result8", price: 8000, thumbnail: "url"))
        items.append(ResultItemImplementation(id: "9", title: "Result9", price: 9000, thumbnail: "url"))
    }
}
