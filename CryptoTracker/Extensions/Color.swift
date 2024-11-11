//
//  Color.swift
//  CryptoTracker
//
//  Created by Manuel Parcon on 11/11/24.
//

import Foundation
import SwiftUI

// We create an extension for Color so we can assign a theme and easily access custom colors:
// Color.constantName.customColorName
//
// However, this is not required anymore as names of custom colors in Assets can now be easily accessed:
// Color.customColorName

extension Color {
    
    static let theme = ColorTheme()
    
}

struct ColorTheme {
    
    let accent = Color("AccentColor")
    let background = Color("BackgroundColor")
    let green = Color("CryptoGreenColor")
    let red = Color("CryptoRedColor")
    let secondaryText = Color("SecondaryTextColor")
}
