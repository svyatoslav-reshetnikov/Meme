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

extension UIImage {
    func imageWithColor(tintColor: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        
        let context = UIGraphicsGetCurrentContext()!
        
        
        CGContextTranslateCTM(context, 0, self.size.height)
        CGContextScaleCTM(context, 1.0, -1.0);
        CGContextSetBlendMode(context, CGBlendMode.Normal)
        
        let rect = CGRectMake(0, 0, self.size.width, self.size.height) as CGRect
        CGContextClipToMask(context, rect, self.CGImage)
        tintColor.setFill()
        CGContextFillRect(context, rect)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext() as UIImage
        UIGraphicsEndImageContext()
        
        return newImage
    }
}
