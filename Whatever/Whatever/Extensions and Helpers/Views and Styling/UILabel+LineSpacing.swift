//
//  UILabel+LineSpacing.swift
//  Whatever
//
//  Created by Retno Widyanti on 8/9/19.
//  Copyright © 2019 Retno Widyanti. All rights reserved.
//

import UIKit

extension UILabel {
    // Sets text to given string, styled with a given line height multiple.
    func setText(
        to text: String,
        withLineHeightMultiple lineHeightMultiple: CGFloat) {
        let attributedString = NSMutableAttributedString(string: text)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = lineHeightMultiple
        attributedString.addAttribute(
            .paragraphStyle,
            value: paragraphStyle,
            range: NSMakeRange(0, attributedString.length))
        attributedText = attributedString
    }
}
