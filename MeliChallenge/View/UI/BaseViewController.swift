//
//  BaseViewController.swift
//  MeliChallenge
//
//  Created by Martin Victory on 11/05/2020.
//  Copyright © 2020 Martin Victory. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set navigation bar colors
        navigationController?.navigationBar.barTintColor = UIColor.mainColor
        navigationController?.navigationBar.tintColor = UIColor.black
        
//        navigationController?.navigationBar.barStyle = UIBarStyle.default
    }
}
