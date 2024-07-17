//
//  UISegmentedControl.swift
//  InfoWebiOS
//
//  Created by lyborey on 15/5/24.
//

import SwiftUI

extension UISegmentedControl {
    override open func didMoveToSuperview() {
        super.didMoveToSuperview()
        self.setContentHuggingPriority(.defaultLow, for: .vertical)
    }
}
