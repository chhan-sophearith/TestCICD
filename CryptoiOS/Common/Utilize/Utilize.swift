//
//  Utilize.swift
//  InfoWebiOS
//
//  Created by Chhan Sophearith on 24/11/23.
//

import Foundation
import UIKit
import SwiftUI
class Utilize {
    
    static let shared = Utilize()
    @AppStorage("isDarkMode") private var isDarkMode = UserPreference.shared.getIsDarkMode()
    private var isAlertPresented = false
    private var isAlertForceUpdate = false
    
    static func isValidEmail(enteredEmail: String) -> Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: enteredEmail)
    }
    
    static func isValidEmailOrPhone(textfield: String, type: ContactType, showAlert: Bool = false) -> Bool {
        var alertText = ""
        var isValid = true
        if textfield.isEmpty {
            alertText = mobilePleaseEnterEmailOrPhoneNumber.localizable
            isValid = false
        } else if type == .email && !isValidEmail(enteredEmail: textfield) {
            alertText = mobilePleaseEnterValidEmail.localizable
            isValid = false
        } else if type == .phoneNo && (textfield.count < minLimitPhoneNo || textfield.count > maxLimitPhoneNo) {
            alertText = mobilePleaseEnterValidPhoneNumber.localizable
            isValid = false
        }
        if !isValid {
            if showAlert {
                Utilize.shared.showAlert(title: mobileAlert.localizable, message: alertText)
            }
            return false
        }
        return true
    }
    
    static func compareDate(date1: Date, date2: Date) -> Bool {
        let order = NSCalendar.current.compare(date1, to: date2, toGranularity: .day)
        switch order {
        case .orderedSame:
            return true
        default:
            return false
        }
    }
    
    static func getDateStringFormat(_ dateString: String, formate: String = "dd MMMM yyyy hh:mm:ss a") -> String {
        var outputDate: String = ""
        let dateFormatter = DateFormatter()
        let dateFormatter1 = DateFormatter()
        let dateFormatter2 = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter1.dateFormat = "yyyy-MM-dd"
        dateFormatter2.dateFormat = "yyyy-MM-dd HH:mm"
        dateFormatter.locale = Locale(identifier: UserPreference.shared.getLanguageCode())
        if let date = dateFormatter.date(from: dateString) {
            dateFormatter.dateFormat = formate
            dateFormatter.locale = Locale(identifier: UserPreference.shared.getLanguageCode())
            outputDate = dateFormatter.string(from: date)
            return outputDate
        } else if let date = dateFormatter1.date(from: dateString) {
            dateFormatter1.dateFormat = formate
            dateFormatter1.locale = Locale(identifier: UserPreference.shared.getLanguageCode())
            outputDate = dateFormatter1.string(from: date)
            return outputDate
        } else if let date = dateFormatter2.date(from: dateString) {
            dateFormatter2.dateFormat = "dd MMM yyyy, EEE hh:mm a"
            dateFormatter2.locale = Locale(identifier: UserPreference.shared.getLanguageCode())
            outputDate = dateFormatter2.string(from: date)
            return outputDate
        }
        return dateString
    }
    
    static func getDateFormatCurrentZone(_ dateString: String, formate: String = "dd MMMM yyyy hh:mm:ss a") -> String {
        var outputDate: String = ""
        let dateFormatter = DateFormatter()
        
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.locale = Locale(identifier: UserPreference.shared.getLanguageCode())
        if let date = dateFormatter.date(from: dateString) {
            dateFormatter.timeZone = TimeZone.current
            dateFormatter.dateFormat = formate
            outputDate = dateFormatter.string(from: date)
            return outputDate
        }
        return dateString
    }
    
    static func getDatePickerFormat(_ dateString: String, formate: String = "yyyy-MM-dd") -> String {
        var outputDate: String = ""
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
        if let date = dateFormatter.date(from: dateString) {
            dateFormatter.dateFormat = formate
            outputDate = dateFormatter.string(from: date)
            return outputDate
        }
        return dateString
    }
    
    static func compareDates(dateA: Date, dateB: Date) -> DateOrder {
        let order = Calendar.current.compare(dateA, to: dateB, toGranularity: .day)
        switch order {
        case .orderedDescending:
            debugPrint("DESCENDING")
            return DateOrder.lessThan
        case .orderedAscending:
            debugPrint("ASCENDING")
            return DateOrder.greaterThan
        case .orderedSame:
            debugPrint("SAME")
            return  DateOrder.same
        }
    }
    
    static func getStringToDate(_ dateString: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        return dateFormatter.date(from: dateString) ?? Date()
    }
    
    static func getDateToString(_ date: Date, formate: String = "yyyy-MM-dd") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formate
        dateFormatter.locale = Locale(identifier: UserPreference.shared.getLanguageCode())
        let dateStr = dateFormatter.string(from: date)
        return dateStr
    }
    
    func debugerResult(urlRequest: URLRequest, data: Data?, error: Bool) {
        #if DEBUG
        let url = urlRequest.url!
        let strurl = url.absoluteString
        let allHeaders =  urlRequest.allHTTPHeaderFields ?? [:]
        let body = urlRequest.httpBody.flatMap { String(decoding: $0, as: UTF8.self) }
        let result = """
              ⚡️⚡️⚡️⚡️ Headers: \(String(describing: allHeaders))
              ⚡️⚡️⚡️⚡️ Request Body: \(String(describing: body ?? nil))
        """
        print(result)
        
        let newData = data ?? Data()
        if url.absoluteString.contains("mobileFullSource") {
            if let strJson = String(data: newData, encoding: .utf8) {
                UserPreference.shared.setLanguageSource(sourceData: strJson)
            }
        }
               
        do {
            guard let json = try JSONSerialization.jsonObject(with: newData, options: []) as? [String: AnyObject] else {
                if let arrayObject = try JSONSerialization.jsonObject(with: newData, options: []) as? [AnyObject] {
                    self.formatArrayAnyObject(json: arrayObject, url: strurl, error: error)
                }
                return
            }
            self.formatDictionay(json: json, url: strurl, error: error)
        } catch {}
        #endif
    }
    
    private func printerFormat(url: String, data: String, error: Bool) {
        let printer = """
        URL -->: \(url)
        Response Received -->: \(data)
        """
        
        if error {
            print("❌❌❌❌ \(printer) ❌❌❌❌")
        } else {
            print("✅✅✅✅ \(printer) ✅✅✅✅")
        }
    }
    
    private func formatArrayAnyObject(json: [AnyObject], url: String, error: Bool) {
        guard let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted) else { return }
        let data = "\(NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue) ?? NSString())"
        self.printerFormat(url: url, data: data, error: error)
    }
    
    private func formatDictionay(json: [String: AnyObject], url: String, error: Bool) {
        guard let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted) else { return }
        let data = "\(NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue) ?? NSString())"
        self.printerFormat(url: url, data: data, error: error)
    }
    
    func validateModel<T: Codable>(model: T.Type, data: Data?, url: String? = "", response: (T) -> Void) {
        do {
            if let newData = data {
                let json = try JSONDecoder().decode(T.self, from: newData)
                response(json)
            }
        } catch let DecodingError.typeMismatch(type, context) {
            print(type)
            let endPoint = "⚡️URL -->: " + (url ?? "") + "⚡️"
            self.validateShowMessage(message: context.showError(functionName: endPoint))
        } catch let error {
            self.validateShowMessage(message: error.localizedDescription)
        }
    }
    
    private func validateShowMessage(message: String) {
        #if Dev
        print("Error", message)
        self.showAlert(title: mobileError.localizable, message: message)
        #elseif SIT
        print("Error", message)
        self.showAlert(title: mobileError.localizable, message: mobileSomethingWentWrong.localizable)
        #elseif UAT
        print("Error", message)
        self.showAlert(title: mobileError.localizable, message: mobileSomethingWentWrong.localizable)
        #else
        self.showAlert(title: mobileError.localizable, message: mobileSomethingWentWrong.localizable)
        #endif
    }
    
    static func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    func showAlert(title: String = "", message: String, ok: String = mobileOk, action: (() -> Void)? = nil) {
        guard !isAlertPresented else {
            return
        }
        if let topmostViewController = UIViewController.topMostViewController(),
            !topmostViewController.isBeingPresented, !topmostViewController.isBeingDismissed {
            if !(topmostViewController.presentedViewController is UIAlertController) {
                let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
                alert.overrideUserInterfaceStyle = isDarkMode ? .dark : .light
                let button = UIAlertAction(title: ok.localizable.uppercased(), style: .cancel) { _ in
                    self.isAlertPresented = false
                    action?()
                }
                alert.addAction(button)
                topmostViewController.present(alert, animated: true) {
                    self.isAlertPresented = true
                }
            }
        }
    }
    
    func showAlertWithButton(title: String = "",
                             message: String,
                             yesTitle: String = mobileYes.localizable.uppercased(),
                             noTitle: String = mobileNo.localizable.uppercased(),
                             action: ((Int) -> Void)? = nil) {
        Utilize.hideKeyboard()
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.overrideUserInterfaceStyle = isDarkMode ? .dark : .light
        let buttonNo = UIAlertAction(title: noTitle, style: .destructive) { _ in
            action?(0)
        }
        alert.addAction(buttonNo)
        
        let buttonYes = UIAlertAction(title: yesTitle, style: .default) { _ in
            action?(1)
        }
        alert.addAction(buttonYes)
        
        if let topmostViewController = UIViewController.topMostViewController(),
            !topmostViewController.isBeingPresented, !topmostViewController.isBeingDismissed {
            topmostViewController.present(alert, animated: true, completion: nil)
        }
    }
    
    func convertToSeconds(minutes: Int, seconds: Int) -> Int {
        return (minutes * 60) + seconds
    }
    
    func getHeader() -> HTTPHeaders {
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(UserPreference.shared.getToken())",
            "Content-Type": "application/json"
         ]
        return headers
    }
}

extension Utilize {
    func serverError() {
        let lang = UserPreference.shared.getDisplayLanguage()
        DispatchQueue.main.async {
            if lang.isEmpty == false {
                if lang == "zh_CN" || lang == "zh-Hans" || lang == "zh-Hant-IN" || lang == "zh" {
                    self.showAlert(title: "错误", message: "内部服务器错误", ok: "好的")
                } else if lang == "km" || lang == "km-KH" {
                    self.showAlert(title: "កំហុស", message: "កំហុសម៉ាស៊ីនមេខាងក្នុង", ok: "យល់ព្រម")
                } else {
                    self.showAlert(title: "Error", message: "Internal Server Error")
                }
            } else {
                self.showAlert(title: mobileError.localizable, message: mobileInternalServerError.localizable)
            }
        }
    }
    
    static func getDateCardSize() -> CGFloat {
        let dateCardSize: CGFloat = (UIScreen.main.bounds.width - 40 - 38)/7
        return dateCardSize
    }
    
    func checkForceUpdate(appInfo: AppInfo) {
        guard !isAlertForceUpdate else {
            return
        }
        if appInfo.forceUpdate ?? false || (UserPreference.shared.getForceUpdateDate()?.addDay(day: appInfo.noOfDays ?? 0) ?? Date()) <= Date() {
            let currentAppVersion = Double(appVersion ?? "") ?? 0.0
            let latestVersion = Double(appInfo.version ?? "") ?? 0.0
            if latestVersion > currentAppVersion {
                let message = "LuckyInfos \(mobileVersion.localizable) \(appInfo.version ?? "") \(mobileAvailableAppstore.localizable)"
                let alert = UIAlertController(title: mobileUpdateAvailable.localizable, message: message, preferredStyle: .alert)
                alert.overrideUserInterfaceStyle = isDarkMode ? .dark : .light
                if appInfo.forceUpdate ?? false {
                    let buttonYes = UIAlertAction(title: mobileUpdate.localizable, style: .default) { _ in
                        self.isAlertForceUpdate = false
                        if let url = URL(string: appInfo.downloadLink ?? "") {
                            UIApplication.shared.open(url)
                        }
                    }
                    alert.addAction(buttonYes)
                } else {
                    let buttonNo = UIAlertAction(title: mobileNotNow.localizable, style: .default) {_ in
                        self.isAlertForceUpdate = false
                        UserPreference.shared.setForceUpdate(date: Date())
                    }
                    alert.addAction(buttonNo)
                    let buttonYes = UIAlertAction(title: mobileUpdate.localizable, style: .default) { _ in
                        self.isAlertForceUpdate = false
                        if let url = URL(string: appInfo.downloadLink ?? "") {
                            UIApplication.shared.open(url)
                        }
                    }
                    alert.addAction(buttonYes)
                }
                if let topmostViewController = UIViewController.topMostViewController(),
                   !topmostViewController.isBeingPresented, !topmostViewController.isBeingDismissed {
                    self.isAlertForceUpdate = true
                    topmostViewController.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
    func timeOut() {
        DispatchQueue.main.async {
            if ConfigurationDataManager.shared.isLanguageKey {
                let message = mobileTheRequestTimedOut.localizable + "\n" + mobilePleaseCheckYourInternetSettings.localizable + " " + mobileAndTryAgain.localizable
                self.showAlert(title: mobileError.localizable, message: message)
            } else {
                let lang = UserPreference.shared.getDisplayLanguage()
                if lang.isEmpty == false {
                    if lang == "zh_CN" || lang == "zh-Hans" || lang == "zh-Hant-IN" || lang == "zh" {
                        let chMessage = "请求超时\n请检查您的互联网设置 然后再试一次"
                        self.showAlert(title: "错误", message: chMessage, ok: "好的")
                    } else if lang == "km" || lang == "km-KH" {
                        let khMessage = "សំណើអស់ពេល\nសូមពិនិត្យមើលការកំណត់អ៊ីនធឺណិតរបស់អ្នក និងព្យាយាមម្តងទៀត"
                        self.showAlert(title: "កំហុស", message: khMessage, ok: "យល់ព្រម")
                    } else {
                        let enMessage = "The request timed out\nPlease check your internet settings and try again"
                        self.showAlert(title: "Error", message: enMessage, ok: "OK")
                    }
                } else {
                    let message = mobileTheRequestTimedOut.localizable + "\n" + mobilePleaseCheckYourInternetSettings.localizable + " " + mobileAndTryAgain.localizable
                    self.showAlert(title: mobileError.localizable, message: message)
                }
            }
        }
    }
    
    func somethingWentWrong() {
        DispatchQueue.main.async {
            if ConfigurationDataManager.shared.isLanguageKey {
                let message = mobileSomethingWentWrong.localizable + "\n" + mobilePleaseCheckYourInternetSettings.localizable + " " + mobileAndTryAgain.localizable
                self.showAlert(title: mobileError.localizable, message: message)
            } else {
                let lang = UserPreference.shared.getDisplayLanguage()
                if lang.isEmpty == false {
                    if lang == "zh_CN" || lang == "zh-Hans" || lang == "zh-Hant-IN" || lang == "zh" {
                        let chMessage = "出了些问题\n请检查您的互联网设置 然后再试一次"
                        self.showAlert(title: "错误", message: chMessage, ok: "好的")
                    } else if lang == "km" || lang == "km-KH" {
                        let khMessage = "មាន​អ្វីមួយ​មិន​ប្រក្រតី\nសូមពិនិត្យមើលការកំណត់អ៊ីនធឺណិតរបស់អ្នក និងព្យាយាមម្តងទៀត"
                        self.showAlert(title: "កំហុស", message: khMessage, ok: "យល់ព្រម")
                    } else {
                        let enMessage = "Something went wrong\nPlease check your internet settings and try again"
                        self.showAlert(title: "Error", message: enMessage, ok: "OK")
                    }
                } else {
                    let message = mobileSomethingWentWrong.localizable + "\n" + mobilePleaseCheckYourInternetSettings.localizable + " " + mobileAndTryAgain.localizable
                    self.showAlert(title: mobileError.localizable, message: message)
                }
            }
        }
    }
}
