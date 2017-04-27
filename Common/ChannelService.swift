//
//  ChannelService.swift
//  WatchTV
//
//  Created by Jeremy Tregunna on 1/10/17.
//  Copyright © 2017 Greenshire, Inc. All rights reserved.
//

import Foundation

// In a real application, we'd be talking to an API, so this service would know how to query it, and generate these models as well as hand them off to some object that'll maintain that state (a disk backed cache perhaps).
// Demo channel list, uses channels from: https://azure.microsoft.com/en-us/blog/live-247-reference-streams-available/
struct ChannelService {
    static let all: [Channel] = [one, two, three, four, five, six]

    static let one: Channel = Channel(name: "Channel 1", url: URL(string: "http://b028.wpc.azureedge.net/80B028/Samples/a38e6323-95e9-4f1f-9b38-75eba91704e4/5f2ce531-d508-49fb-8152-647eba422aec.ism/Manifest(format=m3u8-aapl)"))

    static let two: Channel = Channel(name: "Channel 2", url: URL(string: "http://b028.wpc.azureedge.net/80B028/SampleStream/595d6b9a-d98e-4381-86a3-cb93664479c2/b722b983-af65-4bb3-950a-18dded2b7c9b.ism/Manifest(format=m3u8-aapl)"))

    static let three: Channel = Channel(name: "Channel 3", url: URL(string: "http://b028.wpc.azureedge.net/80B028/Samples/0e8848ca-1db7-41a3-8867-fe911144c045/d34d8807-5597-47a1-8408-52ec5fc99027.ism/Manifest(format=m3u8-aapl)"))

    static let four: Channel = Channel(name: "Channel 4", url: URL(string: "http://b028.wpc.azureedge.net/80B028/Samples/859b335f-eebc-4ff1-ac03-98e9b614e2c1/0cc164eb-193e-48cb-bc6b-041cc28307e4.ism/Manifest(format=m3u8-aapl)"))

    static let five: Channel = Channel(name: "Channel 5", url: URL(string: "http://samplestreamseu.streaming.mediaservices.windows.net/056163f2-b8ed-4023-abef-753dbe9b3638/7d55569c-54e0-4954-8bea-7dbe19f039f5.ism/Manifest(format=m3u8-aapl-v3)"))

    static let six: Channel = Channel(name: "Channel 6", url: URL(string: "https://bitdash-a.akamaihd.net/content/sintel/hls/playlist.m3u8"))
}
