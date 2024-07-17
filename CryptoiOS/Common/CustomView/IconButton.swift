//
//  IconButton.swift
//  CryptoiOS
//
//  Created by lyborey on 16/7/24.
//

import SwiftUI

struct IconButton: View {
    var icon: ImageResource
    var title: String
    var isHorizontal: Bool = true
    var iconFrame: CGSize = CGSize(width: 16, height: 14)
    var textSize: CGFloat = 12
    var textColor: Color = Color.white
    var onTap: () -> Void
    var body: some View {
        Button {
            onTap()
        } label: {
            if isHorizontal {
                HStack {
                    Image(icon)
                        .resizable()
                        .frame(width: iconFrame.width, height: iconFrame.height)
                    Text(title)
                        .font(.customFont(size: textSize))
                        .foregroundColor(textColor)
                        .lineLimit(1)
                }
            } else {
                VStack(spacing: 10) {
                    Image(icon)
                        .resizable()
                        .frame(width: iconFrame.width, height: iconFrame.height)
                    Text(title)
                        .font(.customFont(size: 12))
                        .foregroundColor(textColor)
                        .lineLimit(1)
                }
            }
        }
    }
}
