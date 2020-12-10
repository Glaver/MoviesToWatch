//
//  Extansion.swift
//  MoviesToWatch
//
//  Created by Vladyslav on 10/12/20.
//

import Foundation

class DateFormattingHelper {

    static let shared = DateFormattingHelper()

    let yearMonthDayDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()

    func printFormattedDate(_ date: Date, printFormat: String) -> String {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = printFormat
        return dateFormat.string(from: date)
    }
}
