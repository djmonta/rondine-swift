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
        addMarkers()
        locationManager.startUpdatingLocation()
        //startLocation()
        
    }
    
    func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        switch status {
        case .NotDetermined:
            if locationManager.respondsToSelector("requestWhenInUseAuthorization") { locationManager.requestWhenInUseAuthorization() }
        case .Restricted, .Denied:
            self.alertLocationServicesDisabled()
        case .Authorized, .AuthorizedWhenInUse:
            break
        default:
            break
        }
    }

    func locationManager(manager: CLLocationManager!, didUpdateToLocation newLocation: CLLocation!, fromLocation oldLocation: CLLocation!){
        println("Loaded")
        var coordinate: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude:newLocation.coordinate.latitude,longitude:newLocation.coordinate.longitude)
        //var now: GMSCameraPosition = GMSCameraPosition.cameraWithLatitude(coordinate.latitude,longitude:coordinate.longitude,zoom:17)
        
        var now:GMSCameraPosition = GMSCameraPosition.cameraWithLatitude(35.701631,longitude:139.416861,zoom:16.0)

        mapview.camera = now
        
    }
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!){
        println("Error")
    }
    
    func alertLocationServicesDisabled() {
        let title = "Location Services Disabled"
        let message = "You must enable Location Services to track your run."
        
        if (NSClassFromString("UIAlertController") != nil) {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
            
            alert.addAction(UIAlertAction(title: "Settings", style: .Default, handler: { action in
                let url = NSURL(string: UIApplicationOpenSettingsURLString)
                UIApplication.sharedApplication().openURL(url)
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
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

