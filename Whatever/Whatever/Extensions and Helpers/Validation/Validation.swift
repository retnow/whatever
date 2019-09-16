//
//  Validation.swift
//  Whatever
//
//  Created by Retno Widyanti on 14/9/19.
//  Copyright © 2019 Retno Widyanti. All rights reserved.
//

import Foundation

public enum ValidationInput {
    case email
    case notEmpty
    case password
    
    var errorMessage: String {
        switch self {
        case .email:
            return NSLocalizedString("validation_error_email", comment: "")
        case .notEmpty:
            return NSLocalizedString("validation_error_empty", comment: "")
        case .password:
            return NSLocalizedString("validation_error_password", comment: "")
        }
    }
    
    // Regex predicate to match against for relevant type.
    var regex: String {
        switch self {
        case .email:
            return "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        // Not relevant, so return an empty string.
        case .notEmpty:
            return ""
        // Note that this regex is the requirement that matches an invalid password.
        case .password:
            return "^(.{0,7}|[a-zA-Z0-9]*)$"
        }
    }
}

public class Validation {
    static func validate(
        _ text: String,
        against type: ValidationInput) -> Bool {
        switch type {
        case .email:
            return Validation.compare(text, matching: type.regex)
        case .password:
            return !Validation.compare(text, matching: type.regex)
        case .notEmpty:
            return !text.isEmpty
        }
    }
    
    private static func compare(
        _ text: String,
        matching regex: String) -> Bool {
        do {
            // If match is found against given regex pattern, return true.
            if try NSRegularExpression(
                pattern: regex,
                options: .caseInsensitive)
                .firstMatch(
                    in: text,
                    options: [],
                    range: NSRange(location: 0, length: text.count)) != nil {
                return true
            }
        } catch {
            return false
        }
        
        return false
    }
}
