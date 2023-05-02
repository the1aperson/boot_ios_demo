//
//  ShopLookView.swift
//  BootBarn_iOS_Demo
//
//  Created by Geoff Strom on 2/21/22.
//

import CommonUtilities
import CoreMedia
import DesignSystem
import SwiftUI

public struct ShopLookView: View {

    @EnvironmentObject var appState: AppState

    @State var firstTapHappened = false

    @State var circle1Tapped = false
    @State var circle2Tapped = false
    @State var circle3Tapped = false

    @State var isShowingSheet = false

    public var body: some View {

        GeometryReader { geometry in
            ZStack {
                Image(.discover5)
                    .aspectFill()
                Image(.hMIcon)
                    .foregroundColor(.white)
                    .position(x: geometry.size.width/4 * 3, y: 70)
                Group {
                    Image(.shoplook_circle)
                        .resizable()
                        .frame(width: geometry.size.width/378 * 24, height: geometry.size.height/473 * 24, alignment: .center)
                        .position(x: geometry.size.width/378 * 195 + 24, y: geometry.size.height/473 * 43 + 24)
                        .onTapGesture{
                            if firstTapHappened {
                                circle1Tapped.toggle()
                            }
                            else {
                                firstTapHappened = true
                                isShowingSheet.toggle()
                            }
                        }
                        .sheet(isPresented: $isShowingSheet) {
                            LowerToast(content: .content)
                        }
                    Image(.shoplook_circle)
                        .resizable()
                        .frame(width: geometry.size.width/378 * 24, height: geometry.size.height/473 * 24, alignment: .center)
                        .position(x: geometry.size.width/378 * 196 + 24, y: geometry.size.height/473 * 210 + 24)
                        .onTapGesture{
                            if firstTapHappened {
                                circle2Tapped.toggle()
                            }
                            else {
                                firstTapHappened = true
                                isShowingSheet.toggle()
                            }
                        }
                        .sheet(isPresented: $isShowingSheet) {
                            LowerToast(content: .content)
                        }
                    Image(.shoplook_circle)
                        .resizable()
                        .frame(width: geometry.size.width/378 * 24, height: geometry.size.height/473 * 24, alignment: .center)
                        .position(x: geometry.size.width/378 * 116 + 24, y: geometry.size.height/473 * 330 + 24)
                        .onTapGesture{
                            if firstTapHappened {
                                circle3Tapped.toggle()
                            }
                            else {
                                firstTapHappened = true
                                isShowingSheet.toggle()
                            }
                        }
                        .sheet(isPresented: $isShowingSheet) {
                            LowerToast(content: .content)
                        }
                }
                Group {

                    Pointer(tapped: circle1Tapped)
                        .position(x: geometry.size.width/378 * 195 + 24, y: geometry.size.height/473 * 43 + 48)

                    ProductCard(text: "Stetson Men's El Patron\nSilverbelly Felt Western Hat",
                                price: "519.99",
                                tapped: circle1Tapped)
                        .position(x: geometry.size.width/378 * 195 + 20, y: geometry.size.height/473 * 43 + 94)

                    Pointer(tapped: circle2Tapped)
                        .position(x: geometry.size.width/378 * 196 + 24, y: geometry.size.height/473 * 210 + 48)

                    ProductCard(text: "Free People Women's Black\nMulticolored Fly Me Away\nSequins Mini Dress",
                                price: "298.00",
                                tapped: circle2Tapped)
                        .position(x: geometry.size.width/378 * 196 + 20, y: geometry.size.height/473 * 210 + 101)

                    Pointer(tapped: circle3Tapped)
                        .position(x: geometry.size.width/378 * 116 + 24, y: geometry.size.height/473 * 330 + 48)

                    ProductCard(text: "Junk Gypsy by Lane\nWomen's Spirit Animal\nWestern Boots Snip Toe",
                                price: "395.00",
                                tapped: circle3Tapped)
                        .position(x: geometry.size.width/378 * 116 + 20, y: geometry.size.height/473 * 330 + 101)

                }
            }
        }
        .aspectRatio(3/4, contentMode: .fill)
    }

}

struct Pointer: View {

    let tapped:Bool

    init(tapped:Bool) {
        self.tapped = tapped
    }

    var body: some View {

        Triangle()
            .foregroundColor(.black.opacity(0.65))
            .frame(width: 24, height: 24)
            .opacity(tapped == true ? 1 : 0)

    }

}

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))

        return path
    }
}

struct ProductCard: View {

    let text:String
    let price:String
    let tapped:Bool

    init(text:String, price:String, tapped:Bool) {
        self.text = text
        self.price = price
        self.tapped = tapped
    }

    var body: some View {

        VStack(alignment: .leading) {
            Text(text)
                .appFont(.paragraph2)
                .foregroundColor(.white)
            Text(price)
                .appFont(.title2)
                .foregroundColor(.white)
        }
            .padding(10)
            .background(Color.black.opacity(0.65))
            .clipped()
            .opacity(tapped == true ? 1 : 0)

    }

}

struct ShopLookView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ShopLookView()
        }
    }
}
