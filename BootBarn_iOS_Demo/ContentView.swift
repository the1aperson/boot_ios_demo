//
//  ContentView.swift
//  BootBarn_iOS_Demo
//
//  Created by happyMedium on 2/6/22.
//

import SwiftUI

enum AppTab: String {
    case home, discover, shop, me
    var tabText: String { rawValue.capitalized }
}

class AppState: ObservableObject {
    
    @Published var currentTab: AppTab = .home
    let shoppingViewModel: ShoppingViewModel = .init()
    let homeViewModel: HomeViewModel = .init()

    func showPdp(_ sampleProduct: SampleProduct) {
        currentTab = .shop
        shoppingViewModel.showPdp(sampleProduct)
    }
    
    func showFeedback() {
        homeViewModel.showFeedback()
    }
}

struct ContentView: View {
    
    enum CurrentView {
        case bbLoading
        case hMLoading
        case tabView
    }

    @StateObject var appState: AppState = AppState()
    @State var currentView: CurrentView = .bbLoading
    @Environment(\.scenePhase) var scenePhase

    var body: some View {
        switch currentView {
        case .bbLoading:
            BBLoadingScreen(currentView: $currentView)
                .transition(.opacity)
        case .hMLoading:
            HMLoadingScreen(currentView: $currentView)
                .transition(.opacity)
        case .tabView:
            BootTabView()
                .environmentObject(appState)
                .onChange(of: scenePhase, perform: { handlePhaseChange($0) })
        }
    }
    
    func handlePhaseChange(_ phase: ScenePhase) {
        if phase == .active {
            NotificationCenter.default.post(name: .restartVideos, object: nil)
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
