//
//  ShoppingHeaderView.swift
//  BootBarn_iOS_Demo
//
//  Created by happyMedium on 2/10/22.
//

import DesignSystem
import SwiftUI

struct ShoppingHeaderView: View {
    @AppStorage("bagCount") private var bagCount = 0
    @State private var isShowingSheet = false
    @EnvironmentObject var shoppingViewModel: ShoppingViewModel

    var buttonColor: Color { (shoppingViewModel.shoppingScreen == .category) ? .white : .black }
    var backgroundColor: Color { (shoppingViewModel.shoppingScreen == .productList) ? .white : .clear }

    var body: some View {
        HStack {
            leftItem
            centerItem
            Image(.bag)
                .overlay{
                    if bagCount > 0 {
                        Text("\(bagCount)")
                            .appFont(.paragraph3)
                            .offset(x: 1, y: 3)

                    }
                }
                .foregroundColor(buttonColor)
                .onTapGesture {
                    isShowingSheet.toggle()
                }
                .sheet(isPresented: $isShowingSheet) {
                    LowerToast(content: .bag)
                }
        }
        .frame(maxWidth: .infinity)
        .padding(.top, 36)
        .padding(.bottom, 4)
        .padding(.horizontal, 32)
        .background(backgroundColor)
    }
    
    var leftItem: some View {
        let backScreens: [ShoppingViewModel.ShoppingScreen] = [.productList, .productDetail]
        if backScreens.contains(shoppingViewModel.shoppingScreen) {
            return AnyView(
                Button(action: shoppingViewModel.backPressed) {
                    Image(.arrowLeft)
                        .foregroundColor(buttonColor)
                }
            )
        } else {
            return AnyView(
                Image(.search)
                    .foregroundColor(buttonColor)
            )
        }
    }
    
    var centerItem: some View {
        let titleScreens: [ShoppingViewModel.ShoppingScreen] = [.productList, .productDetail]
        guard titleScreens.contains(shoppingViewModel.shoppingScreen) else {
            return AnyView(Spacer())
        }
        
        return AnyView(
            HStack {
                VStack {
                    Text(shoppingViewModel.selectedCategory?.rawValue ?? "no category")
                        .appFont(.title2)
                        .textCase(.uppercase)
                    Text(shoppingViewModel.selectedSubcategory?.name ?? "no subcategory")
                        .appFont(.label4)
                }
            }
            .frame(maxWidth: .infinity, alignment: .center)
        )
    }
}

struct ShopView<Content: View, Background: View>: View {
    
    let content: Content
    let stack: Bool
    let background: Background

    init(@ViewBuilder content: (() -> Content), stack: Bool = false, @ViewBuilder background: (() -> Background)) {
        self.content = content()
        self.stack = stack
        self.background = background()
    }
    
    var body: some View {
        if stack {
            ZStack {
                HStack {
                    content
                }
                VStack {
                    ShoppingHeaderView()
                    Spacer()
                }
            }
            .navigationBarHidden(true)
            .background(background)
        } else {
            VStack {
                ShoppingHeaderView()
                HStack {
                    content
                }
            }
            .navigationBarHidden(true)
            .background(background)
        }
    }
    
}

extension ShopView where Background == Color {
    init(@ViewBuilder content: (() -> Content), stack: Bool = false) {
        self.init(content: content, stack: stack, background: { Color.white })
    }
}

struct ShoppingHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        ShoppingHeaderView()
    }
}
