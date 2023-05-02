//
//  HomeView.swift
//  BootBarn_iOS_Demo
//
//  Created by happyMedium on 2/13/22.
//

import AVKit
import CommonUtilities
import DesignSystem
import SwiftUI

class HomeViewModel: ObservableObject {
    
    struct Category {
        let image: AppImage
        let name: String
    }
    
    let categories: [Category] = [
        .init(image: .homeCategory1, name: "men's western"),
        .init(image: .homeCategory2, name: "women's wonderwest"),
        .init(image: .homeCategory3, name: "women's western"),
        .init(image: .homeCategory4, name: "men's work")
    ]
    
    let newDealItems: [FeaturedItem] = [
        .init(appImage: .homeNewDeals1, name: "Cody James Men's Barn Sour Dark Wash Stretch Slim Straight Jeans", price: "49.00"),
        .init(appImage: .homeNewDeals2, name: "Cody James Men's Dark Wash Courtright Stretch Slim Straight Jeans", price: "49.00"),
        .init(appImage: .homeNewDeals3, name: "Shyanne Women's Charcoal Logo Sleeve Zip-Front Softshell Jacket", price: "69.99"),
        .init(appImage: .homeNewDeals4, name: "Cody James Men's Crupper Light Wash Stretch Slim Straight Jeans", price: "49.00"),
        .init(appImage: .homeNewDeals5, name: "Shyanne Women's Gold Southwestern Print Zip-Front Softshell Riding Jacket", price: "69.99"),
    ]
    
    let wonderWestItems: [FeaturedItem] = [
        .init(appImage: .homeWonderWest1, name: "Circle S Women's Faux Shearling Leopard Overcoat", price: "109.99"),
        .init(appImage: .homeWonderWest2, name: "Free People Women's Black Spitfire Stacked Faux Leather Skinny Pants", price: "98.00"),
        .init(appImage: .homeWonderWest3, name: "Molly Bracken Women's Black All-Over Lace Mock Neck Long Sleeve Top", price: "39.00"),
        .init(appImage: .homeWonderWest4, name: "Idyllwind Women's Meet Me At The Rodeo Crossbody", price: "89.50"),
        .init(appImage: .homeWonderWest5, name: "Wild Moss Women's Lace Button Front Sheer Long Sleeve Shirt", price: "39.99"),
    ]
    
    let topLoopingVideo: URL = Bundle.main.url(forResource: "home_topLoopingBanner", withExtension: "mp4")!
    let loopingBanner: URL = Bundle.main.url(forResource: "home_banner_2", withExtension: "mp4")!
   
    @Published var feedbackQuestion: Bool = false

    func showFeedback() {
        let currentCount = UserDefaults.standard.integer(forKey: "launchCount")
        UserDefaults.standard.set(currentCount+1, forKey: "launchCount")
        if currentCount == 2 {
            feedbackQuestion = true
        }
    }
    
    @Published var showingSkirt: Bool = false
}

struct HomeView: View {

    @EnvironmentObject var appState: AppState
    @EnvironmentObject var homeVM: HomeViewModel
    @State private var feedbackRating: Bool = false
    @State private var feedbackToast: Bool = false
    @State var isEnjoying: Bool = false
    
    var body: some View {
        NavigationView {
            main
                .navigationBarHidden(true)
                .edgesIgnoringSafeArea(.top)
                .background {
                    GeometryReader { geo in
                        VStack {
                            LoopingPlayer(assetUrl: homeVM.topLoopingVideo)
                                .frame(
                                    width: geo.size.width,
                                    height: geo.size.width / 1.75
                                )
                                .aspectRatio(1.75, contentMode: .fill)
                            Spacer()
                        }
                        .ignoresSafeArea(.all, edges: .top)
                    }
                }
        }
        .onAppear {
            appState.showFeedback()
        }
    }
    
    var main: some View {
        ScrollView {
            LazyVStack(spacing: 0) {
                Color.clear
                    .aspectRatio(1.75, contentMode: .fill)
                Spacer().height(48) //clear spacer allows some give before video is covered
                Group {
                    HomeFeaturedSection(title: "New Deals", items: homeVM.newDealItems)
                        //use padding here instead of spacers to aid scroll over looping video
                        .padding(.top, 32)
                        .padding(.bottom, 128)
                    Image(.homeBanner1)
                        .aspectFill()
                        .aspectRatio(4/5, contentMode: .fill)
                    Spacer().height(80)
                    CategoriesGrid()
                    Spacer().height(128)
                    TrendingList()
                    Spacer().height(128)
                }
                .background(.white)
                Group {
                    let t = $homeVM.showingSkirt
                    NavigationLink(
                        isActive: t,
                        destination: {
                            PDPView(sampleProduct: .skirt)
                                .environmentObject(ShoppingViewModel(skirt: true, navBinding: $homeVM.showingSkirt))
                        }) {
                            LoopingPlayer(assetUrl: homeVM.loopingBanner)
                                .aspectRatio(4/5, contentMode: .fill)
                                .showHint(.topRight, color: .black)
                        }
                    Spacer().height(80)
                    HomeFeaturedSection(title: "Wonderwest", items: homeVM.wonderWestItems)
                    Spacer().height(68)
                }
                .background(.white)
            }
            .padding(.bottom, 60)
            .fullScreenCover(isPresented: $homeVM.feedbackQuestion, onDismiss: {
                if isEnjoying {
                    feedbackRating.toggle()
                } else {
                    feedbackToast.toggle()
                }
            }) {
                FeedbackQuestion(answer: $isEnjoying)
                    .background(.black.opacity(0.75))
            }
            .fullScreenCover(isPresented: $feedbackRating, onDismiss: {
                feedbackToast.toggle()
            }) {
                FeedbackRating(rating: 0)
                    .background(.black.opacity(0.75))
            }
            .sheet(isPresented: $feedbackToast) {
                LowerToast(content: .feedback)
            }
        }
    }
}

struct HomeFeaturedSection: View {
    
    let title: String
    let items: [FeaturedItem]
    
    var body: some View {
        VStack(spacing: 32) {
            HomeSectionHeader(title: title)
            FeaturedProductScroller(items: items)
        }
    }
    
}

struct CategoriesGrid: View {
    
    @EnvironmentObject var vm: HomeViewModel
    @State private var isShowingSheet: Bool = false
    
    let columns: [GridItem] = [
        GridItem(.flexible(minimum: 0, maximum: 400), spacing: 32),
        GridItem(.flexible(minimum: 0, maximum: 400), spacing: 32)
    ]

    var body: some View {
        VStack(spacing: 32) {
            HomeSectionHeader(title: "Categories", happyPath: true)
            LazyVGrid(columns: columns, spacing: 32) {
                ForEach(vm.categories, id: \.name) { category in
                    CategoryGridItem(appImage: category.image, title: category.name)
                        .onTapGesture {
                            isShowingSheet = true
                        }
                }
            }
            .padding(.horizontal, 32)
        }
        .sheet(isPresented: $isShowingSheet) {
            LowerToast(content: .category)
        }
        

    }
    
    struct CategoryGridItem: View {

        let appImage: AppImage
        let title: String
        
        var body: some View {
            ZStack {
                Image(appImage)
                    .aspectFill()
                    .overlay {
                        LinearGradient(
                            gradient: Gradient(colors: [.clear, .black]),
                            startPoint: .init(x: 0.5, y: 0.25), endPoint: .bottom
                        ).opacity(0.75)
                    }
                    .clipped()
                VStack {
                    Spacer()
                    Text(title)
                        .appFont(.caption1)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                }
                .padding(.horizontal, 12)
                .padding(.bottom, 8)
            }
            .aspectRatio(0.75, contentMode: .fill)
        }
    }
    
}

struct HomeSectionHeader: View {
    
    let title: String
    let happyPath: Bool
    
    init(title: String, happyPath: Bool = false) {
        self.title = title
        self.happyPath = happyPath
    }
    
    var body: some View {
        VStack {
            HStack {
                Text(title)
                    .appFont(.title1)
                    .if(happyPath) { view in
                        view.showHint(.right, color: .black)
                    }
                Spacer()
                SimpleButton("Shop All", action: {})
            }
            .padding(.horizontal, 32)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
