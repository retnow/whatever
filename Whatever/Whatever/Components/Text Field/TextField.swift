//
//  TextField.swift
//  Whatever
//
//  Created by Retno Widyanti on 8/9/19.
//  Copyright © 2019 Retno Widyanti. All rights reserved.
//

import UIKit

class TextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        font = ScaledFont().font(forTextStyle: .body)
        backgroundColor = .clear
        textColor = UIColor(named: .text)
        adjustsFontForContentSizeCategory = true
    }
}
