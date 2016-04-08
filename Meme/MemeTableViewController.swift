//
//  MemeTableViewController.swift
//  Meme
//
//  Created by SVYAT on 08.04.16.
//  Copyright © 2016 HiT2B. All rights reserved.
//

import Foundation
import UIKit

class MemeTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var memesTableView: UITableView!
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
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
    override func viewWillAppear (animated: Bool) {
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appDelegate.memes.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MemeCell") as! MemeCell
        
        cell.memeImage.image = appDelegate.memes[indexPath.row].memedImage
        
        return cell
    }
    
}
