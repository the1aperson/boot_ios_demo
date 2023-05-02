//
//  OffsetScrollView.swift
//  CommonUtilities
//
//  Created by happyMedium on 2/23/22.
//

import SwiftUI

public struct OffsetScrollView<Content: View>: View {
    
    let coordinateSpace: String = "scrollView"
    
    let axes: Axis.Set
    let showsIndicators: Bool
    @Binding var offset: CGFloat
    let content: Content
    
    @State private var viewWidth: CGFloat? = nil
    
    public init(
        axes: Axis.Set = .vertical,
        showsIndicators: Bool = true,
        offset: Binding<CGFloat>,
        @ViewBuilder content: () -> Content
    ) {
        self.axes = axes
        self.showsIndicators = showsIndicators
        self._offset = offset
        self.content = content()
    }
    
    public var body: some View {
        ScrollView(axes, showsIndicators: showsIndicators) {
            content
                .background(
                    GeometryReader { geometry in
                        let origin = geometry.frame(in: .named(coordinateSpace)).origin
                        Color.clear.preference(
                            key: ScrollOffsetPreferenceKey.self,
                            value: (axes == .vertical) ? -origin.y : -origin.x
                        ).onAppear {
                            maybeSetWidth(geometry.size.width)
                        }
                    }
                )
        }
        .coordinateSpace(name: coordinateSpace)
        .onPreferenceChange(ScrollOffsetPreferenceKey.self) {
            self.offset = $0
        }
        
    }
    
    func maybeSetWidth(_ width: CGFloat) {
        guard width != self.viewWidth else { return }
        self.viewWidth = width
    }
    
}

private struct ScrollOffsetPreferenceKey: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue = CGFloat.zero
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value += nextValue()
    }
}
