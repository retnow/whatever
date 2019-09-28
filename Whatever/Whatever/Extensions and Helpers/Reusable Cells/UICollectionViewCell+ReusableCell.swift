//
//  UICollectionViewCell+ReusableCell.swift
//  Whatever
//
//  Created by Retno Widyanti on 27/9/19.
//  Copyright © 2019 Retno Widyanti. All rights reserved.
//

import UIKit

/* A collection view cell conforming to this protocol will use the
 defaultReuseIdentifier and nibName, as defined in the extension on
 UICollectionReusableView, on dequeue.

 However, UICollectionViewCells need to conform to this protocol rather
 than CollectionReusableViewLoadsFromNib to properly load the nib.*/
protocol CollectionViewCellLoadsFromNib where Self: UICollectionViewCell {

}
