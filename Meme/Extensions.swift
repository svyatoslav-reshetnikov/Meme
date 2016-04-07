//
//  Extensions.swift
//  Meme
//
//  Created by SVYAT on 07.04.16.
//  Copyright © 2016 HiT2B. All rights reserved.
//

import UIKit
import Foundation

extension UIApplication {
    
    class func isFirstLaunch() -> Bool {
        if !NSUserDefaults.standardUserDefaults().boolForKey("HasAtLeastLaunchedOnce") {
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: "HasAtLeastLaunchedOnce")
            NSUserDefaults.standardUserDefaults().synchronize()
            return true
        }
        return false
    }
    
}
