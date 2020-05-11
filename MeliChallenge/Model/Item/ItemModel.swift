//
//  ItemModel.swift
//  MeliChallenge
//
//  Created by Martin Victory on 09/05/2020.
//  Copyright © 2020 Martin Victory. All rights reserved.
//

import Foundation

protocol ItemModel: class {
    func item(_ completitionHandler: @escaping (_ item: Result<APIItem, APIError>) -> Void)
}
