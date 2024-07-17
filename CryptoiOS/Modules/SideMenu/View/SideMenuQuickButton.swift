//
//  SideMenuQuickButton.swift
//  CryptoiOS
//
//  Created by lyborey on 12/7/24.
//

import SwiftUI

struct SideMenuQuickButton: View {
    var title: String
    var icon: ImageResource
    var body: some View {
        NavigationLink {
            
        } label: {
            VStack(spacing: 12) {
                Image(icon)
                    .resizable()
                    .frame(width: 50, height: 50)
                Text(title)
                    .font(.customFont(size: 12))
                    .foregroundColor(Color.white)
            }
            .padding(.horizontal, 10)
        }
        .buttonStyle(PlainButtonStyle())
    }
}
