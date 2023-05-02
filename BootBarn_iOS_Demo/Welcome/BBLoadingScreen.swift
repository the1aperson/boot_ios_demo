//
//  BBLoadingScreen.swift
//  BootBarn_iOS_Demo
//
//  Created by happyMedium on 2/14/22.
//
import AVFoundation
import SwiftUI
import DesignSystem

class BBLoadingViewModel: ObservableObject {
    
    let player: AVPlayer
    let playerItem: AVPlayerItem
    let assetUrl: URL = Bundle.main.url(forResource: "loading", withExtension: "mp4")!

    init() {
        
        self.playerItem = AVPlayerItem(url: assetUrl)
        self.player = AVPlayer(playerItem: playerItem)
    }
}

struct BBLoadingScreen: View {
    
    @AppStorage(wrappedValue: false, "hasSeenHMLoading") var hasSeenHMLoading
    @StateObject private var vm: BBLoadingViewModel = BBLoadingViewModel()
    @Binding var currentView: ContentView.CurrentView
    
    var body: some View {
        ZStack {
            BBLoadingPlayer(vm: vm)
                .edgesIgnoringSafeArea(.all)
                .overlay(Color.bootDarkGray.opacity(0.3))
                .blur(radius: 1)
            VStack {
                Image(.loadingLogo)
                    .width(250)
            }
            .onAppear(perform: onAppear)
        }
    }
    
    func onAppear() {
        vm.player.play()
        NotificationCenter.default.addObserver(
            forName: .AVPlayerItemDidPlayToEndTime,
            object: vm.player.currentItem,
            queue: nil,
            using: videoEnded
        )
    }
    
    func videoEnded(_ notification: Notification) {
        withAnimation(.easeInOut(duration: 0.75)) {
            if hasSeenHMLoading {
                currentView = .tabView
            } else {
                currentView = .hMLoading
            }
        }
    }
    
}

struct BBLoadingPlayer: UIViewRepresentable {
    
    @ObservedObject var vm: BBLoadingViewModel
    @EnvironmentObject var appState: AppState
    
    func makeUIView(context: Context) -> UIView {
        return BBLoadingView(player: vm.player, playerItem: vm.playerItem)
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        
    }
}


class BBLoadingView: UIView {
    
    var playerLayer = AVPlayerLayer()
    init(player: AVPlayer, playerItem: AVPlayerItem) {
        super.init(frame: .zero)
        playerLayer.player = player
        playerLayer.videoGravity = .resizeAspectFill
        layer.addSublayer(playerLayer)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer.frame = bounds
    }
}

//struct BBLoadingScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        BBLoadingScreen()
//    }
//}
