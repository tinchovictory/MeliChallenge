//
//  MeliAPI.swift
//  MeliChallenge
//
//  Created by Martin Victory on 11/05/2020.
//  Copyright © 2020 Martin Victory. All rights reserved.
//

import Foundation
import Moya

enum MeliAPI {
    private static let baseUrl = "https://api.mercadolibre.com/"
    private static let searchPath = "sites/MLA/search"

    case search(q: String)
}

extension MeliAPI: TargetType {
    var baseURL: URL {
        guard let url = URL(string: MeliAPI.baseUrl) else { fatalError("Meli base api couldn't be configured") }
        return url
    }
    
    var path: String {
        switch self {
        case .search: return MeliAPI.searchPath
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .search: return .get
        }
    }
    
    var sampleData: Data {
        return Data() // TODO: Change to real test data
    }
    
    var task: Task {
        switch self {
        case .search(let q):
            return .requestParameters(parameters: ["q": q], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }

}
