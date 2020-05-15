//
//  MapViewController.swift
//  firebaseIntro
//
//  Created by admin on 20/03/2020.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    @IBOutlet weak var map: MKMapView!
    
        override func viewDidLoad() {
            super.viewDidLoad()
            
            let pizzaMark = createMarker(title: "Parmas Pizza", lan: 55.654393, lon: 12.4737828)
            map.addAnnotation(pizzaMark)
            let venueMark = createMarker(title: "Royal Arena", lan: 55.6254401, lon: 12.5715215)
            map.addAnnotation(venueMark)
            // Do any additional setup after loading the view.
        }

        func createMarker(title: String, lan: CLLocationDegrees, lon: CLLocationDegrees) -> MKPointAnnotation {
            let marker = MKPointAnnotation() // Initialize empty marker.
            marker.title = title // Message on the marker.
            let location = CLLocationCoordinate2DMake(lan, lon) // Initializing the marker.
            marker.coordinate = location // Add location to the marker.
            return marker
        }
    
    
    }
