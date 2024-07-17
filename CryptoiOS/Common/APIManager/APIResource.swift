//
//  APIEndPoint.swift
//  InfoWebiOS
//
//  Created by Chhan Sophearith on 24/11/23.
//

import Foundation

struct BaseUrl {
    static var url: String {
        #if Dev
            return "http://dev.infoweb-api.kk-exchange.com"
        #elseif UAT
//            return "http://uat-api-luckyinfos.lomatechnology.com"
            return "https://test-api-luckyinfos.lomatechnology.com"
        #elseif SIT
            return "http://sit.infoweb-api.kk-exchange.com"
        #else
            return "https://api-gateway.luckyinfos.com"
        #endif
    }

    static var name: String {
        #if Dev
            return "(Dev)"
        #elseif UAT
            return "(UAT)"
        #elseif SIT
            return "(SIT)"
        #else
            return ""
        #endif
    }
}

struct SocketUrl {
    static var url: String {
        #if Dev
            return "http://info-web-socket.lomatechnology.com:4013"
        #elseif UAT
//            return "http://info-web-socket.lomatechnology.com:4013"
            return "https://socket.luckyinfos.com"
        #elseif SIT
            return "http://info-web-socket.lomatechnology.com:4013"
        #else
            return "https://socket.luckyinfos.com"
        #endif
    }
    
    static var name: String {
        #if Dev
            return "(Dev)"
        #elseif UAT
            return "(UAT)"
        #elseif SIT
            return "(SIT)"
        #else
            return ""
        #endif
    }
}

enum APIResource {
    // Main
    case dataInfo
    case languageSelection
    case languageSource
    
    case adsList
    
    var path: String {
        switch self {
        case .dataInfo:
            return "/api/master-data?app_type=ios"
        case .languageSelection:
            return "/api/languages"
        case .languageSource:
            return "/api/label-languages?type=mobile"
        case .adsList:
            return "/api/advertisements"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        default:
            return .GET
        }
    }
    
    var timeoutInterval: TimeInterval {
        return 30.0
    }
}
