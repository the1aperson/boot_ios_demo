//
//  AppFonts.swift
//  BootBarn_iOS_Demo
//
//  Created by happyMedium on 2/8/22.
//

import SwiftUI

// MARK: - App Font Boilerplate
enum FontSpecifier: String {
    
    case light = "Roboto-Light"
    case regular = "Roboto-Regular"
    case medium = "Roboto-Medium"
    case bold = "Roboto-Bold"
    case libreRegular = "LibreBaskerville-Regular"
    case libreBold = "LibreBaskerville-Bold"
    
    var name: String {
        return self.rawValue
    }
    
}

struct FontDescription {
    
    let font: Font
    let uiFont: UIFont
    
    init(font: FontSpecifier, size: CGFloat,  style: UIFont.TextStyle) {
        guard let font = UIFont(name: font.name, size: size) else {
            let uiFont = UIFont.preferredFont(forTextStyle: style)
            self.uiFont = uiFont
            self.font = Font(uiFont)
            return
        }
        
        let fontMetrics = UIFontMetrics(forTextStyle: style)
        let uiFont = fontMetrics.scaledFont(for: font)
        self.uiFont = uiFont
        self.font = Font(uiFont)
    }
    
}

public enum AppFont: String, CaseIterable, Hashable {
    
    static let fontsToUppercase: [AppFont] = [.title1, .title3, .label1, .label2, .button1, .caption1]

    case title1
    case title2
    case title3
    
    case label1
    case label2
    case label3
    case label4
    
    case paragraph1
    case paragraph2
    case paragraph3
    
    case button1
    case button2
    case button3
    
    case caption1
    
    case tabBar
    
}

// MARK: - Font Descriptions
extension AppFont {
    private var fontDescription: FontDescription {
        switch self {
        case .title1:
            return FontDescription(font: .libreRegular, size: 18, style: .title1)
        case .title2:
            return FontDescription(font: .libreRegular, size: 16, style: .title2)
        case .title3:
            return FontDescription(font: .libreRegular, size: 14, style: .title3)
            
        case .label1:
            return FontDescription(font: .bold, size: 16, style: .headline)
        case .label2:
            return FontDescription(font: .medium, size: 16, style: .headline)
        case .label3:
            return FontDescription(font: .medium, size: 14, style: .subheadline)
        case .label4:
            return FontDescription(font: .regular, size: 12, style: .subheadline)
            
        case .paragraph1:
            return FontDescription(font: .regular, size: 14, style: .body)
        case .paragraph2:
            return FontDescription(font: .regular, size: 12, style: .body)
        case .paragraph3:
            return FontDescription(font: .regular, size: 11, style: .body)
            
        case .button1:
            return FontDescription(font: .bold, size: 14, style: .headline)
        case .button2:
            return FontDescription(font: .regular, size: 16, style: .headline)
        case .button3:
            return FontDescription(font: .libreBold, size: 11, style: .subheadline)

        case .caption1:
            return FontDescription(font: .medium, size: 12, style: .caption1)
            
        case .tabBar:
            return FontDescription(font: .light, size: 12, style: .caption2)
        }
    }
}

// MARK: - Kerning
extension AppFont {
    var kerning: CGFloat {
        switch self {
        case .title1:
            return 4.5
        case .title3:
            return 3.5
        case .label1:
            return 2.4
        case .button1:
            return 2.1
        case .caption1:
            return 1.2
        default:
            return 1
        }
    }
}

public extension AppFont {
    var font: Font { fontDescription.font }
    var uiFont: UIFont { fontDescription.uiFont }
}

