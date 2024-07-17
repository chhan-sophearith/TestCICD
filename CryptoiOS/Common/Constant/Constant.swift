//
//  Constant.swift
//  InfoWebiOS
//
//  Created by Chhan Sophearith on 24/11/23.
//

import Foundation
import SwiftUI

public typealias Parameters = [String: Any]
public typealias HTTPHeaders = [String: String]
public typealias ResponseCallBack = (Bool, String) -> Void
public typealias JSONDictionary = [String: Any]
var langKey: [String: String]?

var currentView = ""
let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
let appBuildNumber = Bundle.main.infoDictionary?["CFBundleVersion"] as? String
let allowLoginRegiterText: String = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ.@"

struct InfoWeblanguage {
    static var id = 1
    static var code = "zh"
    static var name = "简体中文"
    static var iconUrl = "http://minio1.kk88814.net/kkvideo/language_zh.png"
}

let minLimitPassowrd = 6
let maxLimitPassowrd = 16
let maxLimitOtp = 6
let maxLimitName = 45
let minLimitNickname = 1
let maxLimitNickname = 16
let minLimitPhoneNo = 4
let maxLimitPhoneNo = 16
let maxLimitEmail = 64
let countDownTime = 60
let maxFeedBackContent = 200

enum FontSize: CGFloat {
    case small = 10
    case normal = 12
    case medium = 14
    case large = 16
    case huge = 19
}

enum HTTPMethod: String {
    case POST
    case GET
    case PUT
    case DELETE
    case PATCH
}

enum TextFieldType {
    case emailOrPhone
    case email
    case password
    case normal
}

enum PlaceHolderType {
    case inner
    case above
    case outside
}

enum BtnRequireLogin {
    case none
    case profile
    case isFavorite
    case favoriteScreen
    case filterLottery
    case newsFeed
}
enum DateOrder {
    case same
    case greaterThan
    case lessThan
}
