//
//  Colors.swift
//  BootBarn_iOS_Demo
//
//  Created by happyMedium on 2/8/22.
//

import SwiftUI

// MARK: - App Colors
public extension Color {
    static let bootDarkGray: Color = .init(hex: 0x5C5C5C)
    static let bootGray: Color = .init(hex: 0x969696)
    static let bootLightGray: Color = .init(hex: 0xE6E6E6)
    static let bootLighterGray: Color = .init(hex: 0xCCCCCC)
    
    static let productColorOptions: [Color] = [
        .init(hex: 0x7B401E),
        .init(hex: 0x150503),
        .init(hex: 0x815440),
        .init(hex: 0xBDB398)
    ]
    
}

public extension UIColor {
    static let bootDarkGray: UIColor = .init(.bootDarkGray)
    static let bootGray: UIColor = .init(.bootGray)
    static let bootLightGray: UIColor = .init(.bootLightGray)
}

// MARK: - Color from hex
extension Color {
    init(hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: alpha
        )
    }
}
