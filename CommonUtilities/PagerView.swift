//
//  PagerView.swift
//  CommonUtilities
//
//  Created by happyMedium on 2/22/22.
//

import SwiftUI

public struct PagerView<Content: View & Identifiable>: View {
    
    private let coordinateSpace: String = "scrollView"
    var indexFloat: CGFloat { CGFloat(index) }
    @State private var isGestureActive: Bool = false

    var pages: [Content]
    let pageWidth: CGFloat
    let pageSpacing: CGFloat
    @Binding var index: Int
    @Binding var offset: CGFloat
    
    public init(pages: [Content], pageWidth: CGFloat, pageSpacing: CGFloat, index: Binding<Int>, offset: Binding<CGFloat>) {
        self.pages = pages
        self.pageWidth = pageWidth
        self.pageSpacing = pageSpacing
        self._index = index
        self._offset = offset
    }
    
    public var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .center, spacing: pageSpacing) {
                ForEach(self.pages) { page in
                    page.frame(width: pageWidth)
                }
            }
            .background(geoBackground)
        }
        .content.offset(x: self.isGestureActive ? self.offset : calculateOffset(for: indexFloat))
        .frame(width: pageWidth, alignment: .leading)
        .gesture(dragGesture)
    }
    
    func calculateOffset(for index: CGFloat) -> CGFloat {
        let pageWidthWithSpacing = -(pageWidth + pageSpacing)
        return pageWidthWithSpacing * index
    }
    
    var geoBackground: some View {
        GeometryReader { geometry in
            let origin = geometry.frame(in: .named(coordinateSpace)).origin
            Color.clear.preference(
                key: ScrollOffsetPreferenceKey.self,
                value: -origin.x
            )
        }
    }
    
    var dragGesture: some Gesture {
        DragGesture()
            .onChanged({ dragChanged($0) })
            .onEnded({ dragEnded($0) })
    }
    
    func dragChanged(_ value: DragGesture.Value) {
        self.isGestureActive = true
        self.offset = value.translation.width + calculateOffset(for: indexFloat)
    }
    
    func dragEnded(_ value: DragGesture.Value) {
        if -value.predictedEndTranslation.width > (pageWidth/2)
                && self.index < self.pages.endIndex - 1
        {
            self.index += 1
        }
        
        if value.predictedEndTranslation.width > (pageWidth/2)
            && self.index > 0
        {
            self.index -= 1
        }
        
        withAnimation { self.offset = calculateOffset(for: indexFloat) }
        DispatchQueue.main.async { self.isGestureActive = false }
    }
    
}

private struct ScrollOffsetPreferenceKey: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue = CGFloat.zero
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value += nextValue()
    }
}
