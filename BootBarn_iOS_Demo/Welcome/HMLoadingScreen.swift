//
//  HMLoadingScreen.swift
//  BootBarn_iOS_Demo
//
//  Created by happyMedium on 2/14/22.
//

import SwiftUI
import DesignSystem

struct HMLoadingScreen: View {

    @AppStorage(wrappedValue: false, "hasSeenHMLoading") var hasSeenHMLoading
    @Binding var currentView: ContentView.CurrentView
    
    var body: some View {
        VStack {
            Text("To Optimize Your Experience")
                .appFont(.title1)
                .textCase(.uppercase)
                .multilineTextAlignment(.center)
            Spacer().height(40)
            Rectangle()
                .width(60)
                .height(2)
            Spacer().height(40)
            Image(.hMIcon)
                .frame(width: 45, height: 56)
            Spacer().height(40)
            Text("Please follow this icon throughout the app for tappable content &amp; please accept push notifications on the next screen for additional insights")
                .appFont(.paragraph2)
                .multilineTextAlignment(.center)
            Spacer().height(80)
            PrimaryButtonLight("Next", action: {
                withAnimation(.easeInOut(duration: 0.5)) {
                    hasSeenHMLoading = true
                    currentView = .tabView
                }
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound], completionHandler: { (granted, error) in
                    if error == nil {
                        DispatchQueue.main.async {
                            UIApplication.shared.registerForRemoteNotifications()
                        }
                    }
                })
            })
        }
        .padding(.horizontal, 60)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .edgesIgnoringSafeArea(.all)
        .foregroundColor(.white)
        .background(.black)
    }
}
