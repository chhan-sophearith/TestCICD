//
//  HomeView.swift
//  CryptoiOS
//
//  Created by lyborey on 13/7/24.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var viewModel = HomeViewModel()
    
    var body: some View {
        ZStack {
            VStack {
                Image(.commonBgImg)
                    .resizable()
                    .ignoresSafeArea()
                    .frame(height: 220)
                Spacer()
            }
            .background(Color.commonGradientBg)
            VStack {
                HomeToolBarView()
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 15) {
                        HomeAssetBTCView()
                        HStack {
                            IconButton(icon: .homeOptionIc,
                                       title: "Options",
                                       isHorizontal: false,
                                       iconFrame: .init(width: 50, height: 50),
                                       textColor: Color.commonText) {
                                
                            }
                            Spacer()
                            IconButton(icon: .homeServiceIc,
                                       title: "Service",
                                       isHorizontal: false,
                                       iconFrame: .init(width: 50, height: 50),
                                       textColor: Color.commonText) {
                                
                            }
                            Spacer()
                            IconButton(icon: .homeSubIC,
                                       title: "Subscription",
                                       isHorizontal: false,
                                       iconFrame: .init(width: 50, height: 50),
                                       textColor: Color.commonText) {
                                
                            }
                            Spacer()
                            IconButton(icon: .homeMiningIc,
                                       title: "Mining",
                                       isHorizontal: false,
                                       iconFrame: .init(width: 50, height: 50),
                                       textColor: Color.commonText) {
                                
                            }
                        }
                        Color.homeDivider.frame(height: 1)
                        
                    }
                    .padding(16)
                }
            }
        }
        .onAppear {
//            viewModel.testingApi()
        }
    }
}
