//
//  ViewController.swift
//  MeliChallenge
//
//  Created by Martin Victory on 09/05/2020.
//  Copyright © 2020 Martin Victory. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    let searchBar = UISearchBar()
    
    var viewModel: SearchVM?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func loadView() {
        self.view = UIView()
        self.view.backgroundColor = .white
        
        navigationItem.titleView = searchBar
        searchBar.delegate = self
        
        searchBar.sizeToFit()
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel?.search = searchBar.text ?? ""
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel?.submit()
    }
}
