//
//  MapViewController.swift
//  SitFit
//
//  Created by Ebony Nyenya on 2/5/15.
//  Copyright (c) 2015 Ebony Nyenya. All rights reserved.
//

import UIKit
import MapKit

class MyPointAnnotation: MKPointAnnotation {
    
    var index: Int = 0
    
}

class MapViewController: UIViewController, MKMapViewDelegate {

    
    @IBOutlet weak var myMapView: MKMapView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        myMapView.delegate = self

        // Do any additional setup after loading the view.
        
        let image = UIImage(named: "top_icon")
        navigationItem.titleView = UIImageView(image: image)
        
    }

   
    //copied refreshFeed and viewWillAppear method code from FeedTableVC (commented out tableView.reloadData)
    func refreshFeed() {
        FeedData.mainData().refreshFeedItems { () -> () in
            
           // self.tableView.reloadData()
            
         //make annotations from the feedItems
            self.createAnnotationsWithSeats(FeedData.mainData().feedItems)
            
        }
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        refreshFeed()
    }
    
    //coped this method from Maps project's ViewController
    func createAnnotationsWithSeats (seats: [PFObject]) {
        
        for (i, seat) in enumerate (seats) {
            
            let venue = seat["venue"] as [String:AnyObject]
            
            
            
            
            let locationName = venue["name"] as String
            let locationInfo = venue["location"] as [String:AnyObject]
            
            let lat = locationInfo["lat"] as CLLocationDegrees
            let lng = locationInfo["lng"] as CLLocationDegrees
            
            let coordinate = CLLocationCoordinate2DMake(lat, lng)
            
            let annotation = MyPointAnnotation()
        
            annotation.title = seat["name"] as String
            annotation.index = i
            annotation.setCoordinate(coordinate)
            
            myMapView.addAnnotation(annotation)
        
            
        }
        
    }
    
func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {

    var annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "myAnn")
    
    var rightArrowButton = ArrowButton(frame: CGRectMake(0,0,22,22))
    

    rightArrowButton.strokeSize = 2
    rightArrowButton.strokeColor = UIColor.redColor()
    rightArrowButton.leftInset = 8
    rightArrowButton.rightInset = 8
    rightArrowButton.bottomInset = 5
    rightArrowButton.topInset = 5
    
    annotationView.rightCalloutAccessoryView =  rightArrowButton
    
    annotationView.canShowCallout = true
    
    return annotationView
    
//    
//    if !(annotation is CustomPointAnnotation) {
//        return nil
//    }
//    
//    let reuseId = "test"
//    
//    var anView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId)
//    if anView == nil {
//        anView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
//        anView.canShowCallout = true
//    }
//    else {
//        anView.annotation = annotation
//    }
//    
//    //Set annotation-specific properties **AFTER**
//    //the view is dequeued or created...
//    
//    let cpa = annotation as CustomPointAnnotation
//    anView.image = UIImage(named:cpa.imageName)
//    
//    return anView

}
    
     func mapView(mapView: MKMapView!, annotationView view: MKAnnotationView!, calloutAccessoryControlTapped control: UIControl!) {
        
        let index = (view.annotation as MyPointAnnotation).index
        
        FeedData.mainData().selectedSeat = FeedData.mainData().feedItems[index]
        
        let detailVC = storyboard?.instantiateViewControllerWithIdentifier("seatDetailVC") as UIViewController
        
        navigationController?.pushViewController(detailVC, animated:true)
        
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
