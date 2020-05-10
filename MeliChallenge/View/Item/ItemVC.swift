//
//  ItemVC.swift
//  MeliChallenge
//
//  Created by Martin Victory on 09/05/2020.
//  Copyright © 2020 Martin Victory. All rights reserved.
//

import UIKit
import os.log

class ItemVC: UIViewController {
    var viewModel: ItemVM? {
        didSet {
            viewModel?.viewDelegate = self
        }
    }
    
    override func viewDidLoad() {
    
    }
    
    override func loadView() {
        self.view = UIView()
        self.view.backgroundColor = .white
    }
}

extension ItemVC: ItemVMViewDelegate {
    func itemDidUpdate(viewModel: ItemVM) {
        os_log("ItemVC: itemDidUpdate(): itemId=%{PUBLIC}@", log: OSLog.view, type: .debug, viewModel.item?.id ?? "")
    }
    
    func loadDidFail(viewModel: ItemVM) {
        os_log("ItemVC: loadDidFail()", log: OSLog.view, type: .debug)
    }
}
