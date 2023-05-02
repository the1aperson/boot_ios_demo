//
//  ShoppingViewModel.swift
//  BootBarn_iOS_Demo
//
//  Created by happyMedium on 2/9/22.
//

import DesignSystem
import SwiftUI

enum ShoppingCategory: String, CaseIterable, Identifiable, HappyPath {
    
    var id: String { self.rawValue }
    
    case men,
         women,
         kids,
         boots,
         country,
         work,
         gifts,
         sale
    
    var happyPath: Bool {
        return self == .men
    }
}

struct Product: Identifiable, Hashable, HappyPath {
    let id: UUID = .init()
    let image: AppImage
    let name: String
    let price: String
    let happyPath: Bool
    let sampleProduct: SampleProduct
    
    init(image: AppImage, name: String, price: String, happyPath: Bool = false, sampleProduct: SampleProduct = .boot) {
        self.image = image
        self.name = name
        self.price = price
        self.happyPath = happyPath
        self.sampleProduct = sampleProduct
    }
}

struct StyleItem: Hashable, HappyPath {
    var appImage: AppImage
    var name: String
    var happyPath: Bool
    
    init(appImage: AppImage, name: String, happyPath: Bool = false) {
        self.appImage = appImage
        self.name = name
        self.happyPath = happyPath
    }
}

struct Subcategory: Hashable, HappyPath {
    let name: String
    let happyPath: Bool
    
    init(name: String, happyPath: Bool = false) {
        self.name = name
        self.happyPath = happyPath
    }
}

class ShoppingViewModel: ObservableObject {
    
    let styleItems: [StyleItem] = [
        .init(appImage: .westernBoots, name: "Western Boots", happyPath: true),
        .init(appImage: .workBoots, name: "Work Boots"),
        .init(appImage: .hikingBoots, name: "Hiking Boots"),
        .init(appImage: .shirts, name: "Shirts"),
        .init(appImage: .outerwear, name: "Outerwear"),
        .init(appImage: .jeansAndPants, name: "Jeans and Pants"),
        .init(appImage: .workwear, name: "Workwear"),
        .init(appImage: .hats, name: "Hats"),
        .init(appImage: .accessories, name: "Accessories")
    ]
    
    let subcategories: [Subcategory] = [
        Subcategory(name: "All Western Boots"),
        Subcategory(name: "Best Sellers"),
        Subcategory(name: "Cowboy Boots", happyPath: true),
        Subcategory(name: "Handcrafted Boots"),
        Subcategory(name: "Dress Boots"),
        Subcategory(name: "Exotic Boots"),
        Subcategory(name: "Casual Boots")
    ]
    
    let products: [Product] = [
        .init(image: .plp1, name: "El Dorado Men's Bay Western Boots Broad Square Toe", price: "329.99"),
        .init(image: .plp2, name: "Cody James Men's Tan Western Boots Square Toe", price: "149.99"),
        .init(image: .plp3, name: "El Dorado Men's Sahara Western Boots Round Toe", price: "379.99"),
        .init(image: .plp4, name: "El Dorado Men's Rust Bison Western Boots - Broad Square Toe", price: "369.99", happyPath: true),
        .init(image: .plp5, name: "El Dorado Men's Exotic Full-Quill Ostrich Skin Western Boots Round Toe", price: "549.99"),
        .init(image: .plp6, name: "Moonshine Spirit Men's Mad Cat Western Boots Narrow Square Toe", price: "189.99"),
        .init(image: .plp7, name: "Justin Men's Bent Rail Cowboy Boots Square Toe", price: "249.99"),
        .init(image: .plp8, name: "Nocona Men's Turner Chocolate Western Boots Wide Square Toe", price: "169.95")
    ]
    
    let skirtProduct: Product = .init(image: .plp1, name: "Skirt", price: "1", happyPath: true, sampleProduct: .skirt)
    
    enum ShoppingScreen: String {
        case category, style, subcategory, productList, productDetail
    }
    
    var shoppingScreen: ShoppingScreen {
        if selectedCategory == nil {
            return .category
        } else if selectedStyle == nil {
            return .style
        } else if selectedSubcategory == nil {
            return .subcategory
        } else if currentProduct == nil {
            return .productList
        } else {
            return .productDetail
        }
    }
    
    @Published var selectedCategory: ShoppingCategory?
    @Published var selectedStyle: StyleItem?
    @Published var selectedSubcategory: Subcategory?
    @Published var currentProduct: Product?
    
    func showPdp(_ sampleProduct: SampleProduct) {
        // Oh god I'm sorry this is horrendous but it's the only way it would work consistently
        // SwiftUI doesn't offer a way of diving multiple levels into a navigation view,
        // so we just have to slightly delay each change so it quickly pops to the next one
        // SwiftUI + Navigation == :(
        
        // The PDP would pop back to PLP if you tried to jump in while the view was
        // at the subcategory selection state, so this is a catch to fix that
        if shoppingScreen == .subcategory {
            self.selectedCategory = .women
            self.selectedStyle = self.styleItems[5]
            self.selectedSubcategory = self.subcategories[2]
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                self.currentProduct = self.products[1]
            }
            return
        }
        
        self.selectedCategory = .women
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
            self.selectedStyle = self.styleItems[5]
            self.selectedSubcategory = self.subcategories[2]
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                self.currentProduct = self.products[1]
//                self.currentProduct = self.skirtProduct
            }
        }
    }
    
    func backPressed() {
        
        if navBinding != nil {
            navBinding?.wrappedValue = false
            return
        }
        
        if currentProduct != nil {
            currentProduct = nil
        } else if selectedSubcategory != nil {
            selectedSubcategory = nil
        } else if selectedStyle != nil {
            selectedStyle = nil
        } else {
            selectedCategory = nil
        }
    }
    
    var navBinding: Binding<Bool>?
    init(skirt: Bool = false, navBinding: Binding<Bool>? = nil) {
        if skirt {
            self.selectedCategory = .women
            self.selectedStyle = self.styleItems[5]
            self.selectedSubcategory = Subcategory(name: "Dresses & Skirts")
        }
        
        self.navBinding = navBinding
    }
    
}

