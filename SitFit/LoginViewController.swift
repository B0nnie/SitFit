//
//  LoginViewController.swift
//  SitFit
//
//  Created by Ebony Nyenya on 2/3/15.
//  Copyright (c) 2015 Ebony Nyenya. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var userNameField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    
    @IBOutlet weak var buttonBottomConstraint: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        checkIfLoggedIn()
        
        NSNotificationCenter.defaultCenter().addObserverForName(UIKeyboardWillShowNotification, object: nil, queue:
            NSOperationQueue.mainQueue()) { (notification) -> Void in
                
                if let kbSize = notification.userInfo?[UIKeyboardFrameEndUserInfoKey]?.CGRectValue().size
                {
                
                    self.buttonBottomConstraint.constant  = 20 + kbSize.height
                    
                    self.view.layoutIfNeeded()
                    
                    //self.view.frame.origin.y = -kbSize.height
                    
                    
                }
                
                }
        
        
         
                NSNotificationCenter.defaultCenter().addObserverForName(UIKeyboardWillHideNotification, object: nil, queue: NSOperationQueue.mainQueue()) { (notification) -> Void in
                    
            
                    
                    self.buttonBottomConstraint.constant  = 20
                    
                    self.view.layoutIfNeeded()
                    
        }
        
    
    }

  
    @IBAction func loginRegister(sender: AnyObject) {
        
       // isLoggedIn = true
        //checkIfLoggedIn()
        
        var fieldValues: [String] = [userNameField.text, passwordField.text]
        
        if find(fieldValues, "") != nil {
            
            //all fields are not filled in
            var alertViewController = UIAlertController(title: "Submission Error", message: "All fields need to be filled in", preferredStyle: UIAlertControllerStyle.Alert)
            
            var defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
            
            alertViewController.addAction(defaultAction)
            
            presentViewController(alertViewController, animated: true, completion: nil)
        } else {
            
            //all fields are filled in
            println("All fields are filled in and login complete")
            
            var userQuery = PFUser.query()
            userQuery.whereKey("username", equalTo: userNameField.text)
            
            userQuery.findObjectsInBackgroundWithBlock({ (objects, error) -> Void in
                
                if objects.count > 0 {
                    
                    self.login()
                    
                } else {
                    
                    self.signUp()
                }
            })
            
        }
    }
    
    func login() {
        
        PFUser.logInWithUsernameInBackground(userNameField.text, password:passwordField.text) {
            (user: PFUser!, error: NSError!) -> Void in
            
            if user != nil {
                
                // Do stuff after successful login.
                println("logged in as \(user)")
                
                self.isLoggedIn = true
                self.checkIfLoggedIn()
                
            } else {
                // The login failed. Check error to see why.
            }
            
            
        }
        
    }
    
    func signUp() {
        
        var user = PFUser()
        user.username = userNameField.text
        user.password = passwordField.text
        
        // other fields can be set just like with PFObject
        //user["phone"] = "415-392-0202"
        
        user.signUpInBackgroundWithBlock {
            (succeeded: Bool!, error: NSError!) -> Void in
            if error == nil {
                // Hooray! Let them use the app now.
                
                println(user)
                
                self.isLoggedIn = true
                self.checkIfLoggedIn()
                
                self.userNameField.text = ""
                self.passwordField.text = ""
               
                
                
            } else {
                let errorString = error.userInfo?["error"] as NSString
                // Show the errorString somewhere and let the user try again.
            }
        }
    }
    

    
    func checkIfLoggedIn(){
        
        println(isLoggedIn)
        
        if isLoggedIn {
            
            //replace this controller with the tabbarcontroller
           
             var tbc = storyboard?.instantiateViewControllerWithIdentifier("TabBarController") as? UITabBarController
            
            println(tbc)
            
            UIApplication.sharedApplication().keyWindow?.rootViewController = tbc
        
        }
        
        
    }
    
    
    var isLoggedIn: Bool {
        
        get {
            
            return NSUserDefaults.standardUserDefaults().boolForKey("isLoggedIn")
            
        }
        
        set {
            
            NSUserDefaults.standardUserDefaults().setBool(newValue, forKey: "isLoggedIn")
            
            NSUserDefaults.standardUserDefaults().synchronize()
            
        }
    }
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

