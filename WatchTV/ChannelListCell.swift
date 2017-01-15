//
//  ChannelListCell.swift
//  WatchTV
//
//  Created by Jeremy Tregunna on 1/10/17.
//  Copyright © 2017 Greenshire, Inc. All rights reserved.
//

import UIKit

class ChannelListCell: UICollectionViewCell {
    static let identifier = "ChannelListCell"

    @IBOutlet var name: UILabel!
    @IBOutlet var previewImage: UIImageView!

    override func prepareForReuse() {
        super.prepareForReuse()

        name.text = ""
    }
}
