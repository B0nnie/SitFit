//
//  TabBarControllerView.swift
//  SitFit
//
//  Created by Ebony Nyenya on 2/8/15.
//  Copyright (c) 2015 Ebony Nyenya. All rights reserved.
//

import UIKit

class TabBarControllerView: UITabBarController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //tabBarController.tabBar.barTintColor = UIColor.brownColor()
        
       let color = UIColor(red: 150.0/255.0, green: 253.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        
       // let textColor = UIColor(red: 0/255.0, green: 255.0/255.0, blue: 187.0/255.0, alpha: 1.0)
        
       UITabBar.appearance().barTintColor = color
       // UITabBar.appearance().tintColor = UIColor.greenColor()
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
