//
//  NetworkManagerImplementation.swift
//  MeliChallenge
//
//  Created by Martin Victory on 11/05/2020.
//  Copyright © 2020 Martin Victory. All rights reserved.
//

import Foundation
import Moya
import Alamofire
import AlamofireImage
import os.log

class NetworkManagerImplementation: NetworkManager {
    private var provider = MoyaProvider<MeliAPI>()
    
    func getSearchResults(q: String, completition: @escaping (Result<[APISearchResult], APIError>) -> Void) {
        provider.request(.search(q: q)) { result in
            switch result {
            case let .failure(error):
                os_log("NetworkManagerImplementation: getSearchResults(): %{PUBLIC}@", log: OSLog.network, type: .error, error as CVarArg)
                completition(.failure(.connectionError))
            case let .success(response):
                do {
                    let results = try JSONDecoder().decode(APISearch.self, from: response.data)
                    completition(.success(results.results))
                } catch let error {
                    os_log("NetworkManagerImplementation: getSearchResults(): %{PUBLIC}@", log: OSLog.network, type: .error, error as CVarArg)
                    completition(.failure(.parsingError))
                }
            }
        }
    }

    func getImage(url: String, completition: @escaping (Result<Data, APIError>) -> Void) {
        AF.request(url).responseImage { response in
            if let data = response.data {
                completition(.success(data))
            } else {
                if let error = response.error {
                    os_log("NetworkManagerImplementation: getImage(): %{PUBLIC}@", log: OSLog.network, type: .error, error as CVarArg)
                }
                completition(.failure(.connectionError))
            }
        }
    }
    
    func getItem(withId id: String, completition: @escaping (Result<APIItem, APIError>) -> Void) {
        provider.request(.item(id: id)) { result in
            switch result {
            case let .failure(error):
                os_log("NetworkManagerImplementation: getItem(): %{PUBLIC}@", log: OSLog.network, type: .error, error as CVarArg)
                completition(.failure(.connectionError))
            case let .success(response):
                do {
                    let item = try JSONDecoder().decode(APIItem.self, from: response.data)
                    completition(.success(item))
                } catch {
                    os_log("NetworkManagerImplementation: getItem(): %{PUBLIC}@", log: OSLog.network, type: .error, error as CVarArg)
                    completition(.failure(.parsingError))
                }
            }
        }
    }
    
    func getItemDescription(withId id: String, completition: @escaping (Result<APIItemDescription?, APIError>) -> Void) {
        provider.request(.itemDescription(id: id)) { result in
            switch result {
            case let .failure(error):
                os_log("NetworkManagerImplementation: getItemDescription(): %{PUBLIC}@", log: OSLog.network, type: .error, error as CVarArg)
                completition(.failure(.connectionError))
            case let .success(response):
                do {
                    let descriptions = try JSONDecoder().decode([APIItemDescription].self, from: response.data)
                    completition(.success(descriptions.first))
                } catch {
                    os_log("NetworkManagerImplementation: getItemDescription(): %{PUBLIC}@", log: OSLog.network, type: .error, error as CVarArg)
                    completition(.failure(.parsingError))
                }
            }
        }
    }
}
