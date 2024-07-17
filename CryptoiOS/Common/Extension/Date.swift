//
//  Date.swift
//  InfoWebiOS
//
//  Created by Brilliant Dev on 4/4/24.
//

import Foundation

extension Date {
    func addDay(day: Int) -> Date {
        let calendar = Calendar.current
        return calendar.date(byAdding: .day, value: day, to: self)!
    }
}
