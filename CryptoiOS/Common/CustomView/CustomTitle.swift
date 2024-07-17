//
//  CustomTitle.swift
//  InfoWebiOS
//
//  Created by lyborey on 30/11/23.
//

import SwiftUI

struct CustomTitle: View {
    var title: String
    var topPadding: CGFloat = 30
    var bottomPadding: CGFloat = 30
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(title)
                .font(.customFont(size: 23))
                .foregroundColor(.commonText)
//            Image(.divider)
        }.padding(EdgeInsets(top: topPadding, leading: 0, bottom: bottomPadding, trailing: 0))
    }
}
