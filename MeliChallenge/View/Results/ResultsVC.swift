//
//  ResultsVC.swift
//  MeliChallenge
//
//  Created by Martin Victory on 09/05/2020.
//  Copyright © 2020 Martin Victory. All rights reserved.
//

import UIKit

class ResultsVC: UIViewController {
    
    var viewModel: ResultsVM? {
        didSet {
            viewModel?.viewDelegate = self
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func loadView() {
        self.view = UIView()
        self.view.backgroundColor = .white
    }

}

extension ResultsVC: ResultsVMViewDelegate {
    func resultsDidUpdate(viewModel: ResultsVM) {
        // reload table
    }
}
