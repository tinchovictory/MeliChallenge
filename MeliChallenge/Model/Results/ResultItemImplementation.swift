//
//  ResultImplementation.swift
//  MeliChallenge
//
//  Created by Martin Victory on 09/05/2020.
//  Copyright © 2020 Martin Victory. All rights reserved.
//

import Foundation

struct ResultItemImplementation: ResultItem {
    let id: String
    let title: String
    let price: Float
    let thumbnail: Data?
    
    init(apiSearchResult: APISearchResult) {
        self.id = apiSearchResult.id
        self.title = apiSearchResult.title
        self.price = apiSearchResult.price
        self.thumbnail = apiSearchResult.thumbnailData
    }
}
