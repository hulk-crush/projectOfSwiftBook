//
//  MapViewController.swift
//  breakfasts
//
//  Created by Admin on 31/01/2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {

    
    var breakfast: breakfast!
    
    
    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()

        mapView.delegate = self
        
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(breakfast.location) { (placemarks, error) in
            
            guard error == nil else { return }
            guard let placemarks = placemarks else {return }
            
            let placemark = placemarks.first!
            
            let annotation = MKPointAnnotation()
            annotation.title = self.breakfast.name
            annotation.subtitle = self.breakfast.type
            
            guard let location = placemark.location else {return}
            annotation.coordinate = location.coordinate
            
            self.mapView.showAnnotations([annotation], animated: true)
            self.mapView.selectAnnotation(annotation, animated: true)
        }
}
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !(annotation is MKUserLocation) else {
            return nil
        }
        let annotationIndentifire = "breakAnotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationIndentifire)
        
        if annotationView == nil{
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: annotationIndentifire)
            annotationView?.canShowCallout = true
        }
    let rightImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
    rightImage.image = UIImage(named: breakfast.image)
        annotationView?.rightCalloutAccessoryView = rightImage
        
        annotationView?.tintColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        return annotationView
    }
    
}

