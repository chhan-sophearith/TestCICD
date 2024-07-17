//
//  PanelSettingRow.swift
//  CryptoiOS
//
//  Created by lyborey on 16/7/24.
//

import SwiftUI

struct PanelSettingRow<Content: View>: View {
    var title: String
    var trailing: Content
    var onTap: (() -> Void)?
    
    var body: some View {
        Button {
            onTap?()
        } label: {
            HStack {
                Text(title)
                    .foregroundColor(Color.commonText)
                    .font(.customFont(size: 12))
                Spacer()
                if trailing is EmptyView {
                    Image(.arrowRight)
                } else {
                    trailing
                }
            }
            .padding(15)
            .frame(height: 45)
        }
        .disabled(onTap == nil ? true : false)
    }
}
