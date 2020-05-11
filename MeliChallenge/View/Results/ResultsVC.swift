//
//  ResultsVC.swift
//  MeliChallenge
//
//  Created by Martin Victory on 09/05/2020.
//  Copyright © 2020 Martin Victory. All rights reserved.
//

import UIKit

fileprivate enum Status {
    case loading, error, done
}

class ResultsVC: BaseViewController {
    
    var viewModel: ResultsVM? {
        didSet {
            viewModel?.viewDelegate = self
        }
    }
    
    private var tableView: ResultsTableView? {
        didSet {
            self.tableView?.delegate = self
            self.tableView?.dataSource = self
        }
    }
    private var status: Status = .loading

    override func loadView() {
        self.view = LoadingScreenView()
    }
}

extension ResultsVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.viewModel?.selectItemAt(index: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
  
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 150
        return UITableView.automaticDimension
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
        if status == .loading {
            // change loading screen for tableview
            self.tableView = ResultsTableView()
            self.view = self.tableView
            self.status = .done
        } else {
            // reload table
            self.tableView?.reloadData()
        }
    }

    func restulsDidError(viewModel: ResultsVM) {
        // show error msg
        self.status = .error
    }
}
