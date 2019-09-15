//
//  SecondaryButton.swift
//  Whatever
//
//  Created by Retno Widyanti on 7/9/19.
//  Copyright © 2019 Retno Widyanti. All rights reserved.
//

import UIKit

class SecondaryButton: UIButton {
    
    private func setup() {
        // Title label
        titleLabel?.textColor = UIColor(named: .text)
        titleLabel?.font = ScaledFont().font(forTextStyle: .callout)
        
        layer.cornerRadius = 25.0
        layer.borderWidth = 2.0
        clipsToBounds = true
        
        backgroundColor = .clear
        
        // Set initial colors based on enabled state.
        let color = isEnabled
            ? UIColor(named: .button)
            : UIColor(named: .disabled)
        layer.borderColor = color.cgColor
        titleLabel?.textColor = color
        self.isEnabled = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override var isEnabled: Bool {
        didSet {
            let color = isEnabled
                ? UIColor(named: .button)
                : UIColor(named: .disabled)
            layer.borderColor = color.cgColor
            setTitleColor(color, for: .normal)
        }
    }
}

