//
//  ProfileViewController.swift
//  Fondue
//
//  Created by YouGotToFindWhatYouLove on 3/2/16.
//  Copyright © 2016 Candy. All rights reserved.
//

import UIKit
import Parse

let userDidLogoutNotification = "userDidLogoutNotification"
let userDidLoginNotification = "userDidLoginNotification"


class ProfileViewController: UIViewController {
    
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    let userDidLogoutNotification = "userDidLogoutNotification"
    
    var profileImagePicker: UIImagePickerController!

    override func viewDidLoad() {
        super.viewDidLoad()
        profileImageView.layer.cornerRadius = profileImageView.frame.size.height/2
        
        profileImagePicker = UIImagePickerController()
        profileImagePicker.delegate = self
        profileImagePicker.allowsEditing = true
        profileImagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        
        
        let currentUser = PFUser.currentUser()
        let imageFile = currentUser!["ProfileImage"] as? PFFile
        
        if let imageFile = imageFile {
            imageFile.getDataInBackgroundWithBlock { (imageData: NSData?, error: NSError?) -> Void in
                if error == nil {
                    if let imageData = imageData {
                        self.profileImageView.image = UIImage(data: imageData)
                    }
                }
            }
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLogOut(sender: AnyObject) {
        PFUser.logOut()
         NSNotificationCenter.defaultCenter().postNotificationName(userDidLogoutNotification, object: nil)
    }
    
    @IBAction func setProfileImage(sender: AnyObject) {
        self.presentViewController(profileImagePicker, animated: true, completion: nil)
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [String : AnyObject]) {
            // Get the image captured by the UIImagePickerController
            let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
            let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
            
            let imageData = UIImagePNGRepresentation(editedImage)
            let imageFile = PFFile(name: "image.png", data: imageData!)
            
            // Do something with the images (based on your use case)
            let currentUser = PFUser.currentUser()
            currentUser!["ProfileImage"] = imageFile
            currentUser?.saveInBackground()
            
            profileImageView.image = editedImage
            
            
            
            // Dismiss UIImagePickerController to go back to your original view controller
            dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
}
