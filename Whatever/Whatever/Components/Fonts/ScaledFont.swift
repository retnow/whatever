//
//  ScaledFont.swift
//  Whatever
//
//  Created by Retno Widyanti on 7/9/19.
//  Copyright © 2019 Retno Widyanti. All rights reserved.
//

import UIKit

/**
A public class that allows text styles to be used with custom font sets, which are defined in a supplied style dictionary.
 */
public final class ScaledFont {
    
    private struct FontDescription: Decodable {
        let fontSize: CGFloat
        let fontName: String
    }
    
    private typealias StyleDictionary = [UIFont.TextStyle.RawValue: FontDescription]
    private var styleDictionary: StyleDictionary?
    
    public init() {
        if let url = Bundle.main.url(forResource: "Fonts", withExtension: "plist"),
            let data = try? Data(contentsOf: url) {
            let decoder = PropertyListDecoder()
            styleDictionary = try? decoder.decode(StyleDictionary.self, from: data)
        }
    }
    
    public final class ScaledFont {
        
        private struct FontDescription: Decodable {
            let fontSize: CGFloat
            let fontName: String
        }
        
        private typealias StyleDictionary = [UIFont.TextStyle.RawValue: FontDescription]
        private var styleDictionary: StyleDictionary?
        
        public init() {
            if let url = Bundle.main.url(forResource: "Fonts", withExtension: "plist"),
                let data = try? Data(contentsOf: url) {
                let decoder = PropertyListDecoder()
                styleDictionary = try? decoder.decode(StyleDictionary.self, from: data)
            }
        }
        
        /// Get the scaled font for the given text style using the
        /// style dictionary supplied at initialization.
        ///
        /// - Parameter textStyle: The `UIFontTextStyle` for the
        ///   font.
        /// - Returns: A `UIFont` of the custom font that has been
        ///   scaled for the users currently selected preferred
        ///   text size.
        ///
        /// - Note: If the style dictionary does not have
        ///   a font for this text style the default preferred
        ///   font is returned.
        
        public func font(forTextStyle textStyle: UIFont.TextStyle) -> UIFont {
            guard let fontDescription = styleDictionary?[textStyle.rawValue],
                let font = UIFont(name: fontDescription.fontName, size: fontDescription.fontSize) else {
                    return UIFont.preferredFont(forTextStyle: textStyle)
            }
            
            let fontMetrics = UIFontMetrics(forTextStyle: textStyle)
            return fontMetrics.scaledFont(for: font)
        }
    }
    
    /// Get the scaled font for the given text style using the
    /// style dictionary supplied at initialization.
    ///
    /// - Parameter textStyle: The `UIFontTextStyle` for the
    ///   font.
    /// - Returns: A `UIFont` of the custom font that has been
    ///   scaled for the users currently selected preferred
    ///   text size.
    ///
    /// - Note: If the style dictionary does not have
    ///   a font for this text style the default preferred
    ///   font is returned.
    
    public func font(forTextStyle textStyle: UIFont.TextStyle) -> UIFont {
        guard let fontDescription = styleDictionary?[textStyle.rawValue],
            let font = UIFont(name: fontDescription.fontName, size: fontDescription.fontSize) else {
                return UIFont.preferredFont(forTextStyle: textStyle)
        }
        
        let fontMetrics = UIFontMetrics(forTextStyle: textStyle)
        return fontMetrics.scaledFont(for: font)
    }
}
