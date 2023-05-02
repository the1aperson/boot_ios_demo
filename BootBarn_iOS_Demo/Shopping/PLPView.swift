//
//  PLPView.swift
//  BootBarn_iOS_Demo
//
//  Created by happyMedium on 2/8/22.
//

import CommonUtilities
import DesignSystem
import SwiftUI

struct PLPView: View {
    
    @EnvironmentObject var shoppingViewModel: ShoppingViewModel
    
    let columns: [GridItem] = [
        GridItem(.flexible(minimum: 0, maximum: 400), spacing: 32),
        GridItem(.flexible(minimum: 0, maximum: 400), spacing: 32)
    ]
    
    @State private var cellHeight: CGFloat?
    @State private var isShowingSheet: Bool = false
    @State private var favoriteProducts: [Product] = []
    
    var body: some View {
        ShopView {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 48) {
                    Section {
                        ForEach(shoppingViewModel.products) { product in
                            NavigationLink(
                                tag: product,
                                selection: $shoppingViewModel.currentProduct,
                                destination: { PDPView(sampleProduct: .boot) },
                                label: { ProductItemView(product: product, cellHeight: $cellHeight, isShowingSheet: $isShowingSheet) }
                            )
                            .happyPath(pathItem: product, location: .bottomRight, color: .black)
                            .foregroundColor(.black)
                            .overlay(alignment: .topTrailing) {
                                Button(action: {
                                    UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                                    toggleProductFavorite(product)
                                    isShowingSheet.toggle()
                                }) {
                                    Image(favoriteProducts.contains(product) ? .heartFilled : .heart)
                                        .padding([.top, .trailing], 12)
                                }
                            }
                        }
                    } header: {
                        plpHeader
                    }
                }
                .padding(.top, 12)
                .padding(.horizontal, 32)
                .padding(.bottom, 32)
                .onPreferenceChange(DetermineHeight.Key.self) {
                    cellHeight = $0
                }
            }
            .sheet(isPresented: $isShowingSheet) {
                LowerToast(content: .wishlist)
            }
        }
    }
    
    var plpHeader: some View {
        Image(.filters)
            .height(40)
            .width(40)
    }
    
    /// Warning: Fragile!!
    struct ProductItemView: View {
        
        let product: Product
        @Binding var cellHeight: CGFloat?
        @Binding var isShowingSheet: Bool
        
        var body: some View {
            VStack(alignment: .leading, spacing: 0) {
                Image(product.image)
                    .resizable()
                    .aspectRatio(3/4, contentMode: .fill)
                    .foregroundColor(.bootDarkGray)
                
                Spacer().height(16)
                
                Text(product.name)
                    .appFont(.paragraph3)
                    .layoutPriority(1)
                    .multilineTextAlignment(.leading)
                    .lineLimit(3)
                
                Spacer()
                    .layoutPriority(0.9)
                
                Text(product.price)
                    .appFont(.title2)
            }
            .frame(minHeight: cellHeight)
            .overlay(DetermineHeight())
        }
        
    }
    
    func toggleProductFavorite(_ product: Product) {
        if favoriteProducts.contains(product) {
            favoriteProducts.removeAll(where: { $0.name == product.name })
        } else {
            favoriteProducts.append(product)
        }
    }
    
}

//struct PLPView_Previews: PreviewProvider {
//    static var previews: some View {
//        PLPView()
//            .environmentObject(ShoppingViewModel())
//    }
//}
