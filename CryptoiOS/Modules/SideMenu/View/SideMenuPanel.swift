//
//  SideMenuPanel.swift
//  CryptoiOS
//
//  Created by lyborey on 12/7/24.
//

import SwiftUI

struct SideMenuPanel<Content: View>: View {
    var title: String
    var icon: ImageResource
    var isDropDown: Bool = false
    var destination: Content
    var body: some View {
        NavigationLink {
            destination
        } label: {
            VStack(spacing: 10) {
                HStack(spacing: 12) {
                    Image(icon)
                        .resizable()
                        .frame(width: 40, height: 40)
                    Text(title)
                        .font(.customFont(size: 12))
                        .foregroundColor(Color.commonText)
                    if isDropDown {
                        Image(.triangleDown)
                    }                        
                    Spacer()
                }
                Image(.linearDivider)
                    .resizable()
                    .frame(maxWidth: .infinity)
                    .frame(height: 1)
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}
