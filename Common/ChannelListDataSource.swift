//
//  ChannelListDataSource.swift
//  WatchTV
//
//  Created by Jeremy Tregunna on 1/10/17.
//  Copyright © 2017 Greenshire, Inc. All rights reserved.
//

import UIKit

enum ChannelError: Error {
    case urlMissing
}

final class ChannelListDataSource {
    var numberOfItems: Int {
        return channels.count
    }

    private let channels: [Channel]

    init(channels: [Channel]) {
        self.channels = channels
    }

    func title(indexPath: IndexPath) -> String {
        return channels[indexPath.item].name
    }

    func url(indexPath: IndexPath) throws -> URL {
        guard let url = channels[indexPath.item].url else {
            throw ChannelError.urlMissing
        }

        return url
    }
}
