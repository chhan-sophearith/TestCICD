//
//  RestAPI.swift
//  InfoWebiOS
//
//  Created by Chhan Sophearith on 24/11/23.
//

import Foundation
import SwiftUI

class RestAPI {
    
    static let shared = RestAPI()
    @AppStorage("isConnect") private var internet = false
    private var counter = 0
    
    func apiRequest<T: Codable>(request: Request,
                                callBack: @escaping (T) -> Void,
                                errorCallBack: ((ErrorModel?) -> Void)? = nil) {
        if Reachability.isConnectedToNetwork() {
            let newRequest = validateRequestApi(reguest: request)
            // request to api
            let task = URLSession.shared.dataTask(with: newRequest, completionHandler: { (data, response, error) in
                DispatchQueue.main.async {
                    
                    self.checkForceUpdateApp(api: request.resource)
                    if let error = error as NSError? {
                        switch error.code {
                        case NSURLErrorCannotFindHost:
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                LoadingView.shared.hide()
                                self.internet = false
                            }
                        case NSURLErrorTimedOut, NSURLErrorCannotConnectToHost:
                            LoadingView.shared.hide()
                            Utilize.shared.timeOut()
                            errorCallBack?(nil)
                        default:
                            LoadingView.shared.hide()
                            errorCallBack?(nil)
                            Utilize.shared.somethingWentWrong()
                        }
                    }
                    
                    if let httpResponse = response as? HTTPURLResponse {
                        LoadingView.shared.hide()
                        switch httpResponse.statusCode {
                        case (200...204):
                            Utilize.shared.debugerResult(urlRequest: newRequest, data: data, error: false)
                            Utilize.shared.validateModel(model: T.self, data: data, url: newRequest.url?.absoluteString) { objectData in
                                callBack(objectData)
                            }
                        case 401:
                            Utilize.shared.debugerResult(urlRequest: newRequest, data: data, error: true)
                            Utilize.shared.validateModel(model: ErrorModel.self, data: data) { objectData in
                                UserPreference.shared.resetDataOnLogout()
                                Utilize.shared.showAlert(title: objectData.message.title.localizable, message: objectData.message.description.localizable) {
                                }
                            }
                        case (500...503):
                            errorCallBack?(nil)
                            Utilize.shared.serverError()
                        default:
                            Utilize.shared.debugerResult(urlRequest: newRequest, data: data, error: true)
                            Utilize.shared.validateModel(model: ErrorModel.self, data: data) { objectData in
                                if errorCallBack != nil {
                                    errorCallBack?(objectData)
                                } else {
                                    Utilize.shared.showAlert(title: objectData.message.title.localizable, message: objectData.message.description.localizable)
                                }
                            }
                        }
                    }
                }
            })
            task.resume()
        } else {
            internet = false
        }
    }
}

extension RestAPI {
    
    private func checkNoInternet() {
        if UserPreference.shared.getLanguageCode().isEmpty {
            internet = false
        } else {
            NoConnectionView.shared.show()
        }
    }
    
    private func validateRequestApi(reguest: Request) -> URLRequest {
        if reguest.isLoading {
            LoadingView.shared.show()
        }
        var langParam = "en"
        let lang = UserPreference.shared.getLanguageCode()
        let urlRequest: NSMutableURLRequest = NSMutableURLRequest()
        urlRequest.httpMethod = reguest.resource.method.rawValue
        
        if reguest.resource.path.contains("?") {
            langParam = "&lang=\(lang)"
        } else {
            langParam = "?lang=\(lang)"
        }
        
        var strUrl = URL(string: BaseUrl.url + reguest.resource.path + langParam)
        urlRequest.url = strUrl
        
        if reguest.resource.method == .GET, let parameters = reguest.parameters {
            var components = URLComponents(string: BaseUrl.url + reguest.resource.path)!
            var queryParams: [URLQueryItem] = []
            for (key, value) in parameters {
                queryParams.append(URLQueryItem(name: key, value: "\(value)"))
            }
            queryParams.append(URLQueryItem(name: "lang", value: "\(BaseUrl.url)"))
            components.queryItems = queryParams
            strUrl = components.url
            urlRequest.url = components.url
        } else {
            do {
                if let param = reguest.parameters {
                    urlRequest.httpBody = try JSONSerialization.data(withJSONObject: param, options: [])
                }
            } catch let error as NSError {
                print("error", error.localizedDescription)
            }
        }

        // add headers
        if reguest.header {
            urlRequest.allHTTPHeaderFields = Utilize.shared.getHeader()
        } else {
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        
        var newRequest = urlRequest as URLRequest
        newRequest.timeoutInterval = 90.0
        return newRequest
    }
    
    private func createURLWithQueryParameters(baseUrl: String, path: String, method: HTTPMethod, param: Parameters?, langParam: String) -> URL? {
        if method == .GET, let param {
            var components = URLComponents(string: baseUrl + path)!
            var queryParams: [URLQueryItem] = []
            for (key, value) in param {
                queryParams.append(URLQueryItem(name: key, value: "\(value)"))
            }
            queryParams.append(URLQueryItem(name: "lang", value: "\(langParam)"))
            components.queryItems = queryParams
            return components.url
        }
        return nil
    }
    
    private func checkForceUpdateApp(api: APIResource) {        
        if self.counter > 2 {
            self.counter = 0
            if let appInfo = ConfigurationDataManager.shared.appInfo {
                Utilize.shared.checkForceUpdate(appInfo: appInfo)
            }
        }
    }
}
