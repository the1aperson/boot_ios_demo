//
//  TextStyling.swift
//  BootBarn_iOS_Demo
//
//  Created by happyMedium on 2/8/22.
//

import SwiftUI

fileprivate struct AppFontModifier: ViewModifier {
    
    let font: Font
    
    func body(content: Content) -> some View {
        content.font(font)
    }
}

public extension Text {
    func appFont(_ appFont: AppFont) -> some View {
        let shouldUppercase: Bool = AppFont.fontsToUppercase.contains(appFont)
//        return kerning(appFont.kerning)
        return tracking(appFont.kerning)
            .modifier(AppFontModifier(font: appFont.font))
            .if(shouldUppercase) { view in
                view.textCase(.uppercase)
            }
            
    }
}

extension Button {
    func appFont(_ appFont: AppFont) -> some View {
        let shouldUppercase: Bool = AppFont.fontsToUppercase.contains(appFont)
        return modifier(AppFontModifier(font: appFont.font))
            .if(shouldUppercase) { view in
                view.textCase(.uppercase)
            }
            
    }
}
