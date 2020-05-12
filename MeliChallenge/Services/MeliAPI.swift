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
    private static let itemPath = "items/"
    private static let descriptionSubpath = "/descriptions"

    case search(q: String)
    case item(id: String)
    case itemDescription(id: String)
}

extension MeliAPI: TargetType {
    var baseURL: URL {
        guard let url = URL(string: MeliAPI.baseUrl) else { fatalError("Meli base api couldn't be configured") }
        return url
    }
    
    var path: String {
        switch self {
        case .search: return MeliAPI.searchPath
        case .item(id: let id): return MeliAPI.itemPath + id
        case .itemDescription(id: let id): return MeliAPI.itemPath + id + MeliAPI.descriptionSubpath
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .search, .item, .itemDescription: return .get
        }
    }
    
    var sampleData: Data {
        switch self {
        case .search: return stubbedResponse(filename: "SearchResults")
        case .item: return stubbedResponse(filename: "Item")
        case .itemDescription: return stubbedResponse(filename: "Description")
        }
    }
    
    var task: Task {
        switch self {
        case .search(let q):
            return .requestParameters(parameters: ["q": q], encoding: URLEncoding.queryString)
        case .item, .itemDescription: return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
    
    // MARK: Stubbed data
    private func stubbedResponse(filename: String) -> Data! {
        @objc class TestClass: NSObject { }
        
        let bundle = Bundle.init(for: TestClass.self)
        let path = bundle.path(forResource: filename, ofType: "json")
        return (try? Data(contentsOf: URL(fileURLWithPath: path!)))
    }
}

