//
//  Color.swift
//  InfoWebiOS
//
//  Created by Chhan Sophearith on 24/11/23.
//

import Foundation
import UIKit
import SwiftUI

extension Color {
    // MARK: Common Color
    static let commonGradientBg = LinearGradient(
        stops: [
            Gradient.Stop(color: Color.commonBg1, location: 0),
            Gradient.Stop(color: Color.commonBg2, location: 1)
        ],
        startPoint: UnitPoint(x: 0.5, y: 0),
        endPoint: UnitPoint(x: 0.5, y: 1)
    )
    
    static let commonButtonBg = LinearGradient(
        stops: [
            Gradient.Stop(color: Color.commonButtonBg1, location: 0),
            Gradient.Stop(color: Color.commonButtonBg2, location: 1)
        ],
        startPoint: UnitPoint(x: 0, y: 0.5),
        endPoint: UnitPoint(x: 1, y: 0.5)
    )
    
    // MARK: Main Tab Bar
    static let mainTabActive = LinearGradient(
        stops: [
            Gradient.Stop(color: Color.mainTabActive1, location: 0),
            Gradient.Stop(color: Color.mainTabActive2, location: 1)
        ],
        startPoint: UnitPoint(x: 0, y: 0),
        endPoint: UnitPoint(x: 1, y: 1)
    )
    
    static let mainTabColor = LinearGradient(
        stops: [
            Gradient.Stop(color: Color.mainTabGray, location: 0),
            Gradient.Stop(color: Color.mainTabGray, location: 1)
        ],
        startPoint: UnitPoint(x: 0, y: 0),
        endPoint: UnitPoint(x: 1, y: 1)
    )
    
    // MARK: Settings
    static let panelGroupBg = LinearGradient(
        stops: [
            Gradient.Stop(color: Color.panelGroupBg1, location: 0),
            Gradient.Stop(color: Color.panelGroupBg2, location: 1)
        ],
        startPoint: UnitPoint(x: 0, y: 0.5),
        endPoint: UnitPoint(x: 1, y: 0.5)
    )
    
}

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)
        
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        
        self.init(
            red: CGFloat(r) / 0xff,
            green: CGFloat(g) / 0xff,
            blue: CGFloat(b) / 0xff
        )
    }
}

extension UIColor {
    convenience init(hex: String) {
        let scanner = Scanner(string: hex)
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        self.init(
            red: CGFloat(r) / 0xff,
            green: CGFloat(g) / 0xff,
            blue: CGFloat(b) / 0xff, alpha: 1
        )
    }
}
