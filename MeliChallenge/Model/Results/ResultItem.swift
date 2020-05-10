//
//  ResultItem.swift
//  MeliChallenge
//
//  Created by Martin Victory on 09/05/2020.
//  Copyright © 2020 Martin Victory. All rights reserved.
//

import Foundation

protocol ResultItem {
    var id: String { get }
    var title: String { get }
    var price: Float { get }
    var thumbnail: String { get }
}
