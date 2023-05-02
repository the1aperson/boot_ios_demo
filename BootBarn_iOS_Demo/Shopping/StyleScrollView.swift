//
//  StyleScrollView.swift
//  BootBarn_iOS_Demo
//
//  Created by happyMedium on 2/9/22.
//

import CommonUtilities
import DesignSystem
import SwiftUI

struct StyleScrollView: View {
    
    @EnvironmentObject var shoppingViewModel: ShoppingViewModel
    @Namespace var namespace

    var body: some View {
        ShopView {
            VStack(spacing: 48) {
                ShopSubHeader()

                if shoppingViewModel.selectedStyle == nil {
                    scrollBody
                } else {
                    subcategoryListView
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                }

                Spacer()
            }
        }
    }
    
    let pageWidth: CGFloat = 250
    let pageSpacing: CGFloat = 24
    @State var index: Int = 0
    @State var offset: CGFloat = 0
    
    var scrollBody: some View {
        let pages: [StyleScrollViewItem] = shoppingViewModel.styleItems.map { styleItem in
            StyleScrollViewItem(item: styleItem, namespace: namespace, onTap: { selectStyle(styleItem) })
        }
        
        return VStack {
            PagerView(pages: pages, pageWidth: pageWidth, pageSpacing: 24, index: $index, offset: $offset)
                .layoutPriority(1)
            Spacer().frame(maxHeight: 100)
            scrollProgressBar
                .animation(.default, value: index)
        }
    }
    
    let horizontalPadding: CGFloat = 32
    @State private var progressMaxWidth: CGFloat?
    private var progressWidth: CGFloat {
        guard let progressMaxWidth = progressMaxWidth else { return 0 }
        let currentIndex = index + 1
        let percent: CGFloat = CGFloat(currentIndex) / CGFloat(shoppingViewModel.styleItems.count)
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
    
    var subcategoryListView: some View {
        VStack(spacing: 64) {
            VStack(spacing: 32) {
                Text(shoppingViewModel.selectedStyle?.name ?? "Style")
                    .appFont(.label1)
                    .matchedGeometryEffect(id: "\(shoppingViewModel.selectedStyle?.name ?? "Style").label", in: namespace)
                Rectangle()
                    .foregroundColor(.black)
                    .width(60)
                    .height(2)
            }
            
            VStack(spacing: 24) {
                ForEach(shoppingViewModel.subcategories, id: \.name) { subcat in
                    NavigationLink(
                        tag: subcat,
                        selection: $shoppingViewModel.selectedSubcategory,
                        destination: { PLPView() },
                        label: {
                            Text(subcat.name)
                                .appFont(.label3)
                                .foregroundColor(.black)
                        })
                        .happyPath(pathItem: subcat, location: .right, color: .black)
                }
            }
        }
    }
    
    func selectStyle(_ style :StyleItem) {
        withAnimation(.easeInOut(duration: 0.25)) {
            shoppingViewModel.selectedStyle = style
        }
    }
}

struct ShopSubHeader: View {
    
    @EnvironmentObject var shoppingViewModel: ShoppingViewModel
    
    let arrowWidth: CGFloat = 67
    
    var body: some View {
        HStack {
            Button(action: {
                withAnimation(.easeIn(duration: 0.25)) {
                    shoppingViewModel.backPressed()
                }
            }, label: {
                Image(.longArrow)
                    .foregroundColor(.black)
                    .frame(width: arrowWidth, height: 8)
                    .layoutPriority(0.1)
            })
            Text(shoppingViewModel.selectedCategory?.rawValue ?? "")
                .appFont(.title1)
                .foregroundColor(.black)
                .frame(maxWidth: .infinity)
                .layoutPriority(1)
            Spacer()
                .frame(maxWidth: .infinity)
                .layoutPriority(0.1)
                .width(arrowWidth)
        }
        .padding(.top, 12)
        .padding(.horizontal, 36)
    }
}

struct StyleScrollViewItem: View, Identifiable {
    
    let id: UUID = UUID()
    
    var item: StyleItem
    let namespace: Namespace.ID
    let onTap: Action
    
    var body: some View {
        VStack {
            Image(item.appImage)
                .resizable()
                .width(250)
                .aspectRatio(3/4, contentMode: .fit)
            Text(item.name)
                .appFont(.label1)
                .matchedGeometryEffect(id: "\(item.name).label", in: namespace)
        }
        .onTapGesture(perform: onTap)
        .happyPath(pathItem: item, location: .topRight, color: .black)
    }
    
}

//struct StyleScrollView_Previews: PreviewProvider {
//    static var previews: some View {
//        StyleScrollView()
//    }
//}
