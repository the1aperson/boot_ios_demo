//
//  FeedbackSubmit.swift
//  BootBarn_iOS_Demo
//
//  Created by Andrew Pearson on 2/21/22.
//

import SwiftUI
import DesignSystem

struct FeedbackSubmit: View {
        @Environment(\.dismiss) var dismiss
        @State private var feedback: String = ""
        var body: some View {
                VStack {
                    HStack(alignment: .center) {
                        Image(systemName: "arrow.left")
                            .resizable()
                            .onTapGesture{
                                dismiss()
                            }
                            .frame(width: 22, height: 18)
                            .padding(.leading, -84)
                        Text("FEEDBACK")
                            .appFont(.title1)
                    }
                    .padding(.top, 32)
                    .padding(.bottom, 8)
                    Text("We want to hear fromo you. What do you like?  What needs improvement or what new feature would you like to see?")
                        .appFont(.button2)
                        .padding(.horizontal, 16)
                        .multilineTextAlignment(.center)
                    Spacer().height(40)
                    TextEditor(text: $feedback)
                        .background(.white)
                        .frame(height: 300, alignment: .center)
                        .padding(.horizontal, 16)
                    Spacer().height(48)
                    PrimaryButtonLight("SUBMIT", action: {
                        dismiss()
                    })
                    .frame(width: 273)
                    PrimaryButton("Cancel", action: {
                        dismiss()
                    })
                    .frame(width: 273)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .edgesIgnoringSafeArea(.all)
                .foregroundColor(.white)
                .background(.black)
            
        }
}

struct FeedbackSubmit_Previews: PreviewProvider {
    static var previews: some View {
        FeedbackSubmit()
    }
}
