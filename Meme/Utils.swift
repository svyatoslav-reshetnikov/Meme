//
//  Utils.swift
//  Meme
//
//  Created by SVYAT on 06.04.16.
//  Copyright © 2016 HiT2B. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class Utils {
    
    func colorFromRGB (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> UIColor {
        let redValue = red/255
        let greenValue = green/255
        let blueValue = blue/255
        return UIColor(red: redValue, green: greenValue, blue: blueValue, alpha: alpha)
    }
    
    // Little hack for set status bar color
    func setStatusBarBackgroundColor(color: UIColor) {
        
        guard  let statusBar = UIApplication.sharedApplication().valueForKey("statusBarWindow")?.valueForKey("statusBar") as? UIView else {
            return
        }
        statusBar.backgroundColor = color
    }
}