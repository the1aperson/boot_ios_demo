//
//  LoopingPlayer.swift
//  BootBarn_iOS_Demo
//
//  Created by happyMedium on 2/14/22.
//

import AVFoundation
import SwiftUI

class LoopingViewModel: ObservableObject {

    let player: AVQueuePlayer
    let playerItem: AVPlayerItem
    
    init(assetUrl: URL) {
        self.playerItem = AVPlayerItem(url: assetUrl)
        self.player = AVQueuePlayer(playerItem: playerItem)
        NotificationCenter.default.addObserver(self, selector: #selector(restartPlayer), name: .restartVideos, object: nil)
    }
    
    @objc
    func restartPlayer() {
        player.play()
    }

}

public struct TappedLoopingPlayer: View {

    @StateObject private var vm: LoopingViewModel
    
    @GestureState var longPress = false
    @GestureState var longDrag = false

    public init(assetUrl: URL) {
        _vm = StateObject(wrappedValue: LoopingViewModel(assetUrl: assetUrl))
    }
    
    public var body: some View {
        
        let longPressGestureDelay = DragGesture(minimumDistance: 0)
            .updating($longDrag) { currentstate, gestureState, transaction in
                gestureState = true
            }
            .onEnded { value in
                print(value.translation) // We can use value.translation to see how far away our finger moved and accordingly cancel the action (code not shown here)
                vm.player.pause()
                
            }
        
        let shortPressGesture = LongPressGesture(minimumDuration: 0)
            .onEnded { _ in
                print("Go to product")
            }
        
        let longTapGesture = LongPressGesture(minimumDuration: 0.25)
            .updating($longPress) { currentstate, gestureState, transaction in
                gestureState = true
            }
            .onEnded { _ in
                vm.player.play()
            }
        
        let tapBeforeLongGestures = longTapGesture
            .sequenced(before: longPressGestureDelay)
            .exclusively(before: shortPressGesture)

        return NestedLoopingPlayer(vm: vm)
            .gesture(tapBeforeLongGestures)
        
    }

}

public extension Notification.Name {
    static let restartVideos: Notification.Name = .init(rawValue: "restartVideos")
}

public struct LoopingPlayer: View {
    
    @StateObject private var vm: LoopingViewModel

    public init(assetUrl: URL) {
        _vm = StateObject(wrappedValue: LoopingViewModel(assetUrl: assetUrl))
    }
    
    public var body: some View {
        NestedLoopingPlayer(vm: vm)
            .onAppear { vm.player.play() }
            .onDisappear { vm.player.pause() }
    }
    
}

struct NestedLoopingPlayer: UIViewRepresentable {
    
    @ObservedObject var vm: LoopingViewModel
    
    func makeUIView(context: Context) -> UIView {
        return QueuePlayerUIView(player: vm.player, playerItem: vm.playerItem)
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        // Do nothing here
    }
}

class QueuePlayerUIView: UIView {
    
    private var playerLayer = AVPlayerLayer()
    private var playerLooper: AVPlayerLooper?
    
    init(player: AVQueuePlayer, playerItem: AVPlayerItem) {
        super.init(frame: .zero)
        
        playerLayer.player = player
        playerLayer.videoGravity = .resizeAspectFill
        layer.addSublayer(playerLayer)
        
        playerLooper = AVPlayerLooper(player: player, templateItem: playerItem)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer.frame = bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
