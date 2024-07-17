//
//  CustomNavigation.swift
//  InfoWebiOS
//
//  Created by lyborey on 29/11/23.
//

import SwiftUI
import SDWebImageSwiftUI

extension View {
    public func customNav(
        title: String = "",
        background: Color? = nil,
        trailingBtnIcon: String = "",
        action: (() -> Void)? = nil,
        actionTrailingIcon: (() -> Void)? = nil
    ) -> some View {
        navigationBarItems(
            leading: CustomNavigation(
                title: title,
                background: background,
                trailingBtnIcon: trailingBtnIcon,
                action: action,
                actionTrailingIcon: actionTrailingIcon
            )
        )
    }
    
    public func customNav(title: String = "", action: (() -> Void)? = nil) -> any View {
        navigationBarItems(leading: CustomNavigation(title: title, action: action))
    }
}

struct CustomNavigation: View {
    var title: String = ""
    var isBGImg: Bool = true
    var background: Color?
    var trailingBtnIcon: String?
    var action: (() -> Void)?
    var actionLogin: (() -> Void)?
    var actionTrailingIcon: (() -> Void)?
    @AppStorage("isLogin") private var isLogin: String = ""
    @AppStorage("language") private var lang: String = UserPreference.shared.getLanguageCode()
    
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 10) {
                
                Button(action: {
                    if action == nil {
                        presentationMode.wrappedValue.dismiss()
                    } else {
                        action?()
                    }
                }, label: {
                    Image(.arrowLeft)
                        .resizable()
                        .foregroundColor(.white)
                        .frame(width: 30, height: 30)
                    
                })
                Spacer(minLength: 0)
                
                if let trailing = trailingBtnIcon {
                    Button {
                        actionTrailingIcon?()
                    } label: {
                        Image(trailing)
                            .imageScale(.large)
                            .foregroundColor(.white)
                            .frame(width: 30, height: 30)
                    }
                }
            }
            .overlay(
                TextSwiftUI(title: title,
                            size: .medium,
                            color: Color.white,
                            weight: .bold, lineLimit: 1)
                .padding(.horizontal, 50)
            )
            .padding(.horizontal, 16)
            .padding(.bottom, isBGImg ? 35 : 0)
            .frame(width: UIScreen.main.bounds.width, height: isBGImg ? 80 : 46)
            .frame(maxWidth: .infinity)
            
            .background(
                Group {
                    if isBGImg {
                        ZStack {
                            Image(.navBGImg)
                                .resizable()
                            
                                .scaledToFill()
                                .ignoresSafeArea()
                                .frame(width: UIScreen.main.bounds.width, height: 80)
                            
                            Image(.rec)
                                .resizable()
                            
                                .scaledToFill()
                                .ignoresSafeArea()
                                .frame(width: UIScreen.main.bounds.width, height: 80)
                        }
                    } else {
                        background
                            .ignoresSafeArea()
                            .frame(width: UIScreen.main.bounds.width)
                    }
                }
            )
        }
        .background(background.ignoresSafeArea())
        .frame(width: UIScreen.main.bounds.width)
        .navigationBarBackButtonHidden(true)
    }
}
