//
//  FeaturedProductItemView.swift
//  DesignSystem
//
//  Created by happyMedium on 2/13/22.
//

import CommonUtilities
import SwiftUI

public struct FeaturedItem {
    
    let appImage: AppImage
    let name: String
    let price: String
    
    public init(appImage: AppImage, name: String, price: String) {
        self.appImage = appImage
        self.name = name
        self.price = price
    }
    
}

public struct FeaturedProductScroller: View {
    
    @State private var titleHeight: CGFloat?
    let items: [FeaturedItem]

    public init(items: [FeaturedItem]) {
        self.items = items
    }
    
    public var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 28) {
                ForEach(items, id: \.appImage.rawValue) {
                    FeaturedProductItemView(item: $0, titleHeight: $titleHeight)
                }
            }
            .padding(.horizontal, 32)
        }
        .onPreferenceChange(DetermineHeight.Key.self) {
            titleHeight = $0
        }
    }
}

public struct FeaturedProductItemView: View {
    
    let item: FeaturedItem
    @Binding var titleHeight: CGFloat?
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Image(item.appImage)
                .resizable()
                .aspectRatio(3/4, contentMode: .fit)
                .width(200)
                .foregroundColor(.bootLightGray)
            Spacer().height(16)
            HStack(alignment: .top) {
                Text(item.name)
                    .appFont(.paragraph2)
                    .layoutPriority(1)
                Spacer()
                    .frame(minHeight: titleHeight)
            }
            .width(200)
            .overlay(DetermineHeight())
            Spacer().height(28)
            Text(item.price)
                .appFont(.title2)
        }
    }
    
}
