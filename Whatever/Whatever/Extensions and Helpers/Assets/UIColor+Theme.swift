//
//  UIColor+Theme.swift
//  Whatever
//
//  Created by Retno Widyanti on 7/9/19.
//  Copyright © 2019 Retno Widyanti. All rights reserved.
//

import UIKit

/**
 An extension on UIColor that contains an enumeration of all themed colors and contains a convenience initializer that returns a corresponding color.
 */
extension UIColor {
    /// An enumeration of all color set names.
    enum name: String {
        // States
        case disabled
        
        // Background
        case background
        case backgroundInverted
        
        // Text
        case text
        case textInverted
        
        // Buttons
        case button
        case buttonInverted
    }
    
    /** Convenience initializer that returns force unwrapped UIColor for a theme given an enumerated color name.
     - Parameter name: The enumerated UIColor name
     
     Note that because the color that is returned is force unwrapped, a runtime crash will occur if there is no color set with the corresponding color name in the asset catalog (.xcassets) used for the target.
     */
    convenience init(named name: UIColor.name) {
        self.init(named: name.rawValue)!
    }
}
