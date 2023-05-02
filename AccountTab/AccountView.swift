//
//  AccountView.swift
//  BootBarn_iOS_Demo
//
//  Created by happyMedium on 2/14/22.
//

import DesignSystem
import SwiftUI

public struct AccountView: View {
    
    public init() {}
    
    public var body: some View {
        VStack {
            Image(.hMIcon)
            Spacer()
            HStack {
                VStack(alignment: .leading, spacing: 0) {
                    Image(.hMLogo)
                    Spacer().height(48)
                    Text("love@thinkhappymedium.com")
                        .appFont(.title2)
                        .tint(.white)
                    Spacer().height(8)
                    Button(action: {
                        if let url = URL(string: "https://www.thinkhappymedium.com"),
                           UIApplication.shared.canOpenURL(url)
                        {
                            UIApplication.shared.open(url)
                        }
                    }) {
                        Text("thinkhappymedium.com")
                            .appFont(.title2)
                            .foregroundColor(.white)
                    }
                }
                Spacer()
            }
            .padding(.horizontal, 32)
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.vertical, 80)
        .background(.black)
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}
