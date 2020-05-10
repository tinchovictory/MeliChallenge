//
//  ResultsList.swift
//  MeliChallenge
//
//  Created by Martin Victory on 09/05/2020.
//  Copyright © 2020 Martin Victory. All rights reserved.
//

import Foundation

protocol ResultsList: class {
    func results(_ completitionHandler: @escaping (_ items: [ResultItem]) -> Void)
}
