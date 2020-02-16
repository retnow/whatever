//
//  YourClosetViewController.swift
//  Whatever
//
//  Created by Widyanti, Retno (AU - Melbourne) on 20/9/19.
//  Copyright © 2019 Retno Widyanti. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class YourClosetViewController: AppViewController {
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        // Set large title display mode.
        navigationItem.largeTitleDisplayMode = .always

        // Bar button items
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: nil)
        navigationItem.leftBarButtonItem?.accessibilityLabel = NSLocalizedString(
            "your_closet_add_accessibility_label",
            comment: "")

        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(named: .filter),
            style: .plain,
            target: self,
            action: nil)
        navigationItem.rightBarButtonItem?.accessibilityLabel = NSLocalizedString(
            "your_closet_filter_accessibility_label",
            comment: "")

        // Strings
        navigationItem.title = NSLocalizedString("your_closet_title", comment: "")
    }
}
