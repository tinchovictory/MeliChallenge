//
//  APIItemDescription.swift
//  MeliChallenge
//
//  Created by Martin Victory on 11/05/2020.
//  Copyright © 2020 Martin Victory. All rights reserved.
//

import Foundation

struct APIItemDescription: Decodable {
    let id: String
    let text: String
    
    private enum CodingKeys: String, CodingKey {
        case id, text = "plain_text"
    }
}
