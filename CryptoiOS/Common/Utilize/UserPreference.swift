//
//  UserPreference.swift
//  InfoWebiOS
//
//  Created by Brilliant Dev on 26/4/24.
//

import Foundation
import SwiftUI
class UserPreference {
    
    static let shared = UserPreference()
    private let selectedLanguageCode = "languageCode"
    private let selectedLanguageName = "languageNameKey"
    private let selectedLanguageId = "languageId"
    private let setUserData = "setUserData"
    private let setToken = "setToken"
    private let isDarkMode = "isDarkMode"
    private let languageSource = "mobileFullSource"
    private let forceUpdateDate = "forceUpdateDate"
    private let saveEmailOrPhone = "saveEmailOrPhone"
    private let countryCode = "countryCode"
    @AppStorage("isLogin") private var isLogin: String = ""
    
    private var defaults: UserDefaults {
        UserDefaults.standard
    }
    
    func setLanguage(code language: String, name: String, id: String, iconUrl: String) {
        defaults.set(language, forKey: selectedLanguageCode)
        defaults.set(name, forKey: selectedLanguageName)
        defaults.set(id, forKey: selectedLanguageId)
        defaults.synchronize()
    }
    
    func getLanguageCode() -> String {
        guard let languageCode = defaults.object(forKey: selectedLanguageCode) as? String else {
            return ""
        }
        return languageCode
    }
    
    func getLanguangeName() -> String {
        guard let languageName = defaults.object(forKey: selectedLanguageName) as? String else {
            return ""
        }
        return languageName
    }
    
    func getLanguangeId() -> String {
        guard let languageId = defaults.object(forKey: selectedLanguageId) as? String else {
            return ""
        }
        return languageId
    }
    
//    func setUserData(userData: AuthSuccessModel?) {
//        if let encodedData = try? JSONEncoder().encode(userData) {
//            defaults.set(encodedData, forKey: setUserData)
//            defaults.synchronize()
//        }
//    }
//    
//    func getUserData() -> AuthSuccessModel? {
//        if let data = defaults.object(forKey: setUserData) {
//            if let decodedItems = try? JSONDecoder().decode(AuthSuccessModel.self, from: data as? Data ?? Data()) {
//                return decodedItems
//            }
//        }
//        return nil
//    }
    
    func setToken(token: String) {
        defaults.set(token, forKey: setToken)
        defaults.synchronize()
    }
    
    func getToken() -> String {
        guard let token = defaults.object(forKey: setToken) as? String else {
            return ""
        }
        return token
    }
    
    func setLanguageSource(sourceData: String) {
        defaults.set(sourceData, forKey: languageSource)
    }
    
    func getIsDarkMode() -> Bool {
        guard let isDarkMode = defaults.object(forKey: isDarkMode) as? Bool else {
            if UIScreen.main.traitCollection.userInterfaceStyle == .dark {
                self.setIsDarkMode(set: true)
                return true
            } else {
                self.setIsDarkMode(set: false)
                return false
            }
        }
        return isDarkMode
    }
    
    func setIsDarkMode(set: Bool) {
        defaults.set(set, forKey: isDarkMode)
    }
    
    func getLanguageSource() -> String {
        guard let languageSource = defaults.object(forKey: languageSource) as? String else {
            return self.getSystemLanguage()
        }
        return languageSource
    }
    
    func resetDataOnLogout() {
        isLogin = ""
        defaults.removeObject(forKey: setToken)
        defaults.removeObject(forKey: setUserData)
        defaults.synchronize()
    }
    
    func getDisplayLanguage() -> String {
        guard let languageCode = defaults.object(forKey: selectedLanguageCode) as? String else {
            return getSystemLanguage()
        }
        return languageCode
    }
    
    func getSystemLanguage() -> String {
        let preferredLanguage = Locale.preferredLanguages.first
        let components = Locale.components(fromIdentifier: preferredLanguage ?? "")
        return components[NSLocale.Key.languageCode.rawValue] ?? ""
    }
    
    func setForceUpdate(date: Date) {
        defaults.set(date, forKey: forceUpdateDate)
        defaults.synchronize()
    }
    
    func getForceUpdateDate() -> Date? {
        guard let date = defaults.object(forKey: forceUpdateDate) as? Date else {
            return nil
        }
        return date
    }
    
    func saveEmailOrPhone(value: String) {
        defaults.set(value, forKey: saveEmailOrPhone)
        defaults.synchronize()
    }
    
    func getEmailOrPhone() -> String {
        guard let emailOrPhone = defaults.object(forKey: saveEmailOrPhone) as? String else {
            return ""
        }
        return emailOrPhone
    }
    
    func saveCountryCode(value: String) {
        defaults.set(value, forKey: countryCode)
        defaults.synchronize()
    }
    
//    func getCountryCode() -> String {
//        guard let countryCode = defaults.object(forKey: countryCode) as? String else {
//            if let idd = ConfigurationDataManager.shared.mainData?.countries, !idd.isEmpty, let id = idd[0].idd {
//                return id
//            } else {
//                return ""
//            }
//        }
//        return countryCode
    }
