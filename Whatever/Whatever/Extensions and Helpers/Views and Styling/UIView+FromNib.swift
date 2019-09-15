//
//  UIView+FromNib.swift
//  Whatever
//
//  Created by Retno Widyanti on 8/9/19.
//  Copyright © 2019 Retno Widyanti. All rights reserved.
//

import UIKit

/**
 An extension on UView that contains functions to easily load nibs.
 */
extension UIView {
    class func fromNib<T: UIView>() -> T {
        return Bundle.main.loadNibNamed(
            String(describing: T.self),
            owner: nil,
            options: nil)![0] as! T
    }
}
