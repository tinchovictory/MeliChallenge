//
//  Router.swift
//  MeliChallenge
//
//  Created by Martin Victory on 09/05/2020.
//  Copyright © 2020 Martin Victory. All rights reserved.
//

import UIKit

protocol Router: class {
    func push(_ vc: UIViewController, isAnimated: Bool, withCoordinator: Coordinator)
    func pop(isAnimated: Bool)
}
