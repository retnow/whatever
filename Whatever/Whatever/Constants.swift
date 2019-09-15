//
//  Constants.swift
//  Whatever
//
//  Created by Retno Widyanti on 15/9/19.
//  Copyright © 2019 Retno Widyanti. All rights reserved.
//

import Foundation

enum Constants {
    enum Keychain {
        static let userEmail = "userEmail"
        static let PIN = "PIN"
    }
    
    enum UserDefaults {
        static let isBiometricsEnabled = "isBiometricsEnabled"
        static let isPINEnabled = "isPINEnabled"
        static let hasEnabledBiometricsBefore = "hasEnabledBiometricsBefore"
        static let hasLaunchedBefore = "hasLaunchedBefore"
    }
}
