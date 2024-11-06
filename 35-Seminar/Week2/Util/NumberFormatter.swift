//
//  NumberFormatter.swift
//  35-Seminar
//
//  Created by 최지석 on 10/19/24.
//

import Foundation

class NumberFormatter {
    static func formatToReviewCountString(_ number: Int) -> String {
        if number < 1000 {
            // 1천 미만일 경우 그대로 반환
            return "\(number)"
        } else if number < 10000 {
            // 1만 미만일 경우 1천 단위로 표시 (내림)
            let formattedNumber = Double(number) / 1000.0
            return String(format: "%.1f천", floor(formattedNumber * 10) / 10)
        } else if number < 100000 {
            // 10만 미만일 경우 1만 단위로 표시 (내림)
            let formattedNumber = Double(number) / 10000.0
            return String(format: "%.1f만", floor(formattedNumber * 10) / 10)
        } else {
            // 10만 이상일 경우 1만 단위로 표시 (내림)
            let formattedNumber = Double(number) / 10000.0
            return String(format: "%.0f만", floor(formattedNumber))
        }
    }
}
