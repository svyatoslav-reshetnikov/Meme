//
//  MemeEditorViewController.swift
//  Meme
//
//  Created by SVYAT on 04.04.16.
//  Copyright © 2016 HiT2B. All rights reserved.
//

import UIKit
import Realm
import RealmSwift

class MemeEditorViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var topNavBar: UINavigationBar!
    @IBOutlet weak var bottomToolbar: UIToolbar!
    
    var defaultMeme: Meme?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let meme = defaultMeme {
            self.topTextField.text = meme.valueForKey("topText") as? String
            self.bottomTextField.text = meme.valueForKey("bottomText") as? String
            self.imagePickerView.image = UIImage(data: meme.valueForKey("imageData") as! NSData, scale:1.0)
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(.Camera)
        shareButton.enabled = imagePickerView.image != nil ? true : false
        
        // Preset all textfields from suggestion
        presetTextField(topTextField)
        presetTextField(bottomTextField)
        
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    // MARK: Actions
    @IBAction func pickAnImageSource (sender: AnyObject) {
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        if sender.tag! == 0 {
            imagePicker.sourceType = .PhotoLibrary
        } else if sender.tag! == 1 {
            imagePicker.sourceType = .Camera
        }
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func pickAnShare (sender: AnyObject) {
        let memedImage = self.generateMeme()
        let activityViewController = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
        activityViewController.completionWithItemsHandler = { activity, success, items, error in
            // Save meme after share
            if success {
                self.saveMeme()
            }
        }
        // Present activity view controller. In completition block - save the meme
        presentViewController(activityViewController, animated: true, completion: nil)
    }
    
    @IBAction func pickAnBack (sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // Clear all data
    @IBAction func pickAnCancel (sender: AnyObject) {
        imagePickerView.image = nil
        topTextField.text = ""
        bottomTextField.text = ""
    }
    
    // MARK: UIImagePickerControllerDelegate
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imagePickerView.image = image
        }
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: UITextFieldDelegate
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // MARK: Keyboard stuff
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.CGRectValue().height
    }
    
    // Change y coordinate only for bottomTextField
    func keyboardWillShow(notification: NSNotification) {
        if bottomTextField.isFirstResponder() {
            self.view.frame.origin.y = getKeyboardHeight(notification)  * -1
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if bottomTextField.isFirstResponder() {
            self.view.frame.origin.y = 0
        }
    }
    
    func subscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MemeEditorViewController.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MemeEditorViewController.keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    // MARK: Other
    func generateMeme() -> UIImage {
        
        // Hide toolbar and navbar
        topNavBar.hidden = true
        bottomToolbar.hidden = true
        
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawViewHierarchyInRect(self.view.frame, afterScreenUpdates: true)
        let memedImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        // Show toolbar and navbar
        topNavBar.hidden = false
        bottomToolbar.hidden = false
        
        return memedImage
    }
    
    // Save meme use Realm
    func saveMeme() {
        let meme = Meme()
        meme.topText = topTextField.text
        meme.bottomText = bottomTextField.text
        meme.imageData = UIImagePNGRepresentation(imagePickerView.image!)
        meme.memedImageData = UIImagePNGRepresentation(generateMeme())
        
        let realm = try! Realm()
        realm.beginWrite()
        realm.add(meme)
        try! realm.commitWrite()
    }
    
    func presetTextField(textField: UITextField) {
        
        let memeTextAttributes = [
            NSStrokeColorAttributeName : UIColor.blackColor(),
            NSForegroundColorAttributeName : UIColor.whiteColor(),
            NSFontAttributeName : UIFont(name: NSUserDefaults.standardUserDefaults().stringForKey("font")!, size: 40)!,
            NSStrokeWidthAttributeName : -2.0
        ]
        textField.attributedPlaceholder = NSAttributedString(string: textField.placeholder!, attributes:memeTextAttributes)
        textField.defaultTextAttributes = memeTextAttributes
        
        textField.textAlignment = .Center
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}

