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
    
    /*init(topText: String, bottomText: String, image: UIImage, memedImage: UIImage) {
        self.topText = topText
        self.bottomText = bottomText
        self.image = image
        self.memedImage = memedImage
    }
    
    // Decode
    init(dictionary: Dictionary<String, AnyObject>){
        topText = dictionary["topText"] as? String
        bottomText = dictionary["bottomText"] as? String
        image = dictionary["image"] as? UIImage
        memedImage = dictionary["memedImage"] as? UIImage
    }
    
    // Encode
    func encode() -> Dictionary<String, AnyObject> {
        
        var dictionary : Dictionary = Dictionary<String, AnyObject>()
        dictionary["topText"] = topText
        dictionary["bottomText"] = bottomText
        dictionary["image"] = image
        dictionary["memedImage"] = memedImage
        return dictionary
    }*/
}

/*class Meme : NSObject, NSCoding {
    
    var topText: String?
    var bottomText: String?
    var image: UIImage?
    var memedImage: UIImage?
    
    // designated initializer
    //
    // ensures you'll never create a Blog object without giving it a name
    // unless you would need that for some reason?
    //
    // also : I would not override the init method of NSObject
    
    init(topText: String, bottomText: String, image: UIImage, memedImage: UIImage) {
        self.topText = topText
        self.bottomText = bottomText
        self.image = image
        self.memedImage = memedImage
        
        super.init()        // call NSObject's init method
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(topText, forKey: "topText")
        aCoder.encodeObject(bottomText, forKey: "bottomText")
        aCoder.encodeObject(image, forKey: "image")
        aCoder.encodeObject(memedImage, forKey: "memedImage")
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        // decoding could fail, for example when no Blog was saved before calling decode
        /*guard let unarchivedBlogName = aDecoder.decodeObjectForKey("topText") as? String
            else {
                // option 1 : return an default Blog
                self.init(topText: "unnamed")
                return
                
                // option 2 : return nil, and handle the error at higher level
        }*/
        
        // convenience init must call the designated init
        self.init(topText: aDecoder.decodeObjectForKey("topText") as! String, bottomText: aDecoder.decodeObjectForKey("bottomText") as! String, image: aDecoder.decodeObjectForKey("image") as! UIImage, memedImage: aDecoder.decodeObjectForKey("memedImage") as! UIImage)
    }
}*/