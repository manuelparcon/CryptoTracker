//
//  UIApplication.swift
//  CryptoTracker
//
//  Created by Manuel Parcon on 11/19/24.
//

import Foundation
import SwiftUI

extension UIApplication {

    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
