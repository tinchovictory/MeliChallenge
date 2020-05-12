//
//  ResultsTableView.swift
//  MeliChallenge
//
//  Created by Martin Victory on 11/05/2020.
//  Copyright © 2020 Martin Victory. All rights reserved.
//

import UIKit

class ResultsTableView: UITableView {
    
    static let cellIdentifier = "ResultsCell"

    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        self.backgroundColor = .white
        
        // register cell
        self.register(ResultsTableViewCell.self, forCellReuseIdentifier: ResultsTableView.cellIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
