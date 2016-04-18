//
//  MemeDetailViewController.swift
//  Meme
//
//  Created by Svyatoslav Reshetnikov on 16.04.16.
//  Copyright © 2016 HiT2B. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController {
    
    @IBOutlet weak var memedImage: UIImageView!
    
    var meme: Meme!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        memedImage.image = UIImage(data: meme.memedImageData!, scale:1.0)
        
        let editButton = UIBarButtonItem( title: "Edit", style: .Plain, target: self, action: #selector(MemeDetailViewController.pickAnEdit(_:)))
        
        navigationItem.setRightBarButtonItem(editButton, animated: true)
    }
    
    func pickAnEdit (sender: AnyObject) {
        performSegueWithIdentifier("memeEditor", sender: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "memeEditor") {
            let memeEditorViewController = (segue.destinationViewController as! MemeEditorViewController)
            memeEditorViewController.defaultMeme = meme
        }
    }
    
}
