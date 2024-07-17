//
//  HomeViewModel.swift
//  CryptoiOS
//
//  Created by Brilliant Dev on 15/7/24.
//

import Foundation
import SwiftUI

class HomeViewModel: ObservableObject {
    // sample api call
    func testingApi() {
        RestAPI.shared.apiRequest(request: .init(resource: .dataInfo, parameters: nil)) { (data: BaseModel<DataInfo>) in
            print("data", data)
        }
    }
}
