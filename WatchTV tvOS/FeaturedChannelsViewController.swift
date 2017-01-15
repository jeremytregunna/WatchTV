//
//  FeaturedChannelsViewController.swift
//  WatchTV
//
//  Created by Jeremy Tregunna on 1/14/17.
//  Copyright © 2017 Greenshire, Inc. All rights reserved.
//

import UIKit

class FeaturedChannelsViewController: ChannelListViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.darkGray
        self.title = "Featured"
        refresh()
    }

    private func refresh() {
        activityIndicatorView.startAnimating()

        // TODO: Load from external resource
        self.channels = ChannelService.all
        self.channelsView.channels = ChannelService.all
        activityIndicatorView.stopAnimating()
    }
}
