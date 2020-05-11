//
//  ItemModelImplementation.swift
//  MeliChallenge
//
//  Created by Martin Victory on 09/05/2020.
//  Copyright © 2020 Martin Victory. All rights reserved.
//

import Foundation
import os.log

class ItemModelImplementation: ItemModel {
    private var item: APIItem?
    private let itemId: String
    private let networkManager: NetworkManager

    init(itemId: String, networkManager: NetworkManager) {
        self.itemId = itemId
        self.networkManager = networkManager
    }
    
    func item(_ completitionHandler: @escaping (Result<APIItem, APIError>) -> Void) {
        // go look item from the api
        DispatchQueue.global(qos: .utility).async { [weak self] in
            guard let self = self else {
                DispatchQueue.main.async {
                    completitionHandler(.failure(APIError.defaultError))
                }
                return
            }
            
            // item response
            self.networkManager.getItem(withId: self.itemId) { response in
                os_log("ItemModelImplementation: item(): Network manager finished get item", log: OSLog.network, type: .debug)
                
                switch response {
                case .failure(let err):
                    DispatchQueue.main.async {
                        completitionHandler(.failure(err))
                    }
                case .success(let apiItem):
                    DispatchQueue.main.async {
                        // save the item
                        self.item = apiItem
                        
                        // load picture and description
                        let group = DispatchGroup()
                        self.loadPicture(group: group)
                        self.loadDescription(group: group)
                        
                        // wait for both api calls
                        group.notify(queue: .main) {
                            os_log("ItemModelImplementation: item(): Finished loading picture and description", log: OSLog.network, type: .debug)
                            if let item = self.item {
                                completitionHandler(.success(item))
                            } else {
                                completitionHandler(.failure(APIError.defaultError))
                            }
                        }
                    }
                }
            }
        }
    }
    
    private func loadPicture(group: DispatchGroup) {
        guard let pictureUrl = self.item?.pictures.first?.secureUrl else { return }
        
        group.enter()
        self.networkManager.getImage(url: pictureUrl) { response in
            switch response {
            case .failure:
                os_log("ItemModelImplementation: loadPicture(): Unable to download picture", log: OSLog.network, type: .error)
            case .success(let image):
                self.item?.pictureData = image
            }
            group.leave()
        }
    }
    
    private func loadDescription(group: DispatchGroup) {
        group.enter()
        self.networkManager.getItemDescription(withId: self.itemId) { response in
            switch response {
            case .failure:
                os_log("ItemModelImplementation: loadDescription(): Unable to download description", log: OSLog.network, type: .error)
            case .success(let description):
                self.item?.description = description
            }
            group.leave()
        }
        
    }
}
