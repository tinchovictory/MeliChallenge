//
//  OsLogExtension.swift
//  MeliChallenge
//
//  Created by Martin Victory on 10/05/2020.
//  Copyright © 2020 Martin Victory. All rights reserved.
//

import Foundation
import os.log

extension OSLog {
    private static var subsystem = Bundle.main.bundleIdentifier!
    
    static let navigation = OSLog(subsystem: subsystem, category: "navigation")
    static let buisnessLogic = OSLog(subsystem: subsystem, category: "buisnessLogic")
    static let view = OSLog(subsystem: subsystem, category: "view")
    static let network = OSLog(subsystem: subsystem, category: "network")
}
