//
//  MemeTableViewController.swift
//  Meme
//
//  Created by SVYAT on 08.04.16.
//  Copyright © 2016 HiT2B. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class MemeTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var memesTableView: UITableView!
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Tab bar
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.darkGrayColor()], forState:.Normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.whiteColor()], forState:.Selected)
        for item in (tabBarController?.tabBar.items)! as [UITabBarItem] {
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
        return appDelegate.memes.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MemeTableCell") as! MemeTableCell
        
        let meme = appDelegate.memes[indexPath.row]
        cell.topText.text = meme.topText
        cell.bottomText.text = meme.bottomText
        if let data = meme.memedImageData {
            cell.memeImage.image = UIImage(data:data, scale:1.0)
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == .Delete) {
            let context:NSManagedObjectContext = appDelegate.managedObjectContext!
            context.deleteObject(appDelegate.objects[indexPath.row])
            appDelegate.objects.removeAtIndex(indexPath.row)
            appDelegate.memes.removeAtIndex(indexPath.row)
            try! context.save()
            
            // remove the deleted item from the UITableView
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
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
