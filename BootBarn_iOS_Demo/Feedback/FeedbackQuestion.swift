//
//  Feedback.swift
//  BootBarn_iOS_Demo
//
//  Created by Andrew Pearson on 2/21/22.
//

import SwiftUI
import DesignSystem
import StoreKit

struct FeedbackQuestion: View {
    @Environment (\.dismiss) var dismiss
    @Binding var answer: Bool
    var body: some View {
        ZStack{
            ZStack {
                Button(action: {
                    dismiss()
                })
                {
                    Image(systemName: "xmark")
                        .resizable()
                        .foregroundColor(.white)
                        .frame(width: 18, height: 18)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
            .padding(.trailing, 12)
            .padding(.top, 28)
            VStack {
                Spacer().height(24)
                Text("Are you enjoying the app?")
                    .appFont(.label1)
                    .textCase(.uppercase)
                    .foregroundColor(.black)
                Spacer().height(32)
                HStack
                {
                    PrimaryButtonLight("NO", action: {
                        answer = false
                        dismiss()
                    })
                    .border(.black, width: 2)

                    Button(action: {
                        answer = true
                        dismiss()
                    })
                    {
                        HStack(spacing: 8) {
                            Text("YES")
                                .appFont(.button1)
                            Image(.hMIcon)
                                .resizable()
                                .frame(width: 20, height: 24)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                    }
                    .background(.black)
                    .foregroundColor(.white)
                }
                Spacer().height(32)
            }
            .padding(.horizontal, 16)
            .background(.white)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.horizontal, 16)
        .edgesIgnoringSafeArea(.all)
        .background(QuestionBackgroundClear())
        .ignoresSafeArea()
    }
    
}

struct QuestionBackgroundClear: UIViewRepresentable {
    func makeUIView(context: Context) -> some UIView {
        let view = UIView()
        DispatchQueue.main.async {
            view.superview?.superview?.backgroundColor = .clear
        }
        return view
    }
    func updateUIView(_ uiView: UIViewType, context: Context) {
    }
}

struct Feedback_Previews: PreviewProvider {
    static var previews: some View {
        FeedbackQuestion(answer: .constant(false))
    }
}
