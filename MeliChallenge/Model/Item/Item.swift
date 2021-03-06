//
//  Item.swift
//  MeliChallenge
//
//  Created by Martin Victory on 09/05/2020.
//  Copyright © 2020 Martin Victory. All rights reserved.
//

import Foundation
import UIKit

protocol Item {
    var id: String { get }
    var title: String { get }
    var price: Float { get }
    var condition: String { get }
    var quantity: Int { get }
    var picture: UIImage? { get }
    var description: String? { get }
}
