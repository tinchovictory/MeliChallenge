//
//  ItemVC.swift
//  MeliChallenge
//
//  Created by Martin Victory on 09/05/2020.
//  Copyright © 2020 Martin Victory. All rights reserved.
//

import UIKit
import os.log

class ItemVC: BaseViewController {
    var viewModel: ItemVM? {
        didSet {
            viewModel?.viewDelegate = self
        }
    }
    
    private var itemView: ItemView!

    override func loadView() {
        self.itemView = ItemView()
        self.view = itemView
    }
}

extension ItemVC: ItemVMViewDelegate {
    func itemDidUpdate(viewModel: ItemVM, item: Item) {
        os_log("ItemVC: itemDidUpdate(): itemId=%{PUBLIC}@", log: OSLog.view, type: .debug, viewModel.item?.id ?? "")
        itemView.showItem(item)
    }
    
    func loadDidFail(viewModel: ItemVM) {
        os_log("ItemVC: loadDidFail()", log: OSLog.view, type: .debug)
        itemView.showError()
    }
}
