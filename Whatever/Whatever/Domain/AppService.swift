//
//  AppService.swift
//  Whatever
//
//  Created by Retno Widyanti on 12/9/19.
//  Copyright © 2019 Retno Widyanti. All rights reserved.
//

import Foundation

final class AppService {
    static let shared = AppService()

    // Private singleton initialiser.
    private init() { }

    let authentication = AuthenticationService()
}
