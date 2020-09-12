//
//  ViewController.swift
//  a207Map
//
//  Created by 申潤五 on 2020/9/12.
//  Copyright © 2020 申潤五. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet weak var myMap: MKMapView!
    @IBOutlet weak var addressTF: UITextField!
    
    var locationManager:CLLocationManager? = nil
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let coordinate = locations[0].coordinate
        
//        let xScale:CLLocationDegrees = 0.01
//        let yScale:CLLocationDegrees = 0.01
//        let span:MKCoordinateSpan =
//            MKCoordinateSpan(latitudeDelta: yScale, longitudeDelta: xScale)
//        let region:MKCoordinateRegion =
//            MKCoordinateRegion.init(center: coordinate, span: span)
//        myMap.setRegion(region, animated: true)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        locationManager?.requestWhenInUseAuthorization()
        
        locationManager?.delegate = self
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        locationManager?.activityType = .automotiveNavigation
        locationManager?.startUpdatingLocation()
        
        
        myMap.userTrackingMode = .followWithHeading

        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
//            let latitude:CLLocationDegrees = 25.0443362
//            let longitude:CLLocationDegrees = 121.5135424
//            let location:CLLocationCoordinate2D =
//                CLLocationCoordinate2DMake(latitude, longitude)
//            let xScale:CLLocationDegrees = 0.001
//            let yScale:CLLocationDegrees = 0.001
//
//            let span:MKCoordinateSpan =
//                MKCoordinateSpan(latitudeDelta: yScale, longitudeDelta: xScale)
//            let region:MKCoordinateRegion =
//                MKCoordinateRegion.init(center: location, span: span)
//            self.myMap.setRegion(region, animated: true)
//
//
//
//        }
        
        
    }

    @IBAction func selctMapType(_ sender: UISegmentedControl) {
        print(sender.selectedSegmentIndex)
        switch sender.selectedSegmentIndex {
        case 0:
            myMap.mapType = .standard
        case 1:
            myMap.mapType = .satellite
        case 2:
            myMap.mapType = .hybrid
        default:
            break
        }
        
        
    }
    
    @IBAction func longPressAction(_ sender: UILongPressGestureRecognizer) {
        print(sender.location(in: myMap))
        let touchPoint = sender.location(in: myMap)
        let location = myMap.convert(touchPoint, toCoordinateFrom: myMap)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = "譯智􏼵􏼶"
        annotation.subtitle = "\(location.latitude):\(location.longitude)􏷊􏼷􏼸􏵨􏲾􏷦"
        self.myMap.addAnnotation(annotation)
        
    }
    
    
    @IBAction func getLocation(_ sender: Any) {
        if let coordinate = locationManager?.location?.coordinate{
            let xScale:CLLocationDegrees = 0.01
            let yScale:CLLocationDegrees = 0.01
            let span:MKCoordinateSpan =
                MKCoordinateSpan(latitudeDelta: yScale, longitudeDelta: xScale)
            let region:MKCoordinateRegion =
                MKCoordinateRegion.init(center: coordinate, span: span)
            myMap.setRegion(region, animated: true)
            
        }
    }
    
    @IBAction func addressLocation(_ sender: Any) {
        let add = addressTF.text ?? ""
        addressToCod(address: add)
        
        

        
    }
    
    func addressToCod(address:String) {
        let geoCoder = CLGeocoder()
        var coordinate:CLLocationCoordinate2D? = nil
        geoCoder.geocodeAddressString(address) { (placemarks:[AnyObject]!, error) in
            if error != nil{
                print(error?.localizedDescription)
               return
            }

            if placemarks != nil && placemarks.count > 0{
               let placemark = placemarks[0] as? CLPlacemark
                print(placemark?.location?.coordinate)
                if let coordinate = placemark?.location?.coordinate{
                    let xScale:CLLocationDegrees = 0.01
                    let yScale:CLLocationDegrees = 0.01
                    let span:MKCoordinateSpan =
                        MKCoordinateSpan(latitudeDelta: yScale, longitudeDelta: xScale)
                    let region:MKCoordinateRegion =
                        MKCoordinateRegion.init(center: coordinate, span: span)
                    self.myMap.setRegion(region, animated: true)
                }
               //placemark.location.coordinate 取得經緯度的參數
            }
        }
        
    }
    
    
    
}

