//
//  PDPView.swift
//  BootBarn_iOS_Demo
//
//  Created by happyMedium on 2/9/22.
//

import CommonUtilities
import DesignSystem
import SwiftUI

let lorem: String = """
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec tempor placerat dolor sit amet aliquam. Vestibulum eu magna metus. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Nullam quis ipsum ex.
"""

enum SampleProduct { case boot, skirt }

class ProductViewModel: ObservableObject {
    
    init(for sample: SampleProduct) {
        self.selectedDeliveryMethod = deliveryOptions.first!
        switch sample {
        case .boot:
            self.name = "El Dorado Men's Rust Bison Western Boots - Broad Square Toe"
            self.price = "369.99"
            self.productImages = [.pdp1_1, .pdp1_2, .pdp1_3, .pdp1_4, .pdp1_5, .pdp1_6]
            self.recentlyViewedItems = [
                .init(
                    appImage: .recentlyViewedBootPDP_1,
                    name: "Cody James Men's Respect Earned Graphic Short Sleeve T-Shirt",
                    price: "19.99"
                ),
                .init(
                    appImage: .recentlyViewedBootPDP_2,
                    name: "Pendleton Men's Solid Navy Quilted Canvas Snap-Front Shirt Jacket",
                    price: "99.00"
                ),
                .init(
                    appImage: .recentlyViewedBootPDP_3,
                    name: "Cody James Men's Dark Wash Courtright Stretch Slim Straight Jeans",
                    price: "49.00"
                )
            ]
        case .skirt:
            self.name = "Tasha Polizzi Women's Lydia Serape Sequin A-Line Skirt"
            self.price = "139.00"
            self.productImages = [.pdp2_1, .pdp2_2, .pdp2_3, .pdp2_4]
            self.recentlyViewedItems = [
                .init(
                    appImage: .recentlyViewedSkirtPDP_1,
                    name: "Shyanne Women's Ivory & Pecan Southwestern Sweater Midi Skirt",
                    price: "19.99"
                ),
                .init(
                    appImage: .recentlyViewedSkirtPDP_2,
                    name: "Wishlist Women's Olive Side Button Corduroy Mini Skirt",
                    price: "99.00"
                ),
                .init(
                    appImage: .recentlyViewedSkirtPDP_3,
                    name: "Wrangler Women's Tan Utility Pants Slim",
                    price: "49.00"
                )
            ]
        }
    }
    
    let productImages: [AppImage]
    let recentlyViewedItems: [FeaturedItem]
    
    let name: String
    let price: String
    @Published var favorite: Bool = false
    
    let colorOptions: [Color] = Color.productColorOptions
    @Published var selectedColor: Color = Color.productColorOptions.first!
    
    let sizes: [String] = [
        "8 D", "8 1/2 D", "9 D", "9 1/2 D", "10 D", "10 1/2 D", "11 D", "12 D"
    ]
    
    @Published var selectedSize: String?
    
    @Published var selectedDeliveryMethod: DeliveryOption
    
    struct DeliveryOption: Identifiable, Equatable {
        let id: UUID = UUID()
        let image: AppImage
        let title: String
    }
    
    let deliveryOptions: [DeliveryOption] = [
        .init(image: .pickup, title: "Curbside"),
        .init(image: .inStore, title: "In-Store"),
        .init(image: .shipping, title: "Shipping")
    ]
    
    @Published var currentAccordion: String?
    let accordionSections: [String] = [
        "Virtual Try On", "Description", "Delivery & Returns", "Reviews"
    ]
    
    @Published var currentImage: Image? = nil
    @Published var showingZoomScroller: Bool = false
    
}

struct PDPView: View {
    
    @StateObject private var product: ProductViewModel
    @State private var isShowingSheet = false
    @Namespace var namespace
    @State var imageIndex: Int = 0

    init(sampleProduct: SampleProduct) {
        _product = StateObject(wrappedValue: ProductViewModel(for: sampleProduct))
    }
    
    var body: some View {
        if product.showingZoomScroller {
            ZoomedProductImageScroller(product: product, namespace: namespace, imageIndex: $imageIndex)
        } else {
            ShopView(content: { mainView })
        }
    }
    
    var mainView: some View {
        ZStack {
            ScrollView {
                VStack(spacing: 0) {
                    ProductImageScroller(namespace: namespace, imageIndex: $imageIndex)
                    VStack(alignment: .leading, spacing: 0) {
                        Group {
                            titleSection
                            PDPSeparator()
                            colorSection
                            PDPSeparator()
                            sizeSection
                            PDPSeparator(bottom: 24)
                            deliverySection
                            accordionSection
                            PDPSeparator(top: 24, bottom: 24)
                            rewardSection
                        }
                        Group {
                            PDPSeparator(top: 24, bottom: 64)
                            recentlyViewedSection
                            Spacer().height(200)
                        }
                    }
                    .padding([.top, .horizontal], 32)
                }
            }
            .ignoresSafeArea(.all, edges: .top)
            .environmentObject(product)
            PDPBottomButtons()
        }
    }
    
    var titleSection: some View {
        VStack(alignment: .leading, spacing: 24) {
            HStack(spacing: 20) {
                Text(product.name)
                    .appFont(.paragraph1)
                Button {
                    UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                    withAnimation(.easeInOut(duration: 0.25)) {
                        product.favorite.toggle()
                    }
                } label: {
                    Image(product.favorite ? .heartFilled : .heart)
                        .foregroundColor(.black)
                }

            }
            Text(product.price)
                .appFont(.title2)
        }
    }
    
    var colorSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Color")
                .appFont(.label3)
            ColorSelectionView()
                .padding(.leading, 4)
        }
    }
    
    var sizeSection: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Size")
                .appFont(.label3)
            SizeSelector()
        }
    }
    
    var deliverySection: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text("south county store")
                    .appFont(.label2)
                Spacer()
                SimpleButton("Change") {}
            }
            DeliverySelector()
        }
    }
    
    var accordionSection: some View {
        Group {
            PDPSeparator(top: 24, bottom: 24)
            AccordionItem(title: "Virtual Try On", body: lorem, linkOut: true)
            PDPSeparator(top: 24, bottom: 24)
            AccordionItem(title: "Description", body: lorem)
            PDPSeparator(top: 24, bottom: 24)
            AccordionItem(title: "Delivery & Returns", body: lorem)
            PDPSeparator(top: 24, bottom: 24)
            AccordionItem(title: "Reviews", body: lorem)
        }
    }
    
    var rewardSection: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("B Rewarded")
                .appFont(.label2)
            Text("Members earn up to 50 points on this item.")
                .appFont(.paragraph1)
            Spacer().height(8)
            SimpleButton("Learn More") {}
        }
    }
    
    var recentlyViewedSection: some View {
        VStack(alignment: .leading, spacing: 32) {
            Text("recently viewed")
                .appFont(.title1)
            RecentlyViewedScroll()
        }
    }
    
}

struct ColorSelectionView: View {
    
    @EnvironmentObject var product: ProductViewModel
    
    var body: some View {
        HStack(spacing: 16) {
            ForEach(product.colorOptions, id: \.self) { color in
                Circle()
                    .frame(width: 24, height: 24)
                    .foregroundColor(color)
                    .if(product.selectedColor == color) {
                        $0.overlay(
                            Circle()
                                .strokeBorder(.black, lineWidth: 1)
                                .frame(width: 32, height: 32)
                                .foregroundColor(.clear)
                        )
                    }
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 0.25)) {
                            product.selectedColor = color
                        }
                    }
            }
            Spacer()
        }
    }
}

struct SizeSelector: View {
    
    @EnvironmentObject var product: ProductViewModel
    
    let columns: [GridItem] = [
        GridItem(.flexible(minimum: 72, maximum: 200), spacing: 8),
        GridItem(.flexible(minimum: 72, maximum: 200), spacing: 8),
        GridItem(.flexible(minimum: 72, maximum: 200), spacing: 8),
        GridItem(.flexible(minimum: 72, maximum: 200), spacing: 8)
    ]

    var body: some View {
        LazyVGrid(columns: columns) {
            ForEach(product.sizes, id: \.self) { size in
                Text(size)
                    .appFont(.paragraph1)
                    .frame(maxWidth: .infinity, minHeight: 44, idealHeight: 44)
                    .background {
                        Rectangle()
                            .foregroundColor(
                                size == product.selectedSize ? .white : .bootLightGray
                            )
                    }
                    .if(size == product.selectedSize) {
                        $0.border(.black, width: 1)
                    }
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 0.2)) {
                            product.selectedSize = size
                        }
                    }
            }
        }
    }
    
}

struct DeliverySelector: View {
    
    @EnvironmentObject var product: ProductViewModel
    @State private var isShowingSheet = false

    let columns: [GridItem] = [
        GridItem(.flexible(minimum: 0, maximum: 200), spacing: 8),
        GridItem(.flexible(minimum: 0, maximum: 200), spacing: 8),
        GridItem(.flexible(minimum: 0, maximum: 200), spacing: 0)
    ]
    
    @State var cellHeight: CGFloat? = nil
    
    var body: some View {
        LazyVGrid(columns: columns) {
            ForEach(product.deliveryOptions) { method in
                DeliveryMethodView(method: method, isShowingSheet: $isShowingSheet)
                    .frame(minHeight: cellHeight)
                    .overlay(DetermineHeight())
                    .if(method.image == .shipping) { view in
                        view
                            .disabled(true)
                            .opacity(0.5)
                    }
            }
        }
        .padding(.horizontal, 0)
        .onPreferenceChange(DetermineHeight.Key.self) {
            cellHeight = $0
        }
    }
    
    struct DeliveryMethodView: View {
        
        @EnvironmentObject var product: ProductViewModel

        let method: ProductViewModel.DeliveryOption
        @Binding var isShowingSheet: Bool

        var body: some View {
            VStack(alignment: .leading, spacing: 4) {
                Image(method.image)
                Text(method.title)
                    .appFont(.label3)
                    .frame(maxWidth: .infinity, alignment: .leading)
                let availableText: String = (method.image == .shipping) ? "Not Available" : "Pick Up Today"
                Text(availableText)
                    .appFont(.paragraph2)
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .padding([.horizontal, .bottom], 8)
            .padding(.top, 10)
            .background {
                Rectangle()
                    .foregroundColor(
                        method == product.selectedDeliveryMethod ? .white : .bootLightGray
                    )
            }
            .if(method == product.selectedDeliveryMethod) {
                $0.border(.black, width: 1)
            }
            .onTapGesture {
                withAnimation(.easeInOut(duration: 0.2)) {
                    product.selectedDeliveryMethod = method
                }
                isShowingSheet.toggle()
            }
            .sheet(isPresented: $isShowingSheet) {
                LowerToast(content: .delivery)
            }
        }
    }

}

struct AccordionItem: View {
    
    @EnvironmentObject var product: ProductViewModel
    
    let title: String
    let bodyText: String
    let linkOut: Bool
    
    init(title: String, body: String, linkOut: Bool = false) {
        self.title = title
        self.bodyText = body
        self.linkOut = linkOut
    }
    
    private var showing: Bool {
        self.title == product.currentAccordion
    }
    
    var body: some View {
        VStack(spacing: 16) {
            HStack {
                Text(title)
                    .appFont(.label2)
                Spacer()
                Button(action: tappedChevron) {
                    if linkOut {
                        Image(.arrowCircleRight)
                            .foregroundColor(.black)
                    } else {
                        Image(showing ? .arrowUp : .arrowDown)
                            .foregroundColor(.black)
                    }
                }
            }
            
            if showing {
                Text(bodyText)
            }
        }
    }
    
    func tappedChevron() {
//        withAnimation(.easeInOut(duration: 0.25)) {
//            if showing {
//                product.currentAccordion = nil
//            } else {
//                product.currentAccordion = title
//            }
//        }
    }
    
}

struct RecentlyViewedScroll: View {
    
    @EnvironmentObject var product: ProductViewModel
    
    var body: some View {
        FeaturedProductScroller(items: product.recentlyViewedItems)
            .padding(.horizontal, -32) //hacky way to make scrollview not clip
    }
    
    
}

struct PDPSeparator: View {
    
    let topPadding: CGFloat
    let bottomPadding: CGFloat

    init(top topPadding: CGFloat = 48, bottom bottomPadding: CGFloat = 32) {
        self.topPadding = topPadding
        self.bottomPadding = bottomPadding
    }
    
    public var body: some View {
        Rectangle()
            .height(1)
            .foregroundColor(.black)
            .padding(.top, topPadding)
            .padding(.bottom, bottomPadding)
    }
}

struct PDPBottomButtons: View {

    @AppStorage("bagCount") private var bagCount = 0

    var body: some View {
        VStack {
            Spacer()
            HStack(spacing: 8) {
                PrimaryButton("Add to bag") {
                    UIImpactFeedbackGenerator().impactOccurred()
                    bagCount += 1
                }
                SecondaryButton("Pay", image: .leading(.appleIcon)) {}
            }
            .padding(.vertical, 16)
            .padding(.horizontal, 24)
            .background(Color.bootLightGray)
        }
    }
    
}

struct PDPView_Previews: PreviewProvider {
    static var previews: some View {
        PDPView(sampleProduct: .boot)
    }
}
