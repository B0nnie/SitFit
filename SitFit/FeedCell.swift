//
//  FeedCell.swift
//  SitFit
//
//  Created by Ebony Nyenya on 2/5/15.
//  Copyright (c) 2015 Ebony Nyenya. All rights reserved.
//

import UIKit

class FeedCell: UITableViewCell {
    
    
    var seatInfo: PFObject? {
        
        didSet {
            
            seatNameLabel.text = seatInfo?["name"] as? String
            
            //copied from Parse website, Files -> Images
            let userImageFile = seatInfo? ["image"] as PFFile
            
            userImageFile.getDataInBackgroundWithBlock {
                (imageData: NSData!, error: NSError!) -> Void in
                
                if error == nil {
                    
                    let image = UIImage(data:imageData)
                    self.seatImageView.image = image
                    
                }
            }
            
        }
        
    }

    
    @IBOutlet weak var seatImageView: UIImageView!
    
    
    @IBOutlet weak var seatNameLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
