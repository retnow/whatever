//
//  Caption1.swift
//  Whatever
//
//  Created by Retno Widyanti on 7/9/19.
//  Copyright © 2019 Retno Widyanti. All rights reserved.
//

import UIKit

class Label1: UILabel {

    private func setup() {
        font = ScaledFont().font(forTextStyle: .subheadline)
        adjustsFontForContentSizeCategory = true
    }
    
    /// Define custom initializers.
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    convenience init() {
        self.init(frame: .zero)
        setup()
    }
}
