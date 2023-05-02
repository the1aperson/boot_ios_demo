//
//  StoriesView.swift
//  BootBarn_iOS_Demo
//
//  Created by Geoff Strom on 2/17/22.
//

import CommonUtilities
import CoreMedia
import DesignSystem
import SwiftUI
import AVFoundation

public struct StoriesView: View {

    @Environment(\.presentationMode) var presentation

    @StateObject var model = StoriesModel()

    @State var index = 0

    private let player = AVQueuePlayer()
    private let playerItem = AVPlayerItem(url: Bundle.main.url(forResource: "story1", withExtension: "mp4")!)

    @State var isPlaying = true
    @State var playerProgress = 0.0

    public init() {}

    func advanceOrQuit() {
        if index + 1 >= model.stories.count {
            presentation.wrappedValue.dismiss()
        }
        else {
            index = index + 1
            let item = AVPlayerItem(url: model.stories[index].url)
            player.replaceCurrentItem(with: item)
            playerProgress = 0.0
        }
    }

    func rewind() {
        if index > 0 {
            index = index - 1
            let item = AVPlayerItem(url: model.stories[index].url)
            player.replaceCurrentItem(with: item)
            playerProgress = 0.0
        }
    }

    func togglePause() {
        if isPlaying {
            player.pause()
            isPlaying = false
        }
        else {
            player.play()
            isPlaying = true
        }
    }

    public var body: some View {
        ZStack {
            VideoPlayerExposed(player: player, playerItem: playerItem)
                .onAppear{
                    player.addPeriodicTimeObserver(forInterval: CMTime(seconds: 0.1, preferredTimescale: 600), queue: nil) { time in
                        if let duration = player.currentItem?.duration {
                            let progress = time.seconds/duration.seconds
                            playerProgress = progress.isNaN ? 0.0 : max(min(progress, 1.0), 0.0)
                            //print("playerProgress = \(playerProgress)")
                            if progress > 0.99 {
                                advanceOrQuit()
                            }
                        }
                    }
                    player.play()
                }
                .onDisappear{
                    player.pause()
                }
                .onTapGesture {
                    advanceOrQuit()
                }
                .onLongPressGesture{
                    togglePause()
                }
            HStack() {
                Color.black.opacity(0.001)
                    .onTapGesture{
                        rewind()
                    }
                    .onLongPressGesture{
                        togglePause()
                    }
                Spacer()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            VStack {
                Spacer()
                    .height(52)
                HStack(spacing: 7) {
                    Group {
                        Spacer()
                            .height(3)
                            .width(17)
                        ProgressView(value: index == 0 ? playerProgress : index > 0 ? 1 : 0, total: 1)
                            .progressViewStyle(WithBackgroundProgressViewStyle())
                        ProgressView(value: index == 1 ? playerProgress : index > 1 ? 1 : 0, total: 1)
                            .progressViewStyle(WithBackgroundProgressViewStyle())
                        ProgressView(value: index == 2 ? playerProgress : index > 2 ? 1 : 0, total: 1)
                            .progressViewStyle(WithBackgroundProgressViewStyle())
                    }
                    Group {
                        ProgressView(value: index == 3 ? playerProgress : index > 3 ? 1 : 0, total: 1)
                            .progressViewStyle(WithBackgroundProgressViewStyle())
                        ProgressView(value: index == 4 ? playerProgress : index > 4 ? 1 : 0, total: 1)
                            .progressViewStyle(WithBackgroundProgressViewStyle())
                        ProgressView(value: index == 5 ? playerProgress : index > 5 ? 1 : 0, total: 1)
                            .progressViewStyle(WithBackgroundProgressViewStyle())
                        ProgressView(value: index == 6 ? playerProgress : index > 6 ? 1 : 0, total: 1)
                            .progressViewStyle(WithBackgroundProgressViewStyle())
                        Spacer()
                            .height(3)
                            .width(17)
                    }
                }
                Spacer().height(27)
                HStack {
                    Spacer()
                        .width(24)
                    Text(model.stories[index].title)
                        .appFont(.label1)
                        .foregroundColor(model.stories[index].color)
                    Spacer()
                    Button(action: {
                        presentation.wrappedValue.dismiss()
                    }) {
                        Image(.exit)
                            .renderingMode(.template)
                            .foregroundColor(model.stories[index].color)
                    }
                    Spacer()
                        .width(27)
                }
                HStack {
                    Spacer()
                        .width(24)
                    Text(model.stories[index].body)
                        .appFont(.paragraph1)
                        .foregroundColor(model.stories[index].color)
                    Spacer()
                }
                Spacer()
                HStack {
                    PrimaryButtonLight("Shop the collection", infiniteWidth: false) {}
                        .opacity(model.stories[index].hasButton ? 1 : 0)
                    Spacer()
                }
                .padding(.horizontal, 24)
                
                Spacer()
                    .height(48)
            }
        }
        .ignoresSafeArea()
        .navigationBarHidden(true)
    }
}

struct Story: Identifiable {

    let id = UUID()
    let url:URL
    let color:Color
    let title:String
    let body:String
    let hasButton:Bool

    init(url:URL, color:Color, title:String, body:String, hasButton:Bool) {
        self.url = url
        self.color = color
        self.title = title
        self.body = body
        self.hasButton = hasButton
    }

}

class StoriesModel: ObservableObject {

    @Published var stories: [Story]

    let storiesUrl1: URL = Bundle.main.url(forResource: "story1", withExtension: "mp4")!
    let storiesUrl2: URL = Bundle.main.url(forResource: "story2", withExtension: "mp4")!
    let storiesUrl3: URL = Bundle.main.url(forResource: "story3", withExtension: "mp4")!
    let storiesUrl4: URL = Bundle.main.url(forResource: "story4", withExtension: "mp4")!
    let storiesUrl5: URL = Bundle.main.url(forResource: "story5", withExtension: "mp4")!
    let storiesUrl6: URL = Bundle.main.url(forResource: "story6", withExtension: "mp4")!
    let storiesUrl7: URL = Bundle.main.url(forResource: "story7", withExtension: "mp4")!

    let title = "FALL / WINTER\n2021"
    let body = "Western-fashion pieces from\navant-garde renditions to\nwhimsical interpretations."

    init() {
        self.stories = [
            Story(url: storiesUrl1, color: .white, title: title, body: body, hasButton: false),
            Story(url: storiesUrl2, color: .white, title: title, body: body, hasButton: false),
            Story(url: storiesUrl3, color: .black, title: title, body: body, hasButton: false),
            Story(url: storiesUrl4, color: .black, title: title, body: body, hasButton: false),
            Story(url: storiesUrl5, color: .white, title: title, body: body, hasButton: false),
            Story(url: storiesUrl6, color: .black, title: title, body: body, hasButton: true),
            Story(url: storiesUrl7, color: .white, title: title, body: body, hasButton: true),
        ]
    }

}

struct WithBackgroundProgressViewStyle: ProgressViewStyle {
    func makeBody(configuration: Configuration) -> some View {
        ProgressView(configuration)
            .height(3)
            .background(Color.black.opacity(0.25))
            .foregroundColor(.black)
            .accentColor(.black)
            .cornerRadius(0)
    }
}

struct VideoPlayerExposed: UIViewRepresentable {

    let player:AVQueuePlayer
    let playerItem:AVPlayerItem

    func makeUIView(context: Context) -> UIView {
        return VideoPlayerExposedUIView(player: player, playerItem: playerItem)
    }

    func updateUIView(_ uiView: UIView, context: Context) {
        // empty
    }

}


class VideoPlayerExposedUIView: UIView {

    var playerLayer = AVPlayerLayer()
    private var playerLooper: AVPlayerLooper?

    init(player: AVQueuePlayer, playerItem: AVPlayerItem) {
        super.init(frame: .zero)
        playerLayer.player = player
        playerLayer.videoGravity = .resizeAspectFill
        layer.addSublayer(playerLayer)
        playerLooper = AVPlayerLooper(player: player, templateItem: playerItem)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer.frame = bounds
    }

}

struct StoriesView_Previews: PreviewProvider {
    static var previews: some View {
        StoriesView()
    }
}
