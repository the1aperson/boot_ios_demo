//
//  ImageScroller.swift
//  BootBarn_iOS_Demo
//
//  Created by Matt Gannon on 2/18/22.
//

import SwiftUI

struct ProductImageScroller: View {
    
    @EnvironmentObject var product: ProductViewModel
    let namespace: Namespace.ID
    @Binding var imageIndex: Int

    var body: some View {
        TabView(selection: $imageIndex) {
            ForEach(product.productImages, id: \.self) {
                Image($0).resizable()
                    .onTapGesture {
                        withAnimation {
                            product.showingZoomScroller = true
                        }
                    }
                    .matchedGeometryEffect(id: $0.rawValue, in: namespace)
                    .tag(product.productImages.firstIndex(of: $0) ?? 0)
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .always))
        .aspectRatio(3/4, contentMode: .fill)
    }
}

struct ZoomedProductImageScroller: View {
    
    @ObservedObject var product: ProductViewModel
    let namespace: Namespace.ID
    @Binding var imageIndex: Int

    var body: some View {
        TabView(selection: $imageIndex) {
            ForEach(product.productImages, id: \.self) {
                Image($0)
                    .aspectFit()
                    .matchedGeometryEffect(id: $0.rawValue, in: namespace)
                    .tag(product.productImages.firstIndex(of: $0) ?? 0)
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .always))
        .ignoresSafeArea(.all, edges: .top)
        .navigationBarHidden(true)
        .background(Color.bootLightGray)
        .overlay(alignment: .topTrailing) {
            Button {
                withAnimation {
                    product.showingZoomScroller = false
                }
            } label: {
                Image(.exit)
                    .padding(.top, 40)
                    .padding(.trailing, 20)
            }
        }
    }
}
