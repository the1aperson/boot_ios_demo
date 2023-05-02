//
//  StylingView.swift
//  BootBarn_iOS_Demo
//
//  Created by happyMedium on 2/8/22.
//

import SwiftUI

struct StylingView: View {
    
    var body: some View {
        ScrollView {
            VStack(spacing: 12) {
                
                PrimaryButton("primary button") {}
                .padding(.horizontal, 40)
                PrimaryButtonLight("primary button light") {}
                .padding(.horizontal, 40)
                SecondaryButton("secondary button") {}
                .padding(.horizontal, 40)
                CapsuleButton("capsule button") {}
                .padding(.horizontal, 40)
                SimpleButton("simple button") {}
                .padding(.horizontal, 40)

                ForEach(AppFont.allCases, id: \.font) { font in
                    Text(font.rawValue.capitalized).appFont(font)
                }
                
                ForEach(AppImage.allCases, id: \.rawValue) {
                    Image($0)
                        .resizable()
                        .scaledToFit()
                        .height(60)
                        .width(40)
                        .clipped()
                }
            }
        }
        .frame(maxWidth: .infinity)
        .background(.gray)
        
    }
    
}


struct Styling_Previews: PreviewProvider {
    static var previews: some View {
        StylingView()
    }
}
