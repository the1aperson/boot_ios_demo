//
//  ButtonStyling.swift
//  BootBarn_iOS_Demo
//
//  Created by happyMedium on 2/8/22.
//

import CommonUtilities
import SwiftUI

//MARK: - Modifiers
fileprivate struct PrimaryButtonModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .modifier(BlockButtonModifier())
            .background(.black)
            .foregroundColor(.white)
    }
    
}

fileprivate struct PrimaryButtonLightModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .modifier(BlockButtonModifier())
            .background(.white)
            .foregroundColor(.black)
    }
    
}

fileprivate struct SecondaryButtonModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .modifier(BlockButtonModifier())
            .background(.clear)
            .foregroundColor(.black)
            .border(.black, width: 2)
    }
    
}

fileprivate struct BlockButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(minHeight: 48, idealHeight: 48)
            .padding(.horizontal, 16)
            
    }
}

fileprivate struct CapsuleButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(minHeight: 24, idealHeight: 24)
            .padding(.horizontal, 12)
            .background(Capsule().foregroundColor(.white))
            .foregroundColor(.black)
    }
}

// MARK: - Buttons
// This is temporary until I can figure out how to apply kerning to a ButtonStyle modifier
public struct PrimaryButton: View {
    
    let text: String
    let action: Action
    
    public init(_ text: String, action: @escaping Action) {
        self.text = text
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            Text(text)
                .appFont(.button1)
                .frame(maxWidth: .infinity)
                .modifier(PrimaryButtonModifier())
        }
    }
    
}

public struct PrimaryButtonLight: View {
    
    let text: String
    let action: Action
    let infiniteWidth: Bool
    
    public init(_ text: String, infiniteWidth: Bool = true, action: @escaping Action) {
        self.text = text
        self.action = action
        self.infiniteWidth = infiniteWidth
    }

    public var body: some View {
        Button(action: action) {
            Text(text)
                .appFont(.button1)
                .frame(maxWidth: infiniteWidth ? .infinity : nil)
                // add some more padding for views that won't automatically fill space
                .if(!infiniteWidth, transform: { view in
                    view.padding(.horizontal, 12)
                })
                .modifier(PrimaryButtonLightModifier())
        }
    }
    
}

public enum ButtonImage {
    case leading(AppImage)
    case trailing(AppImage)
}

public struct SecondaryButton: View {
    
    let text: String
    let image: ButtonImage?
    let action: Action
    
    public init(_ text: String, image: ButtonImage? = nil, action: @escaping Action) {
        self.text = text
        self.image = image
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            content
                .frame(maxWidth: .infinity)
                .modifier(SecondaryButtonModifier())
        }
    }
    
    var content: some View {
        if let image = image {
            switch image {
            case .leading(let appImage):
                return AnyView(
                    HStack(spacing: 8) {
                        Image(appImage)
                        Text(text).appFont(.button1)
                    }
                )
            case .trailing(let appImage):
                return AnyView(
                    HStack(spacing: 8) {
                        Text(text).appFont(.button1)
                        Image(appImage)
                    }
                )
            }
        } else {
            return AnyView(Text(text).appFont(.button1))
        }
    }
    
}



public struct CapsuleButton: View {
    
    let text: String
    let action: Action
    
    public init(_ text: String, action: @escaping Action) {
        self.text = text
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            Text(text.capitalized)
                .appFont(.button3)
                .frame(maxWidth: .infinity)
                .modifier(CapsuleButtonModifier())
        }
    }
    
}

public struct SimpleButton: View {
    
    let text: String
    let action: Action
    
    public init(_ text: String, action: @escaping Action) {
        self.text = text
        self.action = action
    }
    
    public var body: some View {
        Button(action: action) {
            Text(text)
                .appFont(.button2)
                .foregroundColor(.bootDarkGray)
        }
    }

}


// MARK: - Public Extensions
/*
extension Button {
    
    func primaryStyle() -> some View {
        modifier(BlockButton()).modifier(PrimaryButton())
    }
    
    func secondaryStyle() -> some View {
        modifier(BlockButton()).modifier(SecondaryButton())
    }
    
    func capsuleButton() -> some View {
        modifier(CapsuleButton())
    }
    
}
*/
