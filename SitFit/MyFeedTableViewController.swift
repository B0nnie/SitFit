//
//  MyFeedTableViewController.swift
//  SitFit
//
//  Created by Ebony Nyenya on 2/3/15.
//  Copyright (c) 2015 Ebony Nyenya. All rights reserved.
//

import UIKit

class MyFeedTableViewController: FeedTableViewController {
    
    
    
    
    override func refreshFeed() {
        
        FeedData.mainData().refreshMyFeedItems { () -> () in
            
            self.tableView.reloadData()
    }
    
    }
}//end
        
    