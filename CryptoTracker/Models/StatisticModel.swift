//
//  StatisticModel.swift
//  CryptoTracker
//
//  Created by Manuel Parcon on 11/20/24.
//

import Foundation

struct StatisticModel: Identifiable {
    let id = UUID().uuidString
    let title: String
    let value: String
    let percentageChange: Double? // Not all statistic has percentageChange
    
    // Make a custom init to set percentageChange optional with default nil
    init(title: String, value: String, percentageChange: Double? = nil) {
        self.title = title
        self.value = value
        self.percentageChange = percentageChange
    }
}

