//
//  ItemImplementation.swift
//  MeliChallenge
//
//  Created by Martin Victory on 09/05/2020.
//  Copyright © 2020 Martin Victory. All rights reserved.
//

import Foundation
import UIKit

struct ItemImplementation: Item {
    let id: String
    let title: String
    let price: Float
    let condition: String
    let quantity: Int
    let picture: UIImage?
    let description: String?
    
    init(apiItem: APIItem) {
        self.id = apiItem.id
        self.title = apiItem.title
        self.price = apiItem.price
        self.condition = apiItem.condition
        self.quantity = apiItem.quantity
        self.description = apiItem.description?.text
        
        if let imageData = apiItem.pictureData {
            self.picture = UIImage(data: imageData)
        } else {
            self.picture = nil
        }
    }
}
