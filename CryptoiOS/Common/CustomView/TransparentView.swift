//
//  TransparentView.swift
//  InfoWebiOS
//
//  Created by lyborey on 11/1/24.
//

import SwiftUI

struct TransparentBlurView: UIViewRepresentable {
    var removeFilter: Bool = false
    func makeUIView(context: Context) -> some UIView {
        return TransparentBlurViewHelper(removeAllFilter: removeFilter)
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}

class TransparentBlurViewHelper: UIVisualEffectView {
    init(removeAllFilter: Bool) {
        super.init(effect: UIBlurEffect(style: .systemUltraThinMaterial))
        
        if subviews.indices.contains(1) {
            subviews[1].alpha = 0
        }
        
        if let backdrop = layer.sublayers?.first {
            if removeAllFilter {
                backdrop.filters = []
            } else {
                backdrop.filters?.removeAll(where: { filter in
                    String(describing: filter) != "gaussianBlur"
                })
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init Coder not work")
    }
    
}
