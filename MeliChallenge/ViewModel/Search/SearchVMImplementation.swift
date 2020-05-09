//
//  SearchVMImplementation.swift
//  MeliChallenge
//
//  Created by Martin Victory on 09/05/2020.
//  Copyright © 2020 Martin Victory. All rights reserved.
//

import Foundation

class SearchVMImplementation: SearchVM {
    // keep track of the coorinator in order to end the current screen
    weak var coordinatorDelegate: SearchVMCoordinatorDelegate?

    // on search change inform the vc if it can submit
    var search = ""

    func submit() {
        print("Submit with word \(search)")

        self.coordinatorDelegate?.searchVMDidFinish(viewModel: self)
    }
}
