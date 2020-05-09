//
//  Router.swift
//  MeliChallenge
//
//  Created by Martin Victory on 09/05/2020.
//  Copyright © 2020 Martin Victory. All rights reserved.
//

import UIKit

typealias NavigationBackClosure = (() -> ())

protocol Router: class {
    func push(_ vc: UIViewController, isAnimated: Bool, onNavigateBack: NavigationBackClosure)
    func pop(isAnimated: Bool)
}
