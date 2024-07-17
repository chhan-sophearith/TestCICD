//
//  CustomToast.swift
//  InfoWebiOS
//
//  Created by lyborey on 25/12/23.
//

import SwiftUI
import UIKit

class CustomToast: UIView {
    static let shared = CustomToast()
    @AppStorage("isDarkMode") private var isDarkMode = UserPreference.shared.getIsDarkMode()
    private let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        return view
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.commonBackground
        view.layer.cornerRadius = 10
        return view
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.tintColor = .black
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .commonText
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.textColor = .commonText
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    func show(title: String?, message: String, imageName: String? = "success") {
        DispatchQueue.main.async {
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                let windows = windowScene.windows
                // Access windows specific to the scene
                if let window = windows.first(where: { $0.isKeyWindow }) {
                    window.overrideUserInterfaceStyle = self.isDarkMode ? .dark : .light
                    window.addSubview(self.backgroundView)
                    self.backgroundView.addSubview(self.containerView)
                    
                    self.titleLabel.text = title
                    self.containerView.addSubview(self.titleLabel)
                    
                    self.messageLabel.text = message
                    self.containerView.addSubview(self.messageLabel)
                    
                    if let imageName = imageName, let image = UIImage(named: imageName) {
                        self.imageView.image = image
                        self.containerView.addSubview(self.imageView)
                    }
                    
                    self.backgroundView.translatesAutoresizingMaskIntoConstraints = false
                    self.containerView.translatesAutoresizingMaskIntoConstraints = false
                    self.imageView.translatesAutoresizingMaskIntoConstraints = false
                    self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
                    self.messageLabel.translatesAutoresizingMaskIntoConstraints = false
                    NSLayoutConstraint.activate([
                        self.backgroundView.topAnchor.constraint(equalTo: window.topAnchor),
                        self.backgroundView.rightAnchor.constraint(equalTo: window.rightAnchor),
                        self.backgroundView.leftAnchor.constraint(equalTo: window.leftAnchor),
                        self.backgroundView.bottomAnchor.constraint(equalTo: window.bottomAnchor),
                        
                        self.containerView.centerXAnchor.constraint(equalTo: self.backgroundView.centerXAnchor),
                        self.containerView.centerYAnchor.constraint(equalTo: self.backgroundView.centerYAnchor),
                        self.containerView.widthAnchor.constraint(lessThanOrEqualToConstant: UIScreen.main.bounds.width * 0.9),
                        
                        self.imageView.topAnchor.constraint(equalTo: self.containerView.topAnchor, constant: 15),
                        self.imageView.centerXAnchor.constraint(equalTo: self.containerView.centerXAnchor),
                        self.imageView.widthAnchor.constraint(equalToConstant: 40),
                        self.imageView.heightAnchor.constraint(equalToConstant: 40),
                    
                        self.titleLabel.topAnchor.constraint(equalTo: self.imageView.bottomAnchor, constant: 10),
                        self.titleLabel.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: 15),
                        self.titleLabel.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: -15),
                      
                        self.messageLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 5),
                        self.messageLabel.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: 15),
                        self.messageLabel.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: -15),
                        self.messageLabel.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor, constant: -15)
                    ])
                }
            }
        }
        
        let hideAfterView: Double = 1.2
        UIView.animate(withDuration: hideAfterView, delay: 0,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 0.1,
                       options: .curveEaseIn,
                       animations: { () -> Void in
            self.backgroundView.alpha = 1
        }, completion: { (_: Bool) in
            UIView.animate(withDuration: hideAfterView,
                           delay: 0.5,
                           usingSpringWithDamping: 0.5,
                           initialSpringVelocity: 0.1,
                           options: .curveEaseOut,
                           animations: { () -> Void in
                self.backgroundView.alpha = 0
                self.window?.isUserInteractionEnabled = true
            }, completion: { (_: Bool) in
                self.backgroundView.removeFromSuperview()
            })
        })
    }
}
