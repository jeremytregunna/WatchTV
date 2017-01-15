//
//  Router.swift
//  WatchTV
//
//  Created by Jeremy Tregunna on 1/10/17.
//  Copyright © 2017 Greenshire, Inc. All rights reserved.
//

import UIKit

struct Flows {
    enum Scene {
        case channelList
        case watch(url: URL)
    }
}

protocol RouterDelegate: class {
    func navigate(to: Flows.Scene)
}

class Router: RouterDelegate {
    static let shared = Router()

    var navigationController: UINavigationController!
    var currentScene: Flows.Scene?

    func navigate(to: Flows.Scene) {
        switch to {
        case .channelList:
            currentScene = .channelList
        case .watch(url: let url):
            let watch = WatchViewController(url: url)
            navigationController.pushViewController(watch, animated: true)
            currentScene = .watch(url: url)
        }
    }
}
