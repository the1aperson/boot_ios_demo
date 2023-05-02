//
//  BootTabView.swift
//  BootBarn_iOS_Demo
//
//  Created by happyMedium on 2/15/22.
//

import AccountTab
import CommonUtilities
import DesignSystem
//import ShoppingTab
import SwiftUI

import SwiftUI

struct BootTabView: View {
    
    @EnvironmentObject var appState: AppState
    
    init() {
        setPageIndicatorDotColors(activeColor: .black, inactive: .white)
        setTabBarAppearance(
            backgroundColor: .black,
            normalColor: .bootGray,
            selectedColor: .white,
            tabBarFont: AppFont.tabBar.uiFont
        )
    }
    
    var body: some View {
        TabView(selection: $appState.currentTab) {
            HomeView()
                .tabItem {
                    Image(.home)
                    Text(AppTab.home.tabText)
                }
                .tag(AppTab.home)
                .environmentObject(appState.homeViewModel)
            DiscoverView()
                .tabItem {
                    Image(.discover)
                    Text(AppTab.discover.tabText)
                }
                .tag(AppTab.discover)
            ShoppingView()
                .tabItem {
                    Image(.shop)
                    Text(AppTab.shop.tabText)
                }
                .tag(AppTab.shop)
                .environmentObject(appState.shoppingViewModel)
            AccountView()
                .tabItem {
                    Image(.account)
                        .foregroundColor(.white)
                    Text(AppTab.me.tabText)
                }
                .tag(AppTab.me)
        }
    }
}

struct BootTabView_Previews: PreviewProvider {
    static var previews: some View {
        BootTabView()
    }
}
