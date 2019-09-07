//
//  UIImage+Theme.swift
//  Whatever
//
//  Created by Retno Widyanti on 7/9/19.
//  Copyright © 2019 Retno Widyanti. All rights reserved.
//

import UIKit

/**
 An extension on UIImage that contains an enumeration of all themed images and contains a convenience initializer that returns a corresponding color.
 */
extension UIImage {
    /// An enumeration of all image set names.
    enum name: String {
        // Logo
        case appLogo
        
        // Navigation bar
        case back
        
        // Introduction
        case introductionBackground
        case introductionOutfit
        case introductionLife
        case introductionCloset
    }
    
    /** Convenience initializer that returns force unwrapped UIImage for a theme given an enumerated image
     name.
     - Parameter name: The enumerated UIColor name
     
     Note that because the color that is returned is force unwrapped, a runtime crash will occur if there is no image set with the corresponding color name in the asset catalog (.xcassets) used for the target.
     */
    convenience init(named name: UIImage.name) {
        self.init(named: name.rawValue)!
    }
}
