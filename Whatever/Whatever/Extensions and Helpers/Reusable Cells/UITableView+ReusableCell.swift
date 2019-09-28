//
//  UITableView+ReusableCell.swift
//  Whatever
//
//  Created by Retno Widyanti on 27/9/19.
//  Copyright © 2019 Retno Widyanti. All rights reserved.
//

import UIKit

/** Extension on UITableView containing helper functions for registering and
    dequeueing reusable table view cells.
*/
extension UITableView {
    func register<T: UITableViewCell>(_: T.Type) {
        self.register(
            T.self,
            forCellReuseIdentifier: T.defaultReuseIdentifier)
    }

    func register<T>(_: T.Type) where T: TableViewCellLoadsFromNib {
        self.register(
            UINib(nibName: T.defaultReuseIdentifier, bundle: nil),
            forCellReuseIdentifier: T.defaultReuseIdentifier)
    }

    func dequeueReusableCell<T: UITableViewCell>(
        for indexPath: IndexPath) -> T {
        self.register(T.self)
        return dequeueReusableCell(
            withIdentifier: T.defaultReuseIdentifier,
            for: indexPath) as! T
    }

    func dequeueReusableCell<T: UITableViewCell>() -> T {
        self.register(T.self)
        return dequeueReusableCell(
            withIdentifier: T.defaultReuseIdentifier) as! T
    }

    func dequeueReusableCell<T>(for indexPath: IndexPath) -> T where T: TableViewCellLoadsFromNib {
        self.register(T.self)
        return dequeueReusableCell(
            withIdentifier: T.defaultReuseIdentifier,
            for: indexPath) as! T
    }

    func dequeueReusableCell<T>() -> T where T: TableViewCellLoadsFromNib {
        self.register(T.self)
        return dequeueReusableCell(
            withIdentifier: T.defaultReuseIdentifier) as! T
    }
}
