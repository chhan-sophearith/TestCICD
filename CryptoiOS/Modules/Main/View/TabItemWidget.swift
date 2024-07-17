//
//  TabItemWidget.swift
//  InfoWebiOS
//
//  Created by lyborey on 27/12/23.
//

import SwiftUI

struct TabItemWidget: View {
    var icon, activeIcon: ImageResource
    var title: String
    var isSelected: Bool
    var action: () -> Void

    var body: some View {
        
        Button {
            action()
        } label: {
            VStack {
                Image(isSelected ? activeIcon : icon)
                    .resizable()
                    .frame(width: 24, height: 24)
                Text(title)
                    .font(.system(size: 12))
                    .foregroundStyle(isSelected ? Color.mainTabActive : Color.mainTabColor)
            }
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
        }
    }
}

struct TabItemModel {
    let icon, activeIcon: ImageResource
    let title: String
}
