//
//  ChannelListViewController.swift
//  WatchTV
//
//  Created by Jeremy Tregunna on 1/10/17.
//  Copyright © 2017 Greenshire, Inc. All rights reserved.
//

import UIKit

final class ChannelListViewController: UIViewController {
    @IBOutlet var collectionView: UICollectionView!

    fileprivate let dataSource: ChannelListDataSource

    init(dataSource: ChannelListDataSource) {
        self.dataSource = dataSource
        super.init(nibName: NSStringFromClass(ChannelListViewController.self), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Use init(dataSource:) instead.")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let cellNib = UINib(nibName: NSStringFromClass(ChannelListCell.self), bundle: nil)
        collectionView.register(cellNib, forCellWithReuseIdentifier: ChannelListCell.identifier)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.isNavigationBarHidden = true
    }
}

extension ChannelListViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width - 120
        let height = collectionView.bounds.height - 200
        return CGSize(width: width, height: height)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let url = try? dataSource.url(indexPath: indexPath) {
            Router.shared.navigate(to: .watch(url: url))
        }
    }
}

extension ChannelListViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.numberOfItems
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChannelListCell.identifier, for: indexPath) as! ChannelListCell

        cell.name.text = dataSource.title(indexPath: indexPath)
        cell.previewImage.backgroundColor = UIColor.random

        return cell
    }
}
