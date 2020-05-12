//
//  ItemVMImplementationTest.swift
//  MeliChallengeTests
//
//  Created by Martin Victory on 12/05/2020.
//  Copyright © 2020 Martin Victory. All rights reserved.
//

import XCTest
@testable import MeliChallenge

class ItemVMImplementationTest: XCTestCase {
    
    var viewModel: ItemVMImplementation!

    override func setUpWithError() throws {
        viewModel = ItemVMImplementation()
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }

    func testDefault() {
        XCTAssertNil(viewModel.model)
        XCTAssertNil(viewModel.viewDelegate)
        XCTAssertNil(viewModel.coordinatorDelegate)
    }
    
    func testSetModel() {
        viewModel.model = MockItemModel()
        
        // view model should convert the api results to the basic item model
        XCTAssertNotNil(viewModel.item)
        XCTAssertEqual(viewModel.item?.id, "id1")
    }
    
    func testSetModelFail() {
        let viewDelegate = ItemVMViewDelegateSpy()
        viewModel.model = MockItemModelFail()
        viewModel.viewDelegate = viewDelegate
        
        // view model should inform view the error
        XCTAssertNil(viewModel.item)
        XCTAssertTrue(viewDelegate.didError)
        XCTAssertTrue(viewDelegate.viewModel === viewModel)
    }
    
    func testModelUpdate() {
        let viewDelegate = ItemVMViewDelegateSpy()
        viewModel.model = MockItemModel()
        viewModel.viewDelegate = viewDelegate
        
        // view model should inform the view of the model change
        XCTAssertNotNil(viewModel.item)
        XCTAssertTrue(viewDelegate.didUpdate)
        XCTAssertTrue(viewDelegate.viewModel === viewModel)
    }
}

class MockItemModel: ItemModel {
    private(set) var item = APIItem(id: "id1", title: "title1", price: 1, condition: "new", quantity: 1, pictures: [APIItemPictures(id: "id1", secureUrl: "url1")], pictureData: nil, description: APIItemDescription(id: "id1", text: "description1"))
    
    func item(_ completitionHandler: @escaping (Result<APIItem, APIError>) -> Void) {
        completitionHandler(.success(item))
    }
}

class MockItemModelFail: ItemModel {
    func item(_ completitionHandler: @escaping (Result<APIItem, APIError>) -> Void) {
        completitionHandler(.failure(APIError.defaultError))
    }
}

class ItemVMViewDelegateSpy: ItemVMViewDelegate {
    private(set) var didUpdate = false
    private(set) var didError = false
    private(set) var viewModel: ItemVM?
    private(set) var item: Item?
    
    func itemDidUpdate(viewModel: ItemVM, item: Item) {
        didUpdate = true
        self.viewModel = viewModel
        self.item = item
    }
    
    func loadDidFail(viewModel: ItemVM) {
        didError = true
        self.viewModel = viewModel
    }
}
