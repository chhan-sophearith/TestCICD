//
//  HomeAssetBTCView.swift
//  CryptoiOS
//
//  Created by lyborey on 17/7/24.
//

import SwiftUI

struct HomeAssetBTCView: View {
    var body: some View {
        VStack(spacing: 0) {
            HStack(alignment: .bottom) {
                Image(.profileCompletionIc)
                    .resizable()
                    .frame(width: 36, height: 36)
                VStack(alignment: .leading) {
                    Text("Profile completion")
                        .font(.customFont(size: 12))
                        .foregroundColor(Color.white)
                    HStack {
                        Text("10%")
                            .font(.customFont(size: 12))
                            .foregroundColor(Color.homeProgressBar)
                        ProgressView(value: 0.1)
                            .progressViewStyle(.linear)
                            .tint(Color.homeProgressBar)
                            .background(.white)
                            .cornerRadius(10)
                    }
                }
                Spacer(minLength: 20)
                Button {
                    
                } label: {
                    Text("complete")
                        .font(.customFont(size: 10))
                        .foregroundColor(Color.homeCompleteText)
                }
            }
            .padding(15)
            .background(TransparentBlurView(removeFilter: true)
                .blur(radius: 9, opaque: true)
                .background(Color.white.opacity(0.3))
            )
            Color.white.opacity(0.5).frame(height: 1)
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Total assets converted(BTC)")
                    .font(.customFont(size: 12))
                    .foregroundColor(Color.white)
                Text("0.00000000 BTC")
                    .font(.customFont(size: 16, weight: .bold))
                    .foregroundColor(Color.white)
                Text("0.00000000 USD")
                    .font(.customFont(size: 12))
                    .foregroundColor(Color.white)
                HStack {
                    IconButton(icon: .homeRechargeIc, title: "Recharge") {
                        
                    }
                    Spacer()
                    IconButton(icon: .homeWithdrawalIc, title: "Withdrawal") {
                        
                    }
                    Spacer()
                    IconButton(icon: .homeTransferIc, title: "Transfer") {
                        
                    }
                }
                .padding(.vertical, 5)
                HStack {
                    Spacer()
                    Button {
                        
                    } label: {
                        HStack {
                            Image(.contractAccountIc)
                                .resizable()
                                .frame(width: 10, height: 14)
                            Text("Contract account")
                                .font(.customFont(size: 12))
                                .underline()
                                .foregroundColor(Color.homeCompleteText)
                        }
                        .padding(5)
                    }
                    Spacer()
                }
            }
            .padding(EdgeInsets(top: 10, leading: 15, bottom: 5, trailing: 15))
            .background(
                LinearGradient(colors: [Color(hex: "0C1E5E").opacity(0.30), Color(hex: "212D56").opacity(0.15)], startPoint: .top, endPoint: .bottom)
            )
            .background(TransparentBlurView(removeFilter: true)
                .blur(radius: 9, opaque: true)
                .background(Color.white.opacity(0.3))
            )
        }
        .roundedCorner(10, corners: [.allCorners])
        .background(
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .stroke(.white.opacity(0.5), lineWidth: 2)
        )
    }
}
