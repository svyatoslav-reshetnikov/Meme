//
//  MemeCollectionViewController.swift
//  Meme
//
//  Created by SVYAT on 08.04.16.
//  Copyright © 2016 HiT2B. All rights reserved.
//

import UIKit
import Realm
import RealmSwift

class MemeCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var memesCollectionView: UICollectionView!
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        Utils().setStatusBarBackgroundColor(Utils().colorFromRGB(176, green: 97, blue: 87, alpha: 1))
        
        // If added new meme - we must to refresh tableView and show it.
        memesCollectionView.reloadData()
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return realm.objects(Meme).count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = memesCollectionView.dequeueReusableCellWithReuseIdentifier("MemeCollectionCell", forIndexPath: indexPath) as! MemeCollectionCell
        
        let meme = realm.objects(Meme)[indexPath.row]
        if let data = meme.valueForKey("memedImageData") as? NSData {
            cell.memedImage.image = UIImage(data:data, scale:1.0)
        }
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let meme = realm.objects(Meme)[indexPath.row]
        self.performSegueWithIdentifier("memeEditor", sender: meme)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "memeEditor") {
            let newMemeViewController = (segue.destinationViewController as! MemeEditorViewController)
            if let meme = sender as? Meme {
                newMemeViewController.defaultMeme = meme
            }
        }
    }
}
