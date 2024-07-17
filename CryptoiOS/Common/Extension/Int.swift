//
//  Int.swift
//  InfoWebiOS
//
//  Created by lyborey on 30/11/23.
//

import Foundation

extension Int {
    func timeFormatted() -> String {
        let seconds: Int = self % 60
        let minutes: Int = (self / 60) % 60
        return String(format: "%2d:%02d", minutes, seconds)
    }
}
