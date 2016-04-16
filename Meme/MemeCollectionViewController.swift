//
//  MemeCollectionViewController.swift
//  Meme
//
//  Created by SVYAT on 08.04.16.
//  Copyright © 2016 HiT2B. All rights reserved.
//

import UIKit

class MemeCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var memesCollectionView: UICollectionView!
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
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
        return appDelegate.memes.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = memesCollectionView.dequeueReusableCellWithReuseIdentifier("MemeCollectionCell", forIndexPath: indexPath) as! MemeCollectionCell
        
        let meme = appDelegate.memes[indexPath.row]
        if let data = meme.memedImageData {
            cell.memedImage.image = UIImage(data:data, scale:1.0)
        }
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("memeDetail", sender: indexPath)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "memeDetail") {
            let memeDetailViewController = (segue.destinationViewController as! MemeDetailViewController)
            if let indexPath = sender as? NSIndexPath {
                let meme = appDelegate.memes[indexPath.row]
                memeDetailViewController.meme = meme
            }
        }
    }
}
