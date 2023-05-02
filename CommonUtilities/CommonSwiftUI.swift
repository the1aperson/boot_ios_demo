//
//  CommonSwiftUI.swift
//  BootBarn_iOS_Demo
//
//  Created by happyMedium on 2/6/22.
//

import SwiftUI

public typealias Action = (()->Void)

public extension View {
    
    func vPrint(_ vars: Any...) -> some View {
        for v in vars { print(v) }
        return EmptyView()
    }
    
    func height(_ height: CGFloat) -> some View {
        return self.frame(height: height)
    }
    
    func width(_ width: CGFloat) -> some View {
        return self.frame(width: width)
    }
    
}

public func setTabBarAppearance(backgroundColor: UIColor, normalColor: UIColor, selectedColor: UIColor, tabBarFont: UIFont) {
    
    let tabBarItemAppearance = UITabBarItemAppearance()
    tabBarItemAppearance.normal.iconColor = normalColor
    tabBarItemAppearance.selected.iconColor = selectedColor
    tabBarItemAppearance.normal.titleTextAttributes = [
        .foregroundColor: normalColor,
        .font: tabBarFont
    ]
    
    tabBarItemAppearance.selected.titleTextAttributes = [
        .foregroundColor: selectedColor,
        .font: tabBarFont
    ]

    let tabBarAppearance = UITabBarAppearance()
    tabBarAppearance.configureWithOpaqueBackground()
    tabBarAppearance.backgroundColor = backgroundColor
    tabBarAppearance.stackedLayoutAppearance = tabBarItemAppearance

    UITabBar.appearance().standardAppearance = tabBarAppearance
    UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
    
}

public func setPageIndicatorDotColors(activeColor: UIColor, inactive: UIColor) {
    UIPageControl.appearance().pageIndicatorTintColor = activeColor
    UIPageControl.appearance().currentPageIndicatorTintColor = inactive
}

// MARK: - Consistent Height for Grids
public struct DetermineHeight: View {
    
    public typealias Key = MaximumHeightPreferenceKey
    
    public init() {}
    
    public var body: some View {
        GeometryReader { proxy in
            Color.clear.anchorPreference(key: Key.self, value: .bounds) {
                anchor in proxy[anchor].size.height
            }
        }
    }
}

public struct MaximumHeightPreferenceKey: PreferenceKey {
    public static let defaultValue: CGFloat = 0
    public static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = max(value, nextValue())
    }
}

// MARK: - Conditional Modifier
public extension View {
    
    /// Applies the given transform if the given condition evaluates to `true`.
    /// - Parameters:
    ///   - condition: The condition to evaluate.
    ///   - transform: The transform to apply to the source `View`.
    /// - Returns: Either the original `View` or the modified `View` if the condition is `true`.
    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }

    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content, else elseTransform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            elseTransform(self)
        }
    }
    
}

// MARK: - Image
public extension Image {
    
    func aspectFit() -> some View {
        self.resizable()
            .scaledToFit()
            .clipped()
    }
    
    func aspectFill() -> some View {
        self.resizable()
            .scaledToFill()
            .clipped()
    }
    
}
