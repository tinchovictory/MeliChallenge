//
//  ViewController.swift
//  MeliChallenge
//
//  Created by Martin Victory on 09/05/2020.
//  Copyright © 2020 Martin Victory. All rights reserved.
//

import UIKit

class SearchViewController: BaseViewController {
    
    private let searchBar = UISearchBar()
    private var viewModel: SearchVM?

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
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.text = nil
        searchBar.resignFirstResponder()
    }
}
