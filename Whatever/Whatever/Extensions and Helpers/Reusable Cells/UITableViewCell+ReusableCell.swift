//
//  UITableViewCell+ReusableCell.swift
//  Whatever
//
//  Created by Retno Widyanti on 27/9/19.
//  Copyright © 2019 Retno Widyanti. All rights reserved.
//

import UIKit

/** Extension on UITableViewCell that gives cells a default reuse identifier
    and nib name matching class name.
 
    UITableViewCells conforming to TableViewCellLoadsFromNib then use this
    nibName when initialising.
*/
extension UITableViewCell {
    public static var defaultReuseIdentifier: String {
        return String(describing: self)
    }

    /// Note: Always name nibNames the same as their associated class, otherwise a crash will occur on dequeue.
    public static var nibName: String {
        return String(describing: self)
    }
}

protocol TableViewCellLoadsFromNib where Self: UITableViewCell { }
