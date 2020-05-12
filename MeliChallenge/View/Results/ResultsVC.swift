//
//  ResultsVC.swift
//  MeliChallenge
//
//  Created by Martin Victory on 09/05/2020.
//  Copyright © 2020 Martin Victory. All rights reserved.
//

import UIKit

class ResultsVC: BaseViewController {
    
    var viewModel: ResultsVM? {
        didSet {
            viewModel?.viewDelegate = self
        }
    }
    
    private var resultsView: ResultsView?

    override func loadView() {
        self.resultsView = ResultsView()
        self.view = self.resultsView
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
        let cell = tableView.dequeueReusableCell(withIdentifier: ResultsTableView.cellIdentifier, for: indexPath) as! ResultsTableViewCell
        
        if let item = viewModel?.itemAt(index: indexPath.row) {
            cell.resultItem = item
        }
        
        return cell
    }
}

extension ResultsVC: ResultsVMViewDelegate {
    func resultsDidUpdate(viewModel: ResultsVM) {
        self.resultsView?.showResultsTable(delegate: self, dataSource: self)
    }

    func restulsDidError(viewModel: ResultsVM) {
        self.resultsView?.showError()
    }
}
