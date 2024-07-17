//
//  CustomDivederView.swift
//  InfoWebiOS
//
//  Created by Bhadresh on 04/01/24.
//

import SwiftUI

struct CustomDividerView: View {
    @State var backgroundColor: Color = .gray
    @State var height: CGFloat = 1
    @State var topPadding: CGFloat = 4
    @State var bottomPadding: CGFloat = 4
    var body: some View {
        VStack {
            Divider()
                .frame(height: height)
                .background(backgroundColor)
                .padding(.top, topPadding)
                .padding(.bottom, bottomPadding)
                .zIndex(-1)
        }
    }
}

#Preview {
    CustomDividerView()
}
