//
//  String.swift
//  InfoWebiOS
//
//  Created by Chhan Sophearith on 30/11/23. lglg
//

import Foundation
import SwiftUI

extension String {
    var localizable: String {
        if let text = langKey?[self] {
            return text
        }
        return self.replacingOccurrences(of: "mobile", with: "").replacingOccurrences(of: "_", with: " ").capitalized
    }
    
    var camelCaseToWords: String {
        return unicodeScalars.dropFirst().reduce(String(prefix(1))) {
            return CharacterSet.uppercaseLetters.contains($1)
            ? $0 + " " + String($1)
            : $0 + String($1)
        }
    }
    
    func removeWhitespace() -> String {
        self.replacingOccurrences(of: " ", with: "")
    }
    
    func convertToDictionary() -> [String: Any]? {
        if let data = data(using: .utf8) {
            return try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        }
        return nil
    }
    
    func index(from: Int) -> Index {
        return self.index(startIndex, offsetBy: from)
    }
    
    func substring(with r: Range<Int>) -> String {
        let startIndex = index(from: r.lowerBound)
        let endIndex = index(from: r.upperBound)
        return String(self[startIndex..<endIndex])
    }
    
    func toArray() -> [String] {
        var arr: [String] = []
        for char in self {
            arr.append(String(char))
        }
        return arr
    }
    
//    func toColor() -> Color {
//        switch self {
//        case "blue":
//            return Color.blue
//        case "red":
//            return Color.red
//        case "green":
//            return Color.green
//        default:
//            return Color.main
//        }
//    }
    
    func removeComma() -> String {
        self.replacingOccurrences(of: ",", with: "")
    }
    
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(data: data,
                                          options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue],
                                          documentAttributes: nil)
        } catch {
            return nil
        }
    }
    
    func CGFloatValue() -> CGFloat? {
      guard let doubleValue = Double(self) else {
        return nil
      }
      return CGFloat(doubleValue)
    }
    
//    func scoreFormat() -> String {
//        if self.isEmpty {
//            return "0"
//        } else {
//            return self
//        }
//    }

//    func getSportStatus() -> String {
//        if self == "Finished" {
//            return mobileFt.localizable
//        } else if self == "1st Half" {
//            return mobile1stHalf.localizable
//        } else if self == "2nd Half" {
//            return mobile2ndHalf.localizable
//        } else if self == "Half Time" {
//            return mobileHalfTime.localizable
//        } else if self == "1st Quarter" {
//            return mobile1stQuarter.localizable
//        } else if self == "2nd Quarter" {
//            return mobile2ndQuarter.localizable
//        } else if self == "3rd Quarter" {
//            return mobile3rdQuarter.localizable
//        } else if self == "4th Quarter" {
//            return mobile4thQuarter.localizable
//        } else if self == "Over Time" {
//            return mobileOverTime.localizable
//        } else {
//            return self
//        }
//    }
    
    func splitTwoLine() -> String {
        // Find the index of the first space
        if let spaceIndex = self.firstIndex(of: " ") {
            // Get the substring up to the first space
            let firstPart = self.prefix(upTo: spaceIndex)
            // Get the substring after the first space
            let secondPart = self.suffix(from: self.index(after: spaceIndex))
            
            // Combine the parts with a newline character
            return String(firstPart) + "\n" + String(secondPart)
        } else {
            // If there is no space, return the input string as is
            return self
        }
    }
}
