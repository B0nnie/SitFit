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
        
        isLoggedIn = true
        checkIfLoggedIn()
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
    
    
    func checkIfLoggedIn(){
        
        println(isLoggedIn)
        
        if isLoggedIn {
            
            //replace this controller with the tabbarcontroller
           
             var tbc = storyboard?.instantiateViewControllerWithIdentifier("TabBarController") as? UITabBarController
            
            println(tbc)
            
            UIApplication.sharedApplication().keyWindow?.rootViewController = tbc
        
        }
        
        
    }
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

