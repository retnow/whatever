//
//  TertiaryButton.swift
//  Whatever
//
//  Created by Retno Widyanti on 7/9/19.
//  Copyright © 2019 Retno Widyanti. All rights reserved.
//

import UIKit

class TertiaryButton: UIButton {
    
    private func setup() {
        // Title label
        titleLabel?.textColor = UIColor(named: .text)
        titleLabel?.font = ScaledFont().font(forTextStyle: .callout)
        
        backgroundColor = .clear
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
}
