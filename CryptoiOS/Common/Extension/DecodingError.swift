//
//  DecodingError.swift
//  InfoWebiOS
//
//  Created by Chhan Sophearith on 24/11/23.
//

import Foundation

extension DecodingError.Context {
    func showError(functionName: String) -> String {
        return String(format: "%@ \n %@ : %@", functionName, self.codingPath.last?.stringValue ?? "", self.debugDescription)
    }
}
