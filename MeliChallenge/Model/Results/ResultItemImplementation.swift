//
//  ResultImplementation.swift
//  MeliChallenge
//
//  Created by Martin Victory on 09/05/2020.
//  Copyright © 2020 Martin Victory. All rights reserved.
//

import Foundation
import UIKit

struct ResultItemImplementation: ResultItem {
    let id: String
    let title: String
    let price: Float
    let thumbnail: UIImage?
    
    init(apiSearchResult: APISearchResult) {
        self.id = apiSearchResult.id
        self.title = apiSearchResult.title
        self.price = apiSearchResult.price

        if let thumbnailData = apiSearchResult.thumbnailData {
            self.thumbnail = UIImage(data: thumbnailData)
        } else {
            self.thumbnail = nil
        }
    }
}
