//
//  View+Ex.swift
//  InfoWebiOS
//
//  Created by lyborey on 29/11/23.
//

import SwiftUI
import Shimmer

extension View {
    func appShimmer() -> some View {
        self.redacted(reason: .placeholder)
            .shimmering(
                gradient: Gradient(
                    colors: [.black.opacity(0.3), // translucent
                             .black.opacity(0.8),
                             .black.opacity(0.3)
                    ]
                )
            )
    }
    
    func hideListRowSeparator() -> some View {
        if #available(iOS 15, *) {
            return AnyView(self.listRowSeparator(.hidden))
        } else {
            return AnyView(self.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                .listRowInsets(EdgeInsets(top: -1, leading: -1, bottom: -1, trailing: -1))
                .background(Color(.systemBackground)))
        }
    }
    
    func roundedCorner(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners) )
    }
    
    func border(width: CGFloat, edges: [Edge], color: Color) -> some View {
        overlay(EdgeBorder(width: width, edges: edges).foregroundColor(color))
    }
}

extension UIViewController {
    class func topMostViewController() -> UIViewController? {
        
        // In iOS 13.0 and later,
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            let windows = windowScene.windows
            // Access windows specific to the scene
            if let keyWindow = windows.first(where: { $0.isKeyWindow }) {
                var topController = keyWindow.rootViewController
                while let presentedViewController = topController?.presentedViewController {
                    topController = presentedViewController
                }
                return topController
            }
        }
        return nil
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

struct EdgeBorder: Shape {
    var width: CGFloat
    var edges: [Edge]

    func path(in rect: CGRect) -> Path {
        edges.map { edge -> Path in
            switch edge {
            case .top: return Path(.init(x: rect.minX, y: rect.minY, width: rect.width, height: width))
            case .bottom: return Path(.init(x: rect.minX, y: rect.maxY - width, width: rect.width, height: width))
            case .leading: return Path(.init(x: rect.minX, y: rect.minY, width: width, height: rect.height))
            case .trailing: return Path(.init(x: rect.maxX - width, y: rect.minY, width: width, height: rect.height))
            }
        }.reduce(into: Path()) { $0.addPath($1) }
    }
}
