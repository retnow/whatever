//
//  PrimaryButton.swift
//  Whatever
//
//  Created by Retno Widyanti on 7/9/19.
//  Copyright © 2019 Retno Widyanti. All rights reserved.
//

import UIKit

class PrimaryButton: UIButton {
    
    private func setup() {
        // Title label
        titleLabel?.font = ScaledFont().font(forTextStyle: .callout)
        setTitleColor(UIColor(named: .textInverted), for: .normal)
        setTitleColor(UIColor(named: .textInverted), for: .disabled)
        
        layer.cornerRadius = 25.0
        clipsToBounds = true
        
        // Set initial background color based on enabled state.
        backgroundColor = isEnabled ?
            UIColor(named: .button)
            : UIColor(named: .disabled)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
       setup()
    }
    
    // Change background color when button changes enabled state.
    override var isEnabled: Bool {
        didSet {
            backgroundColor = isEnabled ?
                UIColor(named: .button)
                : UIColor(named: .disabled)
        }
    }
}
