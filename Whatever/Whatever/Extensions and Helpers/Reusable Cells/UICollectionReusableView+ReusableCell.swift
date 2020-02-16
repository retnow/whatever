//
//  UICollectionReusableView+ReusableCell.swift
//  Whatever
//
//  Created by Retno Widyanti on 27/9/19.
//  Copyright © 2019 Retno Widyanti. All rights reserved.
//

import UIKit

/** Extension on UICollectionReusableView that gives views a default reuse
    identifier and nib name matching class name.
 
    UICollectionReusableViews (including UICollectionViewCells) conforming to CollectionReusableViewLoadsFromNib then use this nibName when initialising.
*/
extension UICollectionReusableView {
    public static var defaultReuseIdentifier: String {
        return String(describing: self)
    }

    public static var nibName: String {
        return String(describing: self)
    }
}

protocol CollectionReusableViewLoadsFromNib where Self: UICollectionReusableView { }
