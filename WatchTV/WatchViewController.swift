//
//  WatchViewController.swift
//  WatchTV
//
//  Created by Jeremy Tregunna on 1/9/17.
//  Copyright © 2017 Greenshire, Inc. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class WatchViewController: UIViewController {
    @IBOutlet var playerController: AVPlayerViewController!
    @IBOutlet var controlsView: UIView!

    private let player: AVPlayer

    private var currentPlaybackTime: TimeInterval {
        get {
            if let currentItem = playerController.player?.currentItem {
                return CMTimeGetSeconds(currentItem.currentTime())
            } else {
                return 0.0
            }
        }
        set {
            let time = CMTime(seconds: newValue, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
            playerController.player?.currentItem?.seek(to: time)
        }
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return [.landscapeLeft, .landscapeRight]
    }

    override var shouldAutorotate: Bool {
        return true
    }

    /// Expects a URL to the HLS stream.
    init(url: URL) {
        player = AVPlayer(url: url)
        super.init(nibName: NSStringFromClass(WatchViewController.self), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Use init(url:) instead.")
    }

    private var observerContext = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        addChildViewController(playerController)
        view.insertSubview(playerController.view, belowSubview: controlsView)
        playerController.player = player
        player.addObserver(self, forKeyPath: "status", options: .new, context: &observerContext)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.isNavigationBarHidden = false
//        controlsView.alpha = 1
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        playerController.view.frame = view.bounds
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        guard context == &observerContext else {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
            return
        }
        
        // look at `change![.newKey]` to see what the status is, e.g.
        
        if keyPath == "status" {
            player.play()
        }
    }
    
    @IBAction func goBack(_ sender: UIButton) {
        skip(back: 10)
    }
    
    @IBAction func goForward(_ sender: UIButton) {
        skip(ahead: 10)
    }

    /// Skip back a number of seconds
    private func skip(back: TimeInterval) {
        currentPlaybackTime -= back
    }

    /// Skip ahead a number of seconds
    private func skip(ahead: TimeInterval) {
        currentPlaybackTime += ahead
    }
}
