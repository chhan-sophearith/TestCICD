//
//  ConfigurationDataManager.swift
//  CryptoiOS
//
//  Created by Jatin's iMac on 01/07/24.
//

import Foundation

class ConfigurationDataManager {
    static let shared = ConfigurationDataManager()
    var appInfo: AppInfo?
    var selectedLanguageCode: String?
    var langKey: [String: String]?
    var cachelanguageSource = "local"
    var isLanguageKey: Bool = false
}
