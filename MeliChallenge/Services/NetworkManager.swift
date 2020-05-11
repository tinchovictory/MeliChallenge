//
//  NetworkManager.swift
//  MeliChallenge
//
//  Created by Martin Victory on 11/05/2020.
//  Copyright © 2020 Martin Victory. All rights reserved.
//

import Foundation

protocol NetworkManager: class {
    func getSearchResults(q: String, completition: @escaping (Result<[APISearchResult], APIError>) -> Void)

    func getImage(url: String, completition: @escaping (Result<Data, APIError>) -> Void)

    func getItem(withId id: String, completition: @escaping (Result<APIItem, APIError>) -> Void)
    
    func getItemDescription(withId id: String, completition: @escaping (Result<APIItemDescription?, APIError>) -> Void)
}
