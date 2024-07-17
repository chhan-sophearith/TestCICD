//
//  CustomButton.swift
//  InfoWebiOS
//
//  Created by lyborey on 29/11/23.
//

import SwiftUI

struct CustomButton: View {
    var text: String
    var icon: String = ""
    var textColor: Color? = .white
    var size: FontSize = .medium
    var weight: Font.Weight = .medium
    var backgroundColor: Color?
    var borderColor: Color = Color.clear
    var isDisable: Bool = false
    var width: Double = .infinity
    var height: Double = 45
    var cornerRadius: CGFloat?
    var disableColor: Color? = Color.gray
    var isProfileDeleteView: Bool = false
    var action: (() -> Void)?
    @AppStorage("isDarkMode") private var isDarkMode = UserPreference.shared.getIsDarkMode()
    var body: some View {
        Button(action: {
            action?()
        }, label: {
            HStack {
                if !icon.isEmpty {
                    Image(icon)
                        .renderingMode(.template)
                        .colorMultiply(.main)
                }
                Text(text)
                    .font(.customFont(size: size.rawValue))
                    .fontWeight(weight)
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
            }
            .foregroundColor(isProfileDeleteView ? (!isDisable ? textColor : .main) : (!isDisable ? textColor : .commonText))
            .frame(height: height)
            .frame(maxWidth: width)
            .background(
                RoundedRectangle(cornerRadius: height/2)
                .inset(by: 0.5)
                .stroke(borderColor, lineWidth: 1)
            )
            .background(!isDisable ? backgroundColor : disableColor)
            .cornerRadius((cornerRadius == nil ? height/2 : cornerRadius) ?? 0)
        })
        .disabled(isDisable)
    }
}
