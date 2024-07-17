//
//  SideMenuView.swift
//  CryptoiOS
//
//  Created by lyborey on 12/7/24.
//

import SwiftUI

struct SideMenuView: View {
    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 15) {
                CustomNavigation(title: "Profile", isBGImg: false, background: Color.clear)
                ZStack {
                    Rectangle()
                        .fill(Color.clear)
                        .frame(height: 70)
                        .background(TransparentBlurView(removeFilter: true)
                            .blur(radius: 9, opaque: true)
                            .background(Color.white.opacity(0.3)))
                        .clipped()
                        .background(
                            RoundedRectangle(cornerRadius: 0, style: .continuous)
                                .stroke(.white.opacity(0.5), lineWidth: 2)
                        )
                        .padding(.leading, 30)
                    HStack {
                        ZStack {
                            Circle()
                                .fill(Color.clear)
                                .background(TransparentBlurView(removeFilter: true)
                                    .blur(radius: 9, opaque: true)
                                    .background(Color.white.opacity(0.3)))
                                .cornerRadius(50)
                                .background(
                                    Circle()
                                        .stroke(.white.opacity(0.5), lineWidth: 2)
                                )
                            Image(.navBGImg)
                                .resizable()
                                .frame(width: 80, height: 80)
                                .scaledToFill()
                                .cornerRadius(50)
                        }
                        .frame(width: 85, height: 85)
                        VStack(alignment: .leading, spacing: 10) {
                            Text("User 168")
                                .font(.customFont(size: 14, weight: .bold))
                                .foregroundColor(Color.white)
                                .lineLimit(1)
                            Text("ID : 60078")
                                .font(.customFont(size: 12))
                                .foregroundColor(Color.white)
                                .lineLimit(1)
                        }
                        Spacer()
                        Button {
                            
                        } label: {
                            Image(.editIc)
                                .padding(8)
                                .background(TransparentBlurView(removeFilter: true)
                                    .blur(radius: 9, opaque: true)
                                    .background(Color.white.opacity(0.3)))
                                .clipShape(.circle)
                                .background(
                                    Circle().stroke(.white.opacity(0.5), lineWidth: 2)
                                )
                                .frame(width: 36, height: 36)
                        }
                        .buttonStyle(PlainButtonStyle())
                        .padding(.trailing, 16)
                    }
                }
                .padding(.leading, 16)
                
                /// The 3 Quick for navigation
                HStack {
                    Spacer()
                    SideMenuQuickButton(title: "Recharge", icon: .rechargeIc)
                    Spacer()
                    SideMenuQuickButton(title: "Withdrawal", icon: .withdrawalIc)
                    Spacer()
                    SideMenuQuickButton(title: "College", icon: .collegeIc)
                    Spacer()
                }
            }
            .padding(.bottom, 30)
            .frame(height: 250)
            .background(
                Image(.commonBgImg)
                    .resizable()
                    .ignoresSafeArea()
            )
            
            ScrollView(showsIndicators: false) {
                /// The 7 Panel for navigation
                VStack(spacing: 10) {
                    SideMenuPanel(title: "My Commission", icon: .myCommisson, destination: EmptyView())
                    SideMenuPanel(title: "Credit Center", icon: .creditCenter, destination: EmptyView())
                    SideMenuPanel(title: "Identity Authentication", icon: .idAuthentication, destination: EmptyView())
                    SideMenuPanel(title: "Security Center", icon: .securityCenter, destination: EmptyView())
                    SideMenuPanel(title: "Message Notification", icon: .messageNotification, destination: EmptyView())
                    SideMenuPanel(title: "Settings", icon: .settingsCenter, destination: AccountSettingsView())
                    SideMenuPanel(title: "Engish", icon: .languageCenter, isDropDown: true, destination: EmptyView())
                }
                .padding(16)
            }
        }
        .background(Color.commonGradientBg)
    }
}

#Preview {
    SideMenuView()
}
