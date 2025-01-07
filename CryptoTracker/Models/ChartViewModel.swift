//
//  ChartViewModel.swift
//  CryptoTracker
//
//  Created by Manuel Parcon on 1/7/25.
//

import Foundation

struct PriceOverTime: Identifiable {
    var id = UUID().uuidString
    var price: Double
    var date: Int
}
