//
//  TextSwiftUI.swift
//  InfoWebiOS
//
//  Created by Chhan Sophearith on 24/11/23.
//

import Foundation
import SwiftUI

struct TextSwiftUI: View {
    
    var title: String
    var size: FontSize = .normal
    var color: Color = .commonText
    var weight: Font.Weight = .regular
    var textAlignment: TextAlignment = .leading
    var lineLimit: Int?
    var fontName: String = "Roboto-Regular"
    
    var body: some View {
        Text(title)
            .foregroundColor(color)
            .font(
                .custom(UserPreference.shared.getLanguageCode() == "km" ? "Nokora" : fontName, size: size.rawValue)
                .weight(weight))
            .multilineTextAlignment(textAlignment)  
            .lineLimit(lineLimit)
    }
}
