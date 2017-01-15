//
//  ChannelListCell.swift
//  WatchTV
//
//  Created by Jeremy Tregunna on 1/13/17.
//  Copyright © 2017 Greenshire, Inc. All rights reserved.
//

import UIKit

class ChannelListCell: UICollectionViewCell {
    static let identifier = "ChannelListCell"

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 28)
        return label
    }()

    lazy var thumbnail: UIImageView = {
        let imageView = UIImageView()
        imageView.adjustsImageWhenAncestorFocused = true
        imageView.clipsToBounds = false
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(thumbnail)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        let padding: CGFloat = 60
        let (width, height) = (contentView.bounds.width, contentView.bounds.height)
        thumbnail.frame = CGRect(x: padding, y: padding, width: width - (padding * 2), height: height - (padding * 2))
        let imageOffsetY = thumbnail.focusedFrameGuide.layoutFrame.height + padding;
        titleLabel.frame = CGRect(x: 0, y: imageOffsetY, width: width, height: 30)
    }

    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        coordinator.addCoordinatedAnimations({ 
            if self.isFocused {
                self.titleLabel.textColor = UIColor.green
            } else {
                self.titleLabel.textColor = UIColor.white
            }
        }, completion: nil)
    }
}
