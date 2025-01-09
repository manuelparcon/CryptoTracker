//
//  String.swift
//  CryptoTracker
//
//  Created by Manuel Parcon on 1/9/25.
//

import Foundation

extension String {
    
    // Finds HTML in a string
    var removingHTMLOccurances: String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
}
