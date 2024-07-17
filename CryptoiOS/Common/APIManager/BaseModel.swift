//
//  BaseModel.swift
//  InfoWebiOS
//
//  Created by Chhan Sophearith on 24/11/23.
//

import Foundation

struct BaseModel<T: Codable>: Codable {
    let status: Bool
    let message: MessageModel?
    let data: T?
    let meta: MetaModel?
}

struct MetaModel: Codable {
    let currentPage, from, lastPage, perPage: Int?
    let to, total: Int?
    
    enum CodingKeys: String, CodingKey {
        case currentPage = "current_page"
        case from
        case lastPage = "last_page"
        case perPage = "per_page"
        case to, total
    }
}

struct MessageModel: Codable {
    let title: String
    let description: String
}

struct ErrorModel: Codable {
    let status: Bool
    let message: MessageModel
}

struct ValidateParams {
    let url: APIResource
    let param: Parameters?
    let raw: String
    let headers: Bool
    let isLoading: Bool
}

struct Request {
    let resource: APIResource
    let parameters: Parameters?
    var header: Bool = false
    var isLoading: Bool = true
}
