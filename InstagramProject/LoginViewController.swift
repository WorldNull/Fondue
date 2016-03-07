//
//  LoginViewController.swift
//  InstagramProject
//
//  Created by YouGotToFindWhatYouLove on 2/29/16.
//  Copyright © 2016 Candy. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var usernameField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var centerAlignUsername: NSLayoutConstraint!

    @IBOutlet weak var centerAlignPassword: NSLayoutConstraint!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var registerButton: UIButton!
    
    @IBOutlet weak var appNameLabel: UILabel!
    
    
    var originRegisterFrame: CGRect!
    var originLoginFrame: CGRect!
    var originTintColor: UIColor!
    var tappedTwice: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        usernameField.alpha = 0.7
        passwordField.alpha = 0.7

        usernameField.becomeFirstResponder()
        
        originRegisterFrame = registerButton.frame
        originLoginFrame = loginButton.frame
        originTintColor = registerButton.tintColor
        tappedTwice = false
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        centerAlignUsername.constant -= view.bounds.width
        centerAlignPassword.constant -= view.bounds.width
        loginButton.alpha = 0.0
        registerButton.alpha = 0.0
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animateWithDuration(0.5, delay: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            self.centerAlignUsername.constant += self.view.bounds.width
            self.view.layoutIfNeeded()
            }, completion: nil)
        
        UIView.animateWithDuration(0.5, delay: 0.3, options: .CurveEaseOut, animations: {
            self.centerAlignPassword.constant += self.view.bounds.width
            self.view.layoutIfNeeded()
            }, completion: nil)
        
        UIView.animateWithDuration(0.5, delay: 0.4, options: .CurveEaseOut, animations: {
            self.loginButton.alpha = 1
            self.registerButton.alpha = 1
            }, completion: nil)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onSignIn(sender: AnyObject) {
        PFUser.logInWithUsernameInBackground(usernameField.text!, password: passwordField.text!) { (user: PFUser?, error: NSError?) -> Void in
            if user != nil {
                print("you're logged in!")
                NSNotificationCenter.defaultCenter().postNotificationName(userDidLoginNotification, object: nil)
            } else {
                let bounds = self.loginButton.bounds
                UIView.animateWithDuration(1.0, delay: 0.0, usingSpringWithDamping: 0.2, initialSpringVelocity: 10, options: [], animations: {
                    self.loginButton.bounds = CGRect(x: bounds.origin.x - 10, y: bounds.origin.y, width: bounds.size.width + 25, height: bounds.size.height)
                    self.loginButton.tintColor = UIColor.redColor()
                    self.loginButton.enabled = false
                    }, completion: { void in
                        self.loginButton.enabled = true
                        self.loginButton.tintColor = self.originTintColor
                        self.loginButton.bounds = self.originLoginFrame
                        
                
                })
            }
        }
    }
    
    @IBAction func onSignUp(sender: AnyObject) {
        let newUser = PFUser()
        
        newUser.username = usernameField.text
        newUser.password = passwordField.text
        
        let imageData = UIImagePNGRepresentation(UIImage(named: "DefaultProfileImage")!)
        let imageFile = PFFile(name: "image.png", data: imageData!)
        
        newUser["ProfileImage"] = imageFile
        
        newUser.signUpInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            if success {
                print("Yay, created a user!")
                NSNotificationCenter.defaultCenter().postNotificationName(userDidLoginNotification, object: nil)
            } else {
                print(error?.localizedDescription)
                if error?.code == 202 {
                    print("Username is taken")
                    let bounds = self.registerButton.bounds
                    UIView.animateWithDuration(1.0, delay: 0.0, usingSpringWithDamping: 0.2, initialSpringVelocity: 10, options: [], animations: {
                        self.registerButton.bounds = CGRect(x: bounds.origin.x - 10, y: bounds.origin.y, width: bounds.size.width + 25, height: bounds.size.height)
                        self.registerButton.enabled = false
                        self.registerButton.tintColor = UIColor.redColor()
                        
                        }, completion: { void in
                        self.registerButton.enabled = true
                        self.registerButton.tintColor = self.originTintColor
                        self.registerButton.bounds = self.originRegisterFrame
                        }
                    )
 
                    
                }
            }
        }
        
    }
    
    
    @IBAction func didTap(sender: UITapGestureRecognizer) {
        if tappedTwice == true {
            usernameField.hidden = false
            passwordField.hidden = false
            registerButton.hidden = false
            loginButton.hidden = false
            appNameLabel.hidden = false
            tappedTwice = false
            
        } else {
            usernameField.hidden = true
            passwordField.hidden = true
            registerButton.hidden = true
            loginButton.hidden = true
            appNameLabel.hidden = true
            tappedTwice = true
        }
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
