//
//  APIItem.swift
//  MeliChallenge
//
//  Created by Martin Victory on 11/05/2020.
//  Copyright © 2020 Martin Victory. All rights reserved.
//

import Foundation

struct APIItem: Decodable {
    let id: String
    let title: String
    let price: Float
    let condition: String
    let quantity: Int
    let pictures: [APIItemPictures]
    var pictureData: Data?
    var description: APIItemDescription?
    
    private enum CodingKeys: String, CodingKey {
        case id, title, price, condition, quantity = "available_quantity", pictures
    }
}

struct APIItemPictures: Decodable {
    let id: String
    let secureUrl: String
    
    private enum CodingKeys: String, CodingKey {
        case id, secureUrl = "secure_url"
    }
}
