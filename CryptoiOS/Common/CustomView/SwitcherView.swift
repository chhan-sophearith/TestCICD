//
//  SwitcherView.swift
//  CryptoiOS
//
//  Created by lyborey on 16/7/24.
//

import SwiftUI

struct SwitcherView: View {
    @Binding var isOn: Bool
    var body: some View {
//        Toggle("", isOn: $isOn)
//            .fixedSize()
//            .scaleEffect(0.7)
//            .offset(x: 5)
//            .tint(Color.mainTabActive1)
         let switchThumpOff = LinearGradient(
            stops: [Gradient.Stop(color: Color.switchThumbOff, location: 0)],
            startPoint: UnitPoint(x: 0, y: 0),
            endPoint: UnitPoint(x: 1, y: 1)
        )
        ZStack {
            Capsule()
                .fill(Color.switchBg)
            HStack {
                if !isOn {
                    Spacer()
                }
                Circle()
                    .fill(!isOn ? Color.commonButtonBg : switchThumpOff)
                if isOn {
                    Spacer()
                }
            }
            .padding(2)
        }
        .frame(width: 40, height: 22)
    }
}
