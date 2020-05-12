//
//  MockNetworkManager.swift
//  MeliChallengeTests
//
//  Created by Martin Victory on 12/05/2020.
//  Copyright © 2020 Martin Victory. All rights reserved.
//

import Foundation
@testable import MeliChallenge

class MockNetworkManager: NetworkManager {
    var searchSuccess = true
    var imageSuccess = true
    var itemSuccess = true
    var descriptionSuccess = true
    
    private(set) var apiSearchResult = [APISearchResult(id: "id1", title: "title1", price: 1, thumbnail: "url", thumbnailData: nil)]
    private(set) var apiItem = APIItem(id: "id1", title: "title1", price: 1, condition: "new", quantity: 1, pictures: [APIItemPictures(id: "id1", secureUrl: "url")], pictureData: nil, description: nil)
    private(set) var itemDescription = APIItemDescription(id: "id1", text: "description1")

    func getSearchResults(q: String, completition: @escaping (Result<[APISearchResult], APIError>) -> Void) {
        if searchSuccess {
            completition(.success(apiSearchResult))
        } else {
            completition(.failure(APIError.defaultError))
        }
    }
    
    func getImage(url: String, completition: @escaping (Result<Data, APIError>) -> Void) {
        if imageSuccess {
            completition(.success(Data()))
        } else {
            completition(.failure(APIError.defaultError))
        }
    }
    
    func getItem(withId id: String, completition: @escaping (Result<APIItem, APIError>) -> Void) {
        if itemSuccess {
            completition(.success(apiItem))
        } else {
            completition(.failure(APIError.defaultError))
        }
    }
    
    func getItemDescription(withId id: String, completition: @escaping (Result<APIItemDescription?, APIError>) -> Void) {
        if descriptionSuccess {
            completition(.success(itemDescription))
        } else {
            completition(.failure(APIError.defaultError))
        }
    }
}
