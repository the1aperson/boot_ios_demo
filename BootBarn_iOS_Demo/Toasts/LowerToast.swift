//
//  PopUpToast.swift
//  BootBarn_iOS_Demo
//
//  Created by Andrew Pearson on 2/16/22.
//

import SwiftUI
import DesignSystem

enum LowerToastContent {
    
    case bag, category, delivery, feedback, content, wishlist

    var title: String {
        switch self {
        case .bag:
            return "Payment Options"
        case .category:
            return "Personalized Content"
        case .delivery:
            return "Delivery Options"
        case .feedback:
            return "Feedback Component"
        case .content:
            return "Shoppable Content"
        case .wishlist:
            return "Wish Lists"
        }
    }
    
    var heading: String {
        switch self {
        case .bag:
            return "Drive Revenue"
        case .category:
            return "Boost Sales 15%*"
        case .delivery:
            return "32% Higher Conversion Rates*"
        case .feedback:
            return "Collect 1000's of Reviews"
        case .content:
            return "84% Purchase Rate*"
        case .wishlist:
            return "Increase Sales 19%*"
        }
    }
    
    var description: String {
        switch self {
        case .bag:
            return "Make payments your competitive edge by offering multiple options for different customers."
        case .category:
            return "Content management systems give brands flexibility and control over messaging and content."
        case .delivery:
            return "Merchants offering curbside and BOPIS delivery methods experience higher conversion rates."
        case .feedback:
            return "Funnel app users based on sentiment. Brand loyalists are prompted to leave a review in the app store, while negative feedback and feature suggestions are captured in-app to find bugs and build your digital roadmap."
        case .content:
            return "Beautiful content helps move customers to purchase.  Make your content work harder for your bottom line."
        case .wishlist:
            return "Reduce lost sales and create a convenient shopping experience with product wish lists."
        }
    }
    
    var subHeading: String {
        switch self {
        case .bag:
            return ""
        case .category:
            return "*Adweek, 2018"
        case .delivery:
            return "*Adobe Analytics, 2021"
        case .feedback:
            return ""
        case .content:
            return "*Sprout Social, 2021"
        case .wishlist:
            return "*Metrillo, 2020"
        }
    }
}

struct LowerToast: View {
    @Environment(\.dismiss) var dismiss
    
    var content: LowerToastContent
    var body: some View {
        ZStack{
            VStack {
                Group {
                    Image("hMIcon")
                        .frame(width: 45, height: 56)
                    Spacer()
                        .height(64)
                }
                Group {
                    Text(content.title)
                        .appFont(.title1)
                        .textCase(.uppercase)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 28)
                    Spacer()
                        .height(40)
                    Rectangle()
                        .width(60)
                        .height(2)
                    Spacer()
                        .height(40)
                    Text(content.heading)
                        .appFont(.label1)
                        .textCase(.uppercase)
                    Spacer()
                        .height(40)
                    Text(content.description)
                        .font(.custom("Roboto-Regular", fixedSize: 16))
                        .lineSpacing(1.17)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 40)
                    Spacer()
                        .height(20)
                    if content.subHeading != "" {
                        Text(content.subHeading)
                            .appFont(.paragraph3)
                    }
                }
                Group {
                    Spacer()
                        .height(64)
                    Image(.exitCircle)
                        .frame(width: 40, height: 40)
                        
                }.onTapGesture {
                    dismiss()
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .edgesIgnoringSafeArea(.all)
        .foregroundColor(.white)
        .background(.black)
    }
}

struct LowerToast_Previews: PreviewProvider {
    static var previews: some View {
        LowerToast(content: .delivery)
    }
}
