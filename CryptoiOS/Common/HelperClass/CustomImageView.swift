//
//  CustomImageView.swift
//  InfoWebiOS
//
//  Created by Bhadresh on 05/01/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct CustomImageView: View {
    
    let imageUrl: String?
    let imageSize: CGSize
    var contentMode: ContentMode = .fit
    var roundedCorner: RoundedCorner?
    var imageColor = Color.commonText
    var cornerRadius: CGFloat = 5
    var renderingMode: Image.TemplateRenderingMode = .original
    @State private var imageLoadingFailed = false
    
    var body: some View {
        if imageLoadingFailed {
            // Show placeholder image if loading fails
            Image(systemName: "photo")
                .resizable()
                .renderingMode(renderingMode)
                .foregroundColor(imageColor)
                .aspectRatio(imageSize.width / imageSize.height, contentMode: contentMode)
                .clipped()
                .cornerRadius(cornerRadius)
        } else {
            let url = URL(string: imageUrl ?? "")
            WebImage(url: url)
                .resizable()
                .onFailure { error in
                    // Handle failure here, you can log error or show a message
                    if let urlLength = url?.absoluteString.count, urlLength > 0 {
                        print("Error loading image: \(error)")
                    }
                    // Set flag to indicate image loading failed
                    self.imageLoadingFailed = true
                }
                .renderingMode(renderingMode)
                .indicator(.activity)
                .foregroundColor(imageColor)
                .aspectRatio(imageSize.width / imageSize.height, contentMode: contentMode)
                .clipped()
                .cornerRadius(cornerRadius)
        }
    }
}
