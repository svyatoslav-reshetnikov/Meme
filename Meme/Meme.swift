//
//  Meme.swift
//  Meme
//
//  Created by SVYAT on 05.04.16.
//  Copyright © 2016 HiT2B. All rights reserved.
//

import Foundation
import UIKit
import Realm
import RealmSwift

class Meme: Object {
    var topText: String?
    var bottomText: String?
    var imageData: NSData?
    var memedImageData: NSData?
}