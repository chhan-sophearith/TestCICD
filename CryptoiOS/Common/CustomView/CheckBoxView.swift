//
//  CheckBoxView.swift
//  InfoWebiOS
//
//  Created by Chhan Sophearith on 25/12/23.
//

import SwiftUI

struct CheckBoxView: View {
    var update = false
    var isSelected = false
    var borderColor: Color = .main
    var body: some View {
        VStack {
            if isSelected {
                ZStack {
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 25, height: 25)
                        .cornerRadius(4)
                        .overlay(
                            RoundedRectangle(cornerRadius: 4)
                                .inset(by: 0.5)
                                .stroke(borderColor, lineWidth: 1)
                        )
                    Image("ticked")
                        .renderingMode(.template)
                        .foregroundColor(borderColor)
                        .frame(width: 15, height: 15)
                }
            } else {
                VStack {
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 25, height: 25)
                        .cornerRadius(4)
                        .overlay(
                            RoundedRectangle(cornerRadius: 4)
                                .inset(by: 0.5)
                                .stroke(borderColor, lineWidth: 1)
                        )
                }
            }
        }
    }
}
