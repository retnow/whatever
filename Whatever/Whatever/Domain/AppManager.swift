//
//  AppManager.swift
//  Whatever
//
//  Created by Widyanti, Retno (AU - Melbourne) on 12/9/19.
//  Copyright © 2019 Retno Widyanti. All rights reserved.
//

import Foundation

final class AppManager {
    static let shared = AppManager()

    // Private singleton initialiser.
    private init() { }

    let authentication = AuthenticationManager()
}
