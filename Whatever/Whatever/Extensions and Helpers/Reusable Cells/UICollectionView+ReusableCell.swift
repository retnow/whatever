//
//  UICollectionView+ReusableCell.swift
//  Whatever
//
//  Created by Retno Widyanti on 27/9/19.
//  Copyright © 2019 Retno Widyanti. All rights reserved.
//

import UIKit

/** Extension on UITableView containing helper functions for registering and
    dequeueing reusable collection view cells, headers and footers.
*/
extension UICollectionView {
    func register<T: UICollectionViewCell>(_: T.Type) {
        self.register(
            T.self,
            forCellWithReuseIdentifier: T.defaultReuseIdentifier)
    }

    func register<T>(_: T.Type)
        where T: CollectionViewCellLoadsFromNib {
        self.register(
            UINib(nibName: T.defaultReuseIdentifier, bundle: nil),
            forCellWithReuseIdentifier: T.defaultReuseIdentifier)
    }

    func dequeueReusableCell<T: UICollectionViewCell>(
        for indexPath: IndexPath) -> T {
        self.register(T.self)
        return dequeueReusableCell(
            withReuseIdentifier: T.defaultReuseIdentifier,
            for: indexPath) as! T
    }

    func dequeueReusableCell<T>(
        for indexPath: IndexPath) -> T
        where T: CollectionViewCellLoadsFromNib {
        self.register(T.self)
        return dequeueReusableCell(
            withReuseIdentifier: T.defaultReuseIdentifier,
            for: indexPath) as! T
    }

    /// Convenience methods for collection reusable views (headers, footers).
    func registerHeader<T>(_: T.Type)
        where T: CollectionReusableViewLoadsFromNib {
        self.register(
            UINib(nibName: T.defaultReuseIdentifier, bundle: nil),
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: T.defaultReuseIdentifier)
    }

    func registerFooter<T>(_: T.Type)
        where T: CollectionReusableViewLoadsFromNib {
            self.register(
                UINib(nibName: T.defaultReuseIdentifier, bundle: nil),
                forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                withReuseIdentifier: T.defaultReuseIdentifier)
    }

    func dequeueReusableHeader<T>(
        for indexPath: IndexPath) -> T
        where T: CollectionReusableViewLoadsFromNib {
            self.registerHeader(T.self)
            return dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                    withReuseIdentifier: T.defaultReuseIdentifier,
                                                    for: indexPath) as! T
    }

    func dequeueReusableFooter<T>(
        for indexPath: IndexPath) -> T
        where T: CollectionReusableViewLoadsFromNib {
            self.registerFooter(T.self)
            return dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter,
                                                    withReuseIdentifier: T.defaultReuseIdentifier,
                                                    for: indexPath) as! T
    }
}
