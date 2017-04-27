//
//  ChannelListViewController.swift
//  WatchTV
//
//  Created by Jeremy Tregunna on 1/12/17.
//  Copyright © 2017 Greenshire, Inc. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class ChannelListViewController: BaseViewController {
    var channelsView: ChannelsView

    var channels: [Channel]

    init(channels: [Channel]) {
        self.channelsView = ChannelsView()
        self.channels = channels
        super.init(nibName: nil, bundle: nil)
        self.title = "Channels"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Use init(channels:) instead")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.darkGray
        channelsView.delegate = self
        view.addSubview(channelsView)
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        channelsView.frame = view.bounds
    }
}

extension ChannelListViewController: ChannelsViewDelegate {
    func channelsView(_ channelsView: ChannelsView, didSelectChannel channel: Channel) {
        let playerViewController = AVPlayerViewController()
        playerViewController.modalTransitionStyle = .crossDissolve

        guard let url = channel.url else { return }
        present(playerViewController, animated: true) {
            let player = AVPlayer(url: url)
//            player.isClosedCaptionDisplayEnabled = true
            playerViewController.player = player
            playerViewController.player?.play()
        }
    }
}
