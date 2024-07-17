//
//  AccountSettingsView.swift
//  CryptoiOS
//
//  Created by lyborey on 16/7/24.
//

import SwiftUI

struct AccountSettingsView: View {
    @AppStorage("isDarkMode") private var isDarkMode = UserPreference.shared.getIsDarkMode()

    var body: some View {
        VStack(spacing: 0) {
            CustomNavigation(title: "Account Settings")
            ScrollView(showsIndicators: false) {
                VStack(spacing: 20) {
                    VStack(spacing: 0) {
                        PanelSettingRow(title: "Portrait", trailing: Image(.portraitIc))
                        PanelDividerView()
                        PanelSettingRow(title: "Nickname", trailing: Text("Master Piece")
                            .font(.customFont(size: 12))
                            .foregroundColor(Color.commonText))
                        PanelDividerView()
                        PanelSettingRow(title: "Email", trailing: Text("Hongbad7878@gmail.com")
                            .font(.customFont(size: 12))
                            .tint(Color.commonText))
                    }
                    .background(Color.panelGroupBg)
                    .cornerRadius(10)
                    
                    VStack(spacing: 0) {
                        PanelSettingRow(title: "Mobile Number", trailing: Text("0168168168")
                            .font(.customFont(size: 12))
                            .foregroundColor(Color.commonText))
                    }
                    .background(Color.panelGroupBg)
                    .cornerRadius(10)
                    
                    VStack(spacing: 0) {
                        PanelSettingRow(title: "Swtich Mode", trailing: SwitcherView(isOn: $isDarkMode)) {
                                withAnimation(.linear(duration: 0.5)) {
                                    isDarkMode.toggle()
                                    UserPreference.shared.setIsDarkMode(set: isDarkMode)
                                }
                            }
                        PanelDividerView()
                        PanelSettingRow(title: "Swtich Account", trailing: EmptyView())
                        PanelDividerView()
                        PanelSettingRow(title: "Logout", trailing: EmptyView())
                    }
                    .background(Color.panelGroupBg)
                    .cornerRadius(10)
                }
                .padding(16)
            }
        }
        .background(Color.commonGradientBg)
    }
}
