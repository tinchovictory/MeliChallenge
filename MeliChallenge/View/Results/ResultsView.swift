//
//  ResultsView.swift
//  MeliChallenge
//
//  Created by Martin Victory on 11/05/2020.
//  Copyright © 2020 Martin Victory. All rights reserved.
//

import UIKit

class ResultsView: UIView {

    private var contentView: UIView
    
    override init(frame: CGRect) {
        self.contentView = LoadingScreenView()
        super.init(frame: frame)
        
        self.addSubview(contentView)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func showResultsTable(delegate: UITableViewDelegate, dataSource: UITableViewDataSource) {
        self.contentView.removeFromSuperview()
        let tableView = ResultsTableView()
        tableView.delegate = delegate
        tableView.dataSource = dataSource
        self.contentView = tableView
        self.addSubview(self.contentView)
        setupLayout()
    }
    
    func showError() {
        self.contentView.removeFromSuperview()
        self.contentView = ErrorScreenView()
        self.addSubview(self.contentView)
        setupLayout()
    }

    func showEmptySearch() {
        self.contentView.removeFromSuperview()
        self.contentView = EmptySearchScreenView()
        self.addSubview(self.contentView)
        setupLayout()
    }
    
    private func setupLayout() {
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: self.topAnchor),
            contentView.leftAnchor.constraint(equalTo: self.leftAnchor),
            contentView.rightAnchor.constraint(equalTo: self.rightAnchor),
            contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
}
