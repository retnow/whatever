//
//  YourClosetMenuView.swift
//  Whatever
//
//  Created by Widyanti, Retno (AU - Melbourne) on 23/9/19.
//  Copyright © 2019 Retno Widyanti. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class YourClosetMenuView: UIView, UICollectionViewDelegate,
    UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
            flowLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(
                frame: .zero,
                collectionViewLayout: flowLayout)
            collectionView.showsHorizontalScrollIndicator = false
            collectionView.backgroundColor = UIColor(named: .background)
            collectionView.delegate = self
            collectionView.dataSource = self
            return collectionView
    }()

    var headers: [String] = [] {
        didSet {
            self.collectionView.reloadData()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    private func setup() {
    }

    // TODO: Finish
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int) -> Int {
        return headers.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
}

