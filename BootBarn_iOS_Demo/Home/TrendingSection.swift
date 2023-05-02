//
//  TrendingSection.swift
//  BootBarn_iOS_Demo
//
//  Created by happyMedium on 2/22/22.
//

import CommonUtilities
import DesignSystem
import SwiftUI

struct TrendingList: View {
    
    @State var pageIndex: Int = 0
    @State var scrollOffset: CGFloat = 0
    
    let pages: [TrendingListPageView] = [
        .init(
            firstItem: .init(
                index: 1,
                appImage: .homeTrending1,
                name: "El Dorado Men's Exotic Full-Quill Ostrich Skin Western Boots Round Toe"
            ),
            secondItem: .init(
                index: 2,
                appImage: .homeTrending2,
                name: "Moonshine Spirit Men's Mad Cat Western Boots Narrow Square Toe"
            ),
            thirdItem: .init(
                index: 3,
                appImage: .homeTrending3,
                name: "Justin Men's Bent Rail Square Toe Western Boots"
            )
        ),
        .init(
            firstItem: .init(
                index: 4,
                appImage: .homeTrending4,
                name: "Cody James Men's Brown Python Western Boots Square Toe"
            ),
            secondItem: .init(
                index: 5,
                appImage: .homeTrending5,
                name: "Dan Post Men's Mignon Leather Cowboy Boots - Medium Toe"
            ),
            thirdItem: .init(
                index: 6,
                appImage: .homeTrending6,
                name: "Cody James Men's Xero Gravity Embroidered Performance Boots Square Toe"
            )
        )
    ]
    
    @State private var viewWidth: CGFloat = 80
    var body: some View {
        VStack(spacing: 0) {
            HomeSectionHeader(title: "Trending")
            Spacer().height(48)
            PagerView(pages: pages, pageWidth: viewWidth, pageSpacing: 0, index: $pageIndex, offset: $scrollOffset)
            Spacer().height(40)
            scrollProgressBar
                .animation(.default, value: pageIndex)
        }
        .overlay {
            GeometryReader { geo in
                Color.clear.onAppear {
                    self.viewWidth = geo.size.width
                }
            }
        }
    }
    
    let horizontalPadding: CGFloat = 32
    @State private var progressMaxWidth: CGFloat?
    private var progressWidth: CGFloat {
        guard let progressMaxWidth = progressMaxWidth else { return 0 }
        let currentIndex = pageIndex + 1
        let percent: CGFloat = CGFloat(currentIndex) / CGFloat(pages.count)
        return (percent * progressMaxWidth)
    }
    
    var scrollProgressBar: some View {
        ZStack(alignment: .leading) {
            Color.bootLighterGray
                .frame(height: 3)
                .overlay {
                    GeometryReader { geo in
                        Color.black
                            .frame(width: progressWidth, height: 3)
                            .onAppear {
                                self.progressMaxWidth = geo.size.width
                            }
                    }
                }
        }
        .padding(.leading, horizontalPadding)
    }
    
}

struct TrendingListPageView: View, Identifiable {
    
    let id: UUID = UUID()
    
    let firstItem: TrendingListItem
    let secondItem: TrendingListItem
    let thirdItem: TrendingListItem
    
    var body: some View {
        VStack(spacing: 24) {
            TrendingListItemView(item: firstItem)
            Color.black.height(0.5)
            TrendingListItemView(item: secondItem)
            Color.black.height(0.5)
            TrendingListItemView(item: thirdItem)
        }
    }
    
}

struct TrendingListItem {
    let index: Int
    let appImage: AppImage
    let name: String

}

struct TrendingListItemView: View {
    
    let item: TrendingListItem
    
    var body: some View {
        HStack(spacing: 24) {
            ZStack(alignment: .center) {
                Circle()
                    .strokeBorder(.black, lineWidth: 1)
                    .frame(width: 40, height: 40)
                    .foregroundColor(.clear)
                Text("\(item.index)")
                    .tracking(0)
                    .appFont(.label1)
            }
            
            Image(item.appImage)
                .aspectFit()
                .height(80)
                .width(60)
            
            Text(item.name)
                .appFont(.paragraph1)
                .frame(maxWidth: .infinity)

        }
        .padding(.leading, 32)
        .padding(.trailing, 24)
        .height(80)
    }
    
}
