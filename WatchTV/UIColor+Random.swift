//
//  UIColor+Random.swift
//  WatchTV
//
//  Created by Jeremy Tregunna on 1/10/17.
//  Copyright © 2017 Greenshire, Inc. All rights reserved.
//

import UIKit

extension UIColor {
    class var random: UIColor {
        func randomVal() -> CGFloat {
            return CGFloat(arc4random_uniform(UInt32(UInt8.max)))
        }

        return UIColor(red: randomVal()/255.0, green: randomVal()/255.0, blue: randomVal()/255.0, alpha: 1.0)
    }
}
