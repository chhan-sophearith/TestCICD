//
//  MainView.swift
//  CryptoiOS
//
//  Created by lyborey on 9/7/24.
//

import SwiftUI

struct MainView: View {
    @StateObject private var mainVM = MainViewModel()

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                /// Each View of  the 5 Module
                switch mainVM.selectedTab {
                case 1:
                    EmptyView() // replace it with Module View
                case 2:
                    EmptyView() // replace it with Module View
                case 3:
                    EmptyView() // replace it with Module View
                case 4:
                    EmptyView() // replace it with Module View
                default:
                    HomeView()
                }
                Spacer(minLength: 0)
                
                /// The 5 Tabbar Item
                HStack {
                    ForEach(0..<mainVM.mainTabList.count, id: \.self) { index in
                        TabItemWidget(
                            icon: mainVM.mainTabList[index].icon,
                            activeIcon: mainVM.mainTabList[index].activeIcon,
                            title: mainVM.mainTabList[index].title,
                            isSelected: mainVM.selectedTab == index) {
                                mainVM.selectedTab = index
                            }
                    }
                }
                .frame(height: 53)
                .background(Color.mainTabBG)
                .shadow(color: Color.black.opacity(0.2), radius: 4, x: 0, y: -1)
            }
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .navigationBarBackButtonHidden()
        .navigationViewStyle(StackNavigationViewStyle())
        .onAppear {

        }
    }
        
}
