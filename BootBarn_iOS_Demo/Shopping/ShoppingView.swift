//
//  ShoppingView.swift
//  BootBarn_iOS_Demo
//
//  Created by happyMedium on 2/6/22.
//

import CommonUtilities
import DesignSystem
import SwiftUI

struct ShoppingView: View {
    
    var body: some View {
        NavigationView {
            CategoryListView()
        }
        .navigationViewStyle(.stack)
    }
    
}

struct CategoryListView: View {
    
    @EnvironmentObject var shoppingViewModel: ShoppingViewModel
    
    var body: some View {
        ShopView {
            HStack {
                list
                Spacer()
            }
            .ignoresSafeArea(.all, edges: .all)
            .padding(.horizontal, 32)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        } background: {
            Image(.fullScreenCategorySelect)
                .resizable()
                .ignoresSafeArea(.all, edges: .top)
        }
    }
    
    var list: some View {
        VStack(alignment: .leading, spacing: 40) {
            ForEach(ShoppingCategory.allCases) { category in
                NavigationLink(
                    tag: category,
                    selection: $shoppingViewModel.selectedCategory,
                    destination: { StyleScrollView() },
                    label: {
                        Text(category.rawValue.capitalized)
                            .appFont(.title1)
                            .foregroundColor(.white)
                    })
                    .happyPath(pathItem: category, location: .right, color: .white)
            }
        }
    }
    
}

struct ShoppingView_Previews: PreviewProvider {
    static var previews: some View {
        ShoppingView()
    }
}
