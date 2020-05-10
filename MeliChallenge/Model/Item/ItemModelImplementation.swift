//
//  ItemModelImplementation.swift
//  MeliChallenge
//
//  Created by Martin Victory on 09/05/2020.
//  Copyright © 2020 Martin Victory. All rights reserved.
//

import Foundation

class ItemModelImplementation: ItemModel {
    private var item: Item?
    private var itemId: String

    init(itemId: String) {
        self.itemId = itemId
    }
    
    func item(_ completitionHandler: @escaping (Item) -> Void) {
        // go look item from the api
        loadItem(itemId)
        if let item = item {
            completitionHandler(item)
        }
        // otherwise send error
    }
    
    private func loadItem(_ id: String) {
        item = ItemImplementation(id: "1", title: "Result 1", price: 1000, condition: "new", quantity: 10, picture: "url", description: "description")
    }
}
