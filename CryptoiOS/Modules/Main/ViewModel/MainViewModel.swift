//
//  MainViewModel.swift
//  CryptoiOS
//
//  Created by lyborey on 10/7/24.
//

import Foundation

class MainViewModel: ObservableObject {
    @Published var selectedTab = 0
    
    let mainTabList: [TabItemModel] = [
        .init(icon: .home, activeIcon: .homeActive, title: "Home"),
        .init(icon: .coin, activeIcon: .coinActive, title: "Coins"),
        .init(icon: .options, activeIcon: .optionsActive, title: "Options"),
        .init(icon: .contract, activeIcon: .contractActive, title: "Contract"),
        .init(icon: .assets, activeIcon: .assetsActive, title: "Assets")
    ]
}
