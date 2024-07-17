//
//  ShowDataView.swift
//  InfoWebiOS
//
//  Created by lyborey on 27/12/23.
//

import SwiftUI

struct ShowDataView<Content: View>: View {
    // I assign value outside because when it is the fisrt screen show, the localize are not change unless when switch the screen.
    var title: String?
    var isEmpty: Bool
    @ViewBuilder var content: () -> Content
    var body: some View {
        if isEmpty {
            VStack(spacing: 10) {
                Spacer()
                Image(.noData)
                    .resizable()
                    .frame(width: 100, height: 70)
                TextSwiftUI(title: title ?? mobileNoData.localizable, size: .medium)
                Spacer()
            }
            .frame(maxWidth: .infinity)
        } else {
            content()
        }
    }
}
