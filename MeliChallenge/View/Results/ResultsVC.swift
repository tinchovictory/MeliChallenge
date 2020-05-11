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
    
    private var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "resultCell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    override func loadView() {
        self.view = UIView()
        self.view.backgroundColor = .white
        
        self.tableView = UITableView()
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.tableView)
        
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
        ])
    }

}

extension ResultsVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.viewModel?.selectItemAt(index: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension ResultsVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.viewModel?.numberOfItems ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "resultCell", for: indexPath)
        
        if let item = viewModel?.itemAt(index: indexPath.row) {
            cell.textLabel?.text = item.title
            
            if let image = item.thumbnail {
                cell.imageView?.image = image
            }
        }
        
        return cell
    }
}

extension ResultsVC: ResultsVMViewDelegate {
    func resultsDidUpdate(viewModel: ResultsVM) {
        // reload table
        self.tableView.reloadData()
    }

    func restulsDidError(viewModel: ResultsVM) {
        // show error msg
    }
}
