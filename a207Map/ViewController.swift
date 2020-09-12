//
//  ViewController.swift
//  a207Map
//
//  Created by 申潤五 on 2020/9/12.
//  Copyright © 2020 申潤五. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {
    @IBOutlet weak var myMap: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            let latitude:CLLocationDegrees = 25.0443362
            let longitude:CLLocationDegrees = 121.5135424
            let location:CLLocationCoordinate2D =
                CLLocationCoordinate2DMake(latitude, longitude)
            let xScale:CLLocationDegrees = 0.001
            let yScale:CLLocationDegrees = 0.001
            
            let span:MKCoordinateSpan =
                MKCoordinateSpan(latitudeDelta: yScale, longitudeDelta: xScale)
            let region:MKCoordinateRegion =
                MKCoordinateRegion.init(center: location, span: span)
            self.myMap.setRegion(region, animated: true)
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = location
            annotation.title = "譯智􏼵􏼶"
            annotation.subtitle = "我們在這兒􏷊􏼷􏼸􏵨􏲾􏷦"
            self.myMap.addAnnotation(annotation)

        }
        
        
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
    
}

