//
//  ItemVC.swift
//  MeliChallenge
//
//  Created by Martin Victory on 09/05/2020.
//  Copyright © 2020 Martin Victory. All rights reserved.
//

import UIKit

class ItemVC: UIViewController {
    var viewModel: ItemVM? {
        didSet {
            viewModel?.viewDelegate = self
        }
    }
    
    override func viewDidLoad() {
        print("view loaded")
    }
    
    override func loadView() {
        self.view = UIView()
        self.view.backgroundColor = .white
        
        print("view loading")
    }
}

extension ItemVC: ItemVMViewDelegate {
    func itemDidUpdate(viewModel: ItemVM) {
        print("item updated \(viewModel.item?.id ?? "") \(viewModel.item?.title ?? "")")
    }
    
    func loadDidFail(viewModel: ItemVM) {
        print("item failed to load")
    }
}
