//
//  DemoHint.swift
//  BootBarn_iOS_Demo
//
//  Created by happyMedium on 2/16/22.
//

import CommonUtilities
import SwiftUI

enum HintLocation {
    case right, topRight, bottomRight
}

struct Hint: ViewModifier {
    
    let location: HintLocation
    let color: Color
    
    let iconWidth: CGFloat = 26
    
    func body(content: Content) -> some View {
        switch location {
        case .right:
            return AnyView(
                content.overlay {
                    GeometryReader { geo in
                        icon
                            .position(x: geo.size.width + (iconWidth/2) + 16,
                                      y: geo.frame(in: .local).midY)
                    }
                }
            )
        case .topRight:
            return AnyView(
                ZStack(alignment: .topTrailing) {
                    content
                    icon
                        .padding(.top, 24)
                        .padding(.trailing, 16)
                }
            )
        case .bottomRight:
            return AnyView(
                ZStack(alignment: .bottomTrailing) {
                    content
                    icon
                        .padding(.bottom, -4)
                }
            )
        }
    }
    
    @State private var iconColor: Color = .clear
    var icon: some View {
        Image(.hMIcon)
            .resizable()
            .frame(width: iconWidth, height: 32)
            .foregroundColor(iconColor)
            .animation(.easeInOut(duration: 1), value: iconColor)
            .onAppear { iconColor = color }
//            .onDisappear { iconColor = .clear }
    }
    
    
    
}

protocol HappyPath {
    var happyPath: Bool { get }
}

extension View {
    
    /// Shows a hint on a `View` in the specific location. `color` should be `.black` or `.white`
    func showHint(_ location: HintLocation, color: Color) -> some View {
        return self.modifier(Hint(location: location, color: color))
    }
    
    /// Easy way to show the happyPath on a list of items that conform to the `HappyPath` protocol
    func happyPath(pathItem: HappyPath, location: HintLocation, color: Color) -> some View {
        self.if(pathItem.happyPath) { view in
            AnyView(view.modifier(Hint(location: location, color: color)))
        } else: { view in
            AnyView(view.disabled(true))
        }

    }
    
}
