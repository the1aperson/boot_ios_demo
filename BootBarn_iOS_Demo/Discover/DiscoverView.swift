//
//  SwiftUIView.swift
//  BootBarn_iOS_Demo
//
//  Created by happyMedium on 2/15/22.
//

import CommonUtilities
import DesignSystem
import SwiftUI

struct DiscoverView: View {
    
    let discover2Url: URL = Bundle.main.url(forResource: "discover_2", withExtension: "mp4")!
    let discover4Slide1Url: URL = Bundle.main.url(forResource: "discover_4slide1", withExtension: "mp4")!
    let discover6Url: URL = Bundle.main.url(forResource: "discover_6", withExtension: "mp4")!

    @State private var storiesIsPresented = false

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                Group {
                    DiscoverStoryComponent(
                        storyType: .story(image: .discover1, videoUrls: []),
                        title: "from the runway",
                        subtitle: "Curated directly from the fashion show.",
                        tappable: true
                    )
                        .onTapGesture {
                            storiesIsPresented.toggle()
                        }
                    DiscoverStoryComponent(
                        storyType: .video(url: discover2Url),
                        title: "made by the west",
                        subtitle: "Handcrafting boots since day one."
                    )
                    Spacer().height(24)
                    DiscoverImageScroller(
                        items: [.image(.discover3Slide1), .image(.discover3Slide2), .image(.discover3Slide3)],
                        size: .small
                    )
                    Spacer().height(12)
                    DiscoverImageScroller(
                        items: [.video(discover4Slide1Url), .image(.discover4Slide2), .image(.discover4Slide3)],
                        size: .large
                    )
                    Spacer().height(24)
                }
                Group {
                    ShopLookView()
                    Spacer().height(24)
                    DiscoverStoryComponent(
                        storyType: .video(url: discover6Url),
                        title: "the journey",
                        subtitle: "Every second counts."
                    )
                    Spacer().height(24)
                    DiscoverImageScroller(
                        items: [.image(.discover7Slide1), .image(.discover7Slide2), .image(.discover7Slide3)],
                        size: .small
                    )
                    Spacer().height(12)
                    Image(.discover8)
                        .aspectFit()
                }
            }
        }
        .padding(.leading, -1)
        .fullScreenCover(isPresented: $storiesIsPresented, onDismiss: nil, content: StoriesView.init)
        .edgesIgnoringSafeArea(.top)
    }
}

struct DiscoverStoryComponent: View {
    
    enum StoryType {
        case story(image: AppImage, videoUrls: [URL])
        case video(url: URL)
    }
    
    let storyType: StoryType
    let title: String
    let subtitle: String
    let tappable: Bool
    
    init(storyType: StoryType, title: String, subtitle: String, tappable: Bool = false) {
        self.storyType = storyType
        self.title = title
        self.subtitle = subtitle
        self.tappable = tappable
    }
    
    var buttonTitle: String {
        switch storyType {
        case .story(image: _, videoUrls: _):
            return "View Story"
        case .video(url: _):
            return "Watch Video"
        }
    }
    
    var body: some View {
        ZStack {
            backgroundView
                .aspectRatio(3/4, contentMode: .fill)
            
            HStack {
                VStack(alignment: .leading, spacing: 0) {
                    Spacer()
                    Text(title)
                        .appFont(.title1)
                        .foregroundColor(.white)
                    Text(subtitle)
                        .appFont(.paragraph2)
                        .foregroundColor(.white)
                    Spacer().height(24)
                    CapsuleButton(buttonTitle, action: {})
                        .disabled(true)
                        .frame(maxWidth: 176)
                        .if(tappable) { view in
                            view.showHint(.right, color: .white)
                        }
                }
                .padding(.horizontal, 32)
                .padding(.bottom, 64)
                Spacer()
            }
            .aspectRatio(3/4, contentMode: .fill)
        }
    }
    
    var backgroundView: some View {
        switch storyType {
        case .story(let image, _):
            return AnyView(
                Image(image)
                    .aspectFill()
                )
        case .video(let url):
            return AnyView(
                LoopingPlayer(assetUrl: url)
            )
        }
    }
    
}

struct DiscoverImageScroller: View {
    
    enum Size {
        case small, large
    }
    
    enum CarouselItem: Identifiable {
        
        var id: String {
            switch self {
            case .image(let appImage):
                return appImage.rawValue
            case .video(let assetUrl):
                return assetUrl.absoluteString
            }
        }
        
        case image(AppImage)
        case video(URL)
    }
    
    let items: [CarouselItem]
    let size: Size
    
    var isSmall: Bool { size == .small }

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(items) { item in
                    switch item {
                    case .image(let appImage):
                        Image(appImage)
                            .aspectFill()
                            .frame(width: isSmall ? 264 : 334, height: isSmall ? 180 : 445)
                            .clipped()
                    case .video(let assetUrl):
                        LoopingPlayer(assetUrl: assetUrl)
                            .frame(width: isSmall ? 264 : 334, height: isSmall ? 180 : 445)
                            .clipped()
                    }
                }
            }
        }
    }
    
}
