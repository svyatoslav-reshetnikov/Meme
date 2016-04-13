//
//  MemeTableViewController.swift
//  Meme
//
//  Created by SVYAT on 08.04.16.
//  Copyright © 2016 HiT2B. All rights reserved.
//

import Foundation
import UIKit
import Realm
import RealmSwift

class MemeTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var memesTableView: UITableView!
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Tab bar
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.darkGrayColor()], forState:.Normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.whiteColor()], forState:.Selected)
        for item in (self.tabBarController?.tabBar.items)! as [UITabBarItem] {
            if let image = item.image {
                item.image = image.imageWithColor(UIColor.darkGrayColor()).imageWithRenderingMode(.AlwaysOriginal)
                item.selectedImage = image.imageWithColor(UIColor.whiteColor()).imageWithRenderingMode(.AlwaysOriginal)
            }
        }
        
        memesTableView.tableFooterView = UIView(frame: CGRectZero)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        Utils().setStatusBarBackgroundColor(Utils().colorFromRGB(176, green: 97, blue: 87, alpha: 1))
        
        // If added new meme - we must to refresh tableView and show it.
        memesTableView.reloadData()
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 67
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return realm.objects(Meme).count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MemeCell") as! MemeCell
        
        let meme = realm.objects(Meme)[indexPath.row]
        print(meme)
        cell.topText.text = meme.valueForKey("topText") as? String
        cell.bottomText.text = meme.valueForKey("bottomText") as? String
        if let data = meme.valueForKey("memedImageData") as? NSData {
            cell.memeImage.image = UIImage(data:data, scale:1.0)
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let meme = realm.objects(Meme)[indexPath.row]
        self.performSegueWithIdentifier("newMeme", sender: meme)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "newMeme") {
            let newMemeViewController = (segue.destinationViewController as! NewMemeViewController)
            if let meme = sender as? Meme {
                newMemeViewController.defaultMeme = meme
            }
        }
    }
}
