//
//  ActivityIndicator.swift
//  InfoWebiOS
//
//  Created by Chhan Sophearith on 29/11/23.
//

import SwiftUI
import UIKit

public class LoadingView {

    static let shared = LoadingView()
    @AppStorage("isDarkMode") private var isDarkMode = UserPreference.shared.getIsDarkMode()
    
    private var counter = 0
    
    private let boxView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        return view
    }()

    private let activityIndicator: UIActivityIndicatorView = {
        let act = UIActivityIndicatorView()
        act.style = .large
        act.backgroundColor = UIColor.cardBackground
        act.color = .commonText
        act.layer.cornerRadius = 10
        act.layer.shadowColor = UIColor.black.cgColor
        act.layer.shadowRadius = 5
        act.layer.shadowOffset = CGSize(width: 0, height: 1)
        act.layer.shadowOpacity = 0.3
        return act
    }()

    func show() {
        let semaphore = DispatchSemaphore(value: 0)
        DispatchQueue.global().async {
                self.counter += 1
                DispatchQueue.main.async {
                    if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                        let windows = windowScene.windows
                        // Access windows specific to the scene
                        if let window = windows.first(where: { $0.isKeyWindow }) {
                            window.overrideUserInterfaceStyle = self.isDarkMode ? .dark : .light
                            self.boxView.translatesAutoresizingMaskIntoConstraints = false
                            self.activityIndicator.translatesAutoresizingMaskIntoConstraints = false
                            let isTopPresented = TopViewControllerChecker.isTopViewControllerPresented()
                            if isTopPresented {
                                window.addSubview(self.boxView)
                            } else {
                                window.insertSubview(self.boxView, at: 1)
                            }
                            
                            self.boxView.addSubview(self.activityIndicator)
                            NSLayoutConstraint.activate([
                                self.boxView.topAnchor.constraint(equalTo: window.topAnchor),
                                self.boxView.rightAnchor.constraint(equalTo: window.rightAnchor),
                                self.boxView.leftAnchor.constraint(equalTo: window.leftAnchor),
                                self.boxView.bottomAnchor.constraint(equalTo: window.bottomAnchor),
                                self.activityIndicator.heightAnchor.constraint(equalToConstant: 70),
                                self.activityIndicator.widthAnchor.constraint(equalToConstant: 70),
                                self.activityIndicator.centerYAnchor.constraint(equalTo: self.boxView.centerYAnchor),
                                self.activityIndicator.centerXAnchor.constraint(equalTo: self.boxView.centerXAnchor)
                            ])
                            self.activityIndicator.startAnimating()
                        }
                    }
                }
            
            semaphore.signal()
        }
        semaphore.wait()
    }

    func hide() {
        let semaphore = DispatchSemaphore(value: 0)
        DispatchQueue.global().async {
            self.counter -= 1
            if self.counter <= 0 {
                self.counter = 0
                DispatchQueue.main.async {
                    UIView.animate(withDuration: 0.5, animations: {
                        self.activityIndicator.stopAnimating()
                        self.activityIndicator.removeFromSuperview()
                        self.boxView.removeFromSuperview()
                    })
                }
            }
            semaphore.signal()
        }
        semaphore.wait()
    }
}

struct TopViewControllerChecker {
    static func isTopViewControllerPresented() -> Bool {
        
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return false
        }
        
        guard let window = windowScene.windows.first(where: { $0.isKeyWindow }) else {
            return false
        }
              
        guard let topViewController = window.rootViewController else {
            return false
        }
        
        var topPresentedViewController = topViewController
        
        while let presentedViewController = topPresentedViewController.presentedViewController {
            
            if presentedViewController is UIAlertController {
                return false
            }
            
            topPresentedViewController = presentedViewController
            return true
        }
        
        return topPresentedViewController.presentedViewController != nil
    }
}
