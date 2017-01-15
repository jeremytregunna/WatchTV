//
//  BaseViewController.swift
//  WatchTV
//
//  Created by Jeremy Tregunna on 1/14/17.
//  Copyright © 2017 Greenshire, Inc. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    let activityIndicatorView: UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)

    override func viewDidLoad() {
        super.viewDidLoad()

        activityIndicatorView.hidesWhenStopped = true
        view.addSubview(activityIndicatorView)
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        activityIndicatorView.center = view.center
    }
}
