//
//  CaptureViewController.swift
//  Fondue
//
//  Created by YouGotToFindWhatYouLove on 3/2/16.
//  Copyright © 2016 Candy. All rights reserved.
//

import UIKit

class CaptureViewController: UIViewController{
    
    
    @IBOutlet weak var selectedImageView: UIImageView!
    
    @IBOutlet weak var captionTextField: UITextField!
    
    var vc: UIImagePickerController!

    override func viewDidLoad() {
        super.viewDidLoad()
        vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = UIImagePickerControllerSourceType.PhotoLibrary

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func selectPhoto(sender: AnyObject) {
        self.presentViewController(vc, animated: true, completion: nil)

        
    }
    
    @IBAction func submitPost(sender: AnyObject) {
        if let image = selectedImageView.image {
            Post.postUserImage(resize(image, newSize: CGSize(width: 150, height: 150)), withCaption: captionTextField.text, withCompletion: nil)
        }
        
    }
    
    func resize(image: UIImage, newSize: CGSize) -> UIImage {
        let resizeImageView = UIImageView(frame: CGRectMake(0, 0, newSize.width, newSize.height))
        resizeImageView.contentMode = UIViewContentMode.ScaleAspectFill
        resizeImageView.image = image
        
        UIGraphicsBeginImageContext(resizeImageView.frame.size)
        resizeImageView.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
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

extension CaptureViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [String : AnyObject]) {
            // Get the image captured by the UIImagePickerController
            let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
            let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
            
            // Do something with the images (based on your use case)
            selectedImageView.image = editedImage
            
            
            // Dismiss UIImagePickerController to go back to your original view controller
            dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
}