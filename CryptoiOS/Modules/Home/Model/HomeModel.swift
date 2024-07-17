//
//  HomeModel.swift
//  CryptoiOS
//
//  Created by Brilliant Dev on 15/7/24.
//

import Foundation

struct DataInfo: Codable {
    var countries: [Country]?
}

struct Country: Codable {
    let id: Int?
    let countryDefault: Bool?
    let idd, name: String?
    let flag: String?

    enum CodingKeys: String, CodingKey {
        case id
        case countryDefault
        case idd, name, flag
    }
}
