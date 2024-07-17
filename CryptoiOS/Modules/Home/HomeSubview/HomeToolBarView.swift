//
//  HomeToolBarView.swift
//  CryptoiOS
//
//  Created by lyborey on 15/7/24.
//

import SwiftUI

struct HomeToolBarView: View {
    var body: some View {
        HStack(spacing: 15) {
            NavigationLink {
                SideMenuView()
            } label: {
                Image(.menuIc)
            }
            
            Spacer()
            NavigationLink {
                
            } label: {
                Image(.notificationIc)
            }
            Image(.navBGImg)
                .resizable()
                .frame(width: 24, height: 24)
                .clipShape(.circle)
                .background(
                    Circle()
                        .stroke(Color.white, lineWidth: 1)
                )
        }
        .overlay {
            Text("Welcome to KK Forex")
                .font(.customFont(size: 14, weight: .bold))
                .foregroundColor(Color.white)
        }
        .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
        .frame(height: 45)
    }
}

#Preview {
    HomeToolBarView()
}
