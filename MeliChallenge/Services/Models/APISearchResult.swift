//
//  APISearchResult.swift
//  MeliChallenge
//
//  Created by Martin Victory on 11/05/2020.
//  Copyright © 2020 Martin Victory. All rights reserved.
//

import Foundation

struct APISearchResult: Decodable {
    let id: String
    let title: String
    let price: Float
    let thumbnail: String
    var thumbnailData: Data?
}
