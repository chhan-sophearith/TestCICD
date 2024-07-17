//
//  UIFont.swift
//  InfoWebiOS
//
//  Created by Bhadresh on 03/01/24.
//

import SwiftUI

extension Font {
    static func customFont(size: CGFloat, 
                           weight: Font.Weight = .regular,
                           fontName: String = UserPreference.shared.getLanguageCode() == "km" ? "Nokora" : "Roboto") -> Font {
        
        return Font.custom(fontName, size: size).weight(weight)
    }
}
