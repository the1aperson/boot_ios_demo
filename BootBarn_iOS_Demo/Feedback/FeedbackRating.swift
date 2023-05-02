//
//  Rating.swift
//  BootBarn_iOS_Demo
//
//  Created by Andrew Pearson on 2/21/22.
//

import SwiftUI

struct FeedbackRating: View {
    @Environment (\.dismiss) var dismiss
    @State var rating: Int

    var maximumRating = 5
    let onImage = Image(systemName: "star.fill")
    let offImage = Image(systemName: "star")
    
    var body: some View {
        ZStack {
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
                VStack {
                    Image(uiImage: UIImage(named: "AppIcon") ?? UIImage())
                        .resizable()
                        .frame(width: 72, height: 72)
                        .cornerRadius(12)
                    Text("Enjoying Boot Barn?")
                        .foregroundColor(.black)
                        .fontWeight(.semibold)
                        .font(.system(size: 17))
                        .frame(width: 160)
                    Spacer().height(2)
                    Text("Tap a star to rate it on the App Store.")
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                        .font(.system(size: 13))
//                        .padding(.top, 0.5)
                        .frame(width: 160)
                }
                .padding(16)
                
                HStack {
                    ForEach(1..<maximumRating + 1, id: \.self) { number in
                        image(for: number)
                            .resizable()
                            .foregroundColor(.blue)
                            .frame(width: 24, height: 24)
                            .onTapGesture {
                                self.rating = number
                                dismiss()
                            }
                    }
                }
                .padding(.horizontal, 54)
                .padding(.vertical, 12)
                .border(Color.init(red: 60/255, green: 60/255, blue: 67/255, opacity: 0.36), width: 0.5)
                Button(action: {
                    dismiss()
                }) {
                    Text("Not Now")
                        .foregroundColor(.blue)
                }
                .padding(.bottom, 12)

            }
            .background(Color(red: 194/255, green: 194/255, blue: 194/255))
            .cornerRadius(14)
            .padding(.horizontal, 16)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .background(RatingBackgroundClear())
        .edgesIgnoringSafeArea(.all)
    }
    func image(for number: Int) -> Image {
        if number > rating {
            return offImage
        } else {
            return onImage
        }
    }
}

struct RatingBackgroundClear: UIViewRepresentable {
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

struct FeedbackRating_Previews: PreviewProvider {
    static var previews: some View {
        FeedbackRating(rating: 0)
    }
}
