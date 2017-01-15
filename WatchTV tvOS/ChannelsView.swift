//
//  ChannelsView.swift
//  WatchTV
//
//  Created by Jeremy Tregunna on 1/13/17.
//  Copyright © 2017 Greenshire, Inc. All rights reserved.
//

import UIKit

protocol ChannelsViewDelegate {
    func channelsView(_ channelsView: ChannelsView, didSelectChannel channel: Channel)
}

class ChannelsView: UIView {
    var delegate: ChannelsViewDelegate? = nil
    var numberOfChannelsPerRow: Int = 3
    var channels: [Channel] = [] {
        didSet {
            UIView.animate(withDuration: 0.5, animations: { 
                self.collectionView.alpha = 0
            }) { (finished) in
                self.collectionView.reloadData()
                self.collectionView.contentOffset = .zero
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                    self.animateCellsIn()
                }
            }
        }
    }

    private lazy var collectionView: UICollectionView = {
        let c = UICollectionView(frame: .zero, collectionViewLayout: self.layout)
        c.delegate = self
        c.dataSource = self
        c.register(ChannelListCell.self, forCellWithReuseIdentifier: ChannelListCell.identifier)
        c.register(ChannelHeroView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: ChannelHeroView.identifier)
        return c
    }()

    private lazy var layout: UICollectionViewFlowLayout = {
        return UICollectionViewFlowLayout()
    }()

    init() {
        super.init(frame: .zero)

        self.addSubview(collectionView)
    }

    convenience init(delegate: ChannelsViewDelegate) {
        self.init()

        self.delegate = delegate
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        collectionView.frame = self.bounds
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.headerReferenceSize = CGSize(width: collectionView.frame.width, height: collectionView.frame.height / 2)
    }

    func reloadData() {
        collectionView.reloadData()
    }

    func animateCellsIn() {
        let ordered = collectionView.visibleCells.sorted { (cell1, cell2) -> Bool in
            cell1.layer.position.y > cell2.layer.position.y
        }

        // Hide all cells
        for cell in ordered {
            cell.alpha = 0
            cell.transform = CGAffineTransform(translationX: 0, y: 100)
        }

        collectionView.alpha = 1

        // Show all the cells…
        for (idx, cell) in ordered.enumerated() {
            UIView.animate(withDuration: 0.8, delay: 0.05 * Double(idx), usingSpringWithDamping: 0.8, initialSpringVelocity: 0.5, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                cell.alpha = 1
                cell.transform = CGAffineTransform(translationX: 0, y: 0)
            }, completion: nil)
        }
    }
}

extension ChannelsView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return channels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChannelListCell.identifier, for: indexPath) as! ChannelListCell
        let channel = channels[indexPath.item]
        
        cell.titleLabel.text = channel.name
        cell.thumbnail.backgroundColor = UIColor.random
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: ChannelHeroView.identifier, for: indexPath)
        view.backgroundColor = UIColor.random
        return view
    }
}

extension ChannelsView: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = Int(bounds.width) / numberOfChannelsPerRow
        let height = width / 16 * 9 // (16 * 9), 1920x1080 resolution can be reduced to 16x9.
        return CGSize(width: width, height: height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let channel = channels[indexPath.item]
        self.delegate?.channelsView(self, didSelectChannel: channel)
    }
}
