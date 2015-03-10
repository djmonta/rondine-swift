//
//  SecondViewController.swift
//  rondine
//
//  Created by 宮本幸子 on 2014/09/21.
//  Copyright (c) 2014年 Sachiko Miyamoto. All rights reserved.
//

import UIKit
import CoreLocation

class SecondViewController: UIViewController, GMSMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet var mapview: GMSMapView!
    
    var locationManager: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if !(locationManager != nil) { locationManager = CLLocationManager() }

        mapview.myLocationEnabled = true
        mapview.settings.myLocationButton = true
        mapview.delegate = self
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 300
        locationManager.startUpdatingLocation()
        //startLocation()
        
        
        var now:GMSCameraPosition = GMSCameraPosition.cameraWithLatitude(35.701631,longitude:139.416861,zoom:16.0)
        addMarkers()
        
        mapview.camera = now
        
        self.edgesForExtendedLayout = UIRectEdge.None
        //self.view = mapview
        
    }
    
    func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        switch status {
        case .NotDetermined:
            println("aaa")
            if locationManager.respondsToSelector("requestWhenInUseAuthorization") { locationManager.requestWhenInUseAuthorization() }
        case .Restricted, .Denied:
            println("bbb")
            self.alertLocationServicesDisabled()
        case .AuthorizedAlways, .AuthorizedWhenInUse:
            println("ccc")
            break
        default:
            break
        }
    }

    func locationManager(manager: CLLocationManager!, didUpdateToLocation newLocation: CLLocation!, fromLocation oldLocation: CLLocation!){
        println("Loaded")
        var coordinate: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude:newLocation.coordinate.latitude,longitude:newLocation.coordinate.longitude)
        //var now: GMSCameraPosition = GMSCameraPosition.cameraWithLatitude(coordinate.latitude,longitude:coordinate.longitude,zoom:9)
        
    }
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!){
        println("Error" + error.localizedDescription)
    }
    
    func alertLocationServicesDisabled() {
        let title = "Location Services Disabled"
        let message = "You must enable Location Services to track your run."
        
        if (NSClassFromString("UIAlertController") != nil) {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
            
            alert.addAction(UIAlertAction(title: "Settings", style: .Default, handler: { action in
                let url = NSURL(string: UIApplicationOpenSettingsURLString)
                UIApplication.sharedApplication().openURL(url!)
            }))
            alert.addAction(UIAlertAction(title: "Close", style: .Cancel, handler: nil))
            
            presentViewController(alert, animated: true, completion: nil)
        } else {
            UIAlertView(title: title, message: message, delegate: nil, cancelButtonTitle: "Close").show()
        }
    }

    func addMarkers() {
        var rondine: GMSMarker = GMSMarker()
        rondine.title = "rondine"
        rondine.snippet = "TEL:042-595-8018"
        rondine.position = CLLocationCoordinate2DMake(35.701631,139.416861)
        rondine.map = mapview
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

