//
//  Meme.swift
//  Meme
//
//  Created by SVYAT on 05.04.16.
//  Copyright © 2016 HiT2B. All rights reserved.
//

import Foundation
import UIKit

struct Meme {
    
    var topText: String?
    var bottomText: String?
    var image: UIImage?
    var memedImage: UIImage?
    
    init(topText: String, bottomText: String, image: UIImage, memedImage: UIImage) {
        self.topText = topText
        self.bottomText = bottomText
        self.image = image
        self.memedImage = memedImage
    }
}