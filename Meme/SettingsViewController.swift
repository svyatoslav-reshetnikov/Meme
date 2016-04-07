//
//  SettingsViewController.swift
//  Meme
//
//  Created by SVYAT on 06.04.16.
//  Copyright © 2016 HiT2B. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var topNavBar: UINavigationBar!
    @IBOutlet weak var doneAction: UIBarButtonItem!
    @IBOutlet weak var selectFontLabel: UILabel!
    @IBOutlet weak var fontPickerView: UIPickerView!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        topNavBar.topItem?.title = "Settings"
        
        Utils().setStatusBarBackgroundColor(Utils().colorFromRGB(176, green: 97, blue: 87, alpha: 1))
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        Utils().setStatusBarBackgroundColor(UIColor.whiteColor())
    }
    
    @IBAction func pickAnDoneButton(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    //MARK: - Delegates and data sources
    
    //MARK: Data Sources
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return  UIFont.familyNames().count
    }
    
    //MARK: Delegates
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return UIFont.familyNames()[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        selectFontLabel.font = UIFont(name: UIFont.familyNames()[row], size: 40)
        
        // Save custom font
        NSUserDefaults.standardUserDefaults().setObject(UIFont.familyNames()[row], forKey: "font")
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
}

