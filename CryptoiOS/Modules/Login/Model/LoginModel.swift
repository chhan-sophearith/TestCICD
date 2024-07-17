//
//  LoginModel.swift
//  CryptoiOS
//
//  Created by Jatin's iMac on 01/07/24.
//

import Foundation

struct AuthSuccessModel: Codable {
    let id: Int?
    var name, email, emailVerifiedAt: String?
    let phoneNo: String?
    let isAdmin: Int?
    let authDriver, socialID: String?
    let type: String?
    let uid: String?
    let isVerified: Bool?
    let createdAt, updatedAt, token: String?

    enum CodingKeys: String, CodingKey {
        case id, name, email
        case emailVerifiedAt = "email_verified_at"
        case phoneNo = "phone_no"
        case isAdmin = "is_admin"
        case authDriver = "auth_driver"
        case socialID = "social_id"
        case type, uid
        case isVerified = "is_verified"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case token
    }
}

enum ContactType: String {
    case phoneNo = "phone_no"
    case email
}

enum RequestForm: String {
    case registration
    case login
    case forgetPassword = "forget_password"
}

enum AuthType: String {
    case password
    case otp
}

struct AppInfo: Codable {
    let version: String?
    let forceUpdate: Bool?
    let downloadLink: String?
    let noOfDays: Int?
    
    enum CodingKeys: String, CodingKey {
        case forceUpdate = "force_update"
        case noOfDays = "no_of_days"
        case version
        case downloadLink = "download_link"
    }
}
