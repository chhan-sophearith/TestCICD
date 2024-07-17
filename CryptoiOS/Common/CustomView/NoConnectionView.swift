//
//  NoConnectionView.swift
//  InfoWebiOS
//
//  Created by lyborey on 27/12/23.
//

import UIKit
import SwiftUI

public class NoConnectionView {

    static let shared = NoConnectionView()
    @AppStorage("isDarkMode") private var isDarkMode = UserPreference.shared.getIsDarkMode()
    private let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.commonBackground
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
        imageView.tintColor = .commonText
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
    
    private let button: UIButton = {
        let button = UIButton()
        button.backgroundColor = .gray
        button.sizeToFit()
        button.layer.cornerRadius = 5
        return button
    }()
    
    @objc func onTapTryAgain() {
        UIView.animate(withDuration: 0.1, animations: {
                    self.button.backgroundColor = UIColor.white // Set the splash color
                }, completion: { (_: Bool) in
                    // Change it back to the original color after the animation completes
                    UIView.animate(withDuration: 0.1) {
                        self.button.backgroundColor = .gray // Set the original color
                    }
                })
        if Reachability.isConnectedToNetwork() {
            hide()
        }
    }
    
    func show() {
        DispatchQueue.main.async {
            
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                let windows = windowScene.windows
                if let window = windows.first(where: { $0.isKeyWindow }) {
                    window.overrideUserInterfaceStyle = self.isDarkMode ? .dark : .light
                    window.addSubview(self.backgroundView)
                    self.backgroundView.addSubview(self.containerView)
                    
                    self.titleLabel.text = mobileNoInternetConnection.localizable
                    self.button.setTitle(mobileTryAgain.localizable, for: .normal)
                    self.containerView.addSubview(self.titleLabel)
                    
                    self.messageLabel.text = mobilePleaseCheckYourInternetSettings.localizable
                    self.containerView.addSubview(self.messageLabel)
                    
                    if let image = UIImage(named: "no-connection") {
                        self.imageView.image = image
                        self.containerView.addSubview(self.imageView)
                    }
                    
                    self.button.addTarget(self, action: #selector(self.onTapTryAgain), for: .touchUpInside)
                    self.containerView.addSubview(self.button)
                    
                    self.backgroundView.translatesAutoresizingMaskIntoConstraints = false
                    self.containerView.translatesAutoresizingMaskIntoConstraints = false
                    self.imageView.translatesAutoresizingMaskIntoConstraints = false
                    self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
                    self.messageLabel.translatesAutoresizingMaskIntoConstraints = false
                    self.button.translatesAutoresizingMaskIntoConstraints = false
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
                        self.imageView.widthAnchor.constraint(equalToConstant: 70),
                        self.imageView.heightAnchor.constraint(equalToConstant: 70),
                        
                        self.titleLabel.topAnchor.constraint(equalTo: self.imageView.bottomAnchor, constant: 10),
                        self.titleLabel.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: 15),
                        self.titleLabel.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: -15),
                        
                        self.messageLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 5),
                        self.messageLabel.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: 15),
                        self.messageLabel.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: -15),
                        
                        self.button.topAnchor.constraint(equalTo: self.messageLabel.bottomAnchor, constant: 20),
                        self.button.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor, constant: -15),
                        self.button.centerXAnchor.constraint(equalTo: self.containerView.centerXAnchor),
                        self.button.widthAnchor.constraint(equalToConstant: 150),
                        self.button.heightAnchor.constraint(equalToConstant: 45)
                    ])
                }
            }
        }
    }

    func hide() {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.5, animations: {
                self.backgroundView.removeFromSuperview()
            })
        }
    }
}

struct NoConnectionViewSwiftUI: View {
    @AppStorage("isConnect") private var isConnect: Bool = Reachability.isConnectedToNetwork()
    var body: some View {
        if !isConnect {
            VStack(spacing: 10) {
                Image("no-connection")
                    .resizable()
                    .frame(width: 70, height: 70)
                if ConfigurationDataManager.shared.isLanguageKey {
                    TextSwiftUI(title: mobileNoInternetConnection.localizable, size: .medium, color: .commonText, weight: .bold)
                    TextSwiftUI(title: mobilePleaseCheckYourInternetSettings.localizable, color: .commonText)
                    CustomButton(text: mobileTryAgain.localizable, backgroundColor: .main, width: 150, height: 45) {
                        if Reachability.isConnectedToNetwork() {
                            isConnect = true
                        } else {
                            isConnect = false
                        }
                    }
                } else {
                    let lang = UserPreference.shared.getDisplayLanguage()
                    if lang.isEmpty  == false {
                        if lang == "zh_CN" || lang == "zh-Hans" || lang == "zh-Hant-IN" || lang == "zh" {
                            TextSwiftUI(title: "没有网络连接", size: .medium, color: .commonText, weight: .bold)
                            TextSwiftUI(title: "请检查您的互联网设置", color: .commonText)
                            CustomButton(text: "再试一次", backgroundColor: .main, width: 150, height: 45) {
                                if Reachability.isConnectedToNetwork() {
                                    isConnect = true
                                } else {
                                    isConnect = false
                                }
                            }
                        } else if lang == "km" || lang == "km-KH" {
                            TextSwiftUI(title: "គ្មានការភ្ជាប់អ៊ីនធឺណិត", size: .medium, color: .commonText, weight: .bold)
                            TextSwiftUI(title: "សូមពិនិត្យមើលការកំណត់អ៊ីនធឺណិតរបស់អ្នក", color: .commonText)
                            CustomButton(text: "ព្យាយាមម្តងទៀត", backgroundColor: .main, width: 150, height: 45) {
                                if Reachability.isConnectedToNetwork() {
                                    isConnect = true
                                } else {
                                    isConnect = false
                                }
                            }
                        } else {
                            TextSwiftUI(title: "No Internet Connection", size: .medium, color: .commonText, weight: .bold)
                            TextSwiftUI(title: "Please check your internet settings", color: .commonText)
                            CustomButton(text: "Try again", backgroundColor: .main, width: 150, height: 45) {
                                if Reachability.isConnectedToNetwork() {
                                    isConnect = true
                                } else {
                                    isConnect = false
                                }
                            }
                        }
                    }
                }
            }.background(Color.commonBackground)
        }
    }
}
