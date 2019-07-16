//
//  ViewController.swift
//  MapKit_App
//
//  Created by Nooruddin on 08/07/19.
//  Copyright © 2019 Nooruddin. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    fileprivate let locationManager = CLLocationManager()
    
    
    
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.startUpdatingLocation()
     
        mapView.showsUserLocation = true
        mapView.delegate = self
        
        segmentedControl.addTarget(self, action: #selector(switchType), for: .valueChanged)
        
    }
    
    
    
    
    
    
    
    
    fileprivate func addAnnotationToMap() {
        let annotation = MKPointAnnotation()
        //annotation.coordinate = CLLocationCoordinate2D(latitude: 22.997180, longitude: 72.578780)
        annotation.coordinate = mapView.userLocation.coordinate
        annotation.title = "iOS Courses"
        annotation.subtitle = "Free Academy to learn anything"
        mapView.addAnnotation(annotation)
    }
    
    
    @objc fileprivate func switchType() {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            mapView.mapType = .standard
        case 1:
            mapView.mapType = .satellite
        case 2:
            mapView.mapType = .hybrid
        default:
            return
        }
    }
    
    
    @IBAction func pinAddress(_ sender: Any) {
        let alert = UIAlertController(title: "Enter Address", message: "we need your address", preferredStyle: .alert)
        
        alert.addTextField { (tf) in }
        let saveButton = UIAlertAction(title: "Pin Address", style: .default) { (action) in
            if let tf = alert.textFields?.first {
                let addressText = tf.text!
                self.geocodeAndAnnotate(addressText: addressText)
            }
        }
        
        alert.addAction(saveButton)
        
        self.present(alert, animated: true)
    }
    
    
    fileprivate func geocodeAndAnnotate(addressText: String) {
        let geoCoder = CLGeocoder()
        
        geoCoder.geocodeAddressString(addressText) { (placemarks,err) in
            if let err = err {
                print(err.localizedDescription); return
            }
            guard let placemarks = placemarks else { return }
            let placemark = placemarks.first
            //get directions
            let coordinates = placemark?.location?.coordinate
            let destination = MKPlacemark(coordinate: coordinates!)
            let startingPoint = MKMapItem.forCurrentLocation()
            let destinationPoint = MKMapItem(placemark: destination)
            
            let directionReq = MKDirections.Request()
            directionReq.transportType = .automobile
            directionReq.source = startingPoint
            directionReq.destination = destinationPoint
            
            let directions = MKDirections(request: directionReq)
            directions.calculate(completionHandler: { (response, err) in
                if let err = err {
                    print(err.localizedDescription)
                    return
                }
                if let response = response {
                    guard let route = response.routes.first else {return}
                    let steps = route.steps
                    if !steps.isEmpty {
                        for step in steps {
                            print("next step:",step.instructions)
                        }
                    }
                    self.mapView.addOverlay(route.polyline, level: .aboveRoads)
                }
            })
            
            //opens in map
//            let coordinates = placemark?.location?.coordinate
//            let destination = MKPlacemark(coordinate: coordinates!)
//            let mapItem = MKMapItem(placemark: destination)
//
//            MKMapItem.openMaps(with: [mapItem], launchOptions: nil)
            //pin address to map
//            let coordinates = placemark?.location?.coordinate
//            let newAnnotation = MKPointAnnotation()
//            newAnnotation.coordinate = coordinates ?? CLLocationCoordinate2D(latitude: 20, longitude: 20)
//            self.mapView.addAnnotation(newAnnotation)
        }
    }
    
    
    


}







extension ViewController: CLLocationManagerDelegate {
    
    
}


extension ViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.blue.withAlphaComponent(0.8)
        renderer.lineWidth = 4
        return renderer
    }
    
    
    func mapView(_ mapView: MKMapView, clusterAnnotationForMemberAnnotations memberAnnotations: [MKAnnotation]) -> MKClusterAnnotation {
        let cluster = MKClusterAnnotation(memberAnnotations: memberAnnotations)
        
        cluster.title = "Coffee, Games and Clothes."
        cluster.subtitle = "a group of cool places."
        
        return cluster
    }
    
    
    fileprivate func setupMapSnapshot(annotation: MKAnnotationView) {
        let options = MKMapSnapshotter.Options()
        options.size = CGSize(width: 200, height: 200)
        options.mapType = .satelliteFlyover
        let center = annotation.annotation?.coordinate ?? CLLocationCoordinate2D(latitude: 20, longitude: 20)
        options.camera = MKMapCamera(lookingAtCenter: center, fromDistance: 100, pitch: 60, heading: 0)
        
        let snapshotter = MKMapSnapshotter(options: options)
        snapshotter.start { (snapshot,error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            if let snapshot = snapshot {
                let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
                imageView.image = snapshot.image
                annotation.detailCalloutAccessoryView = imageView
            }
        }
        
    }
    
    //Zoom in
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        let region = MKCoordinateRegion(center: mapView.userLocation.coordinate, latitudinalMeters: 5, longitudinalMeters: 5)
        mapView.setRegion(region, animated: true)
        
        addAnnotationToMap()
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation { return nil }
//        var marker = mapView.dequeueReusableAnnotationView(withIdentifier: "annotation") as? MKMarkerAnnotationView
        let marker = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "annotation")
        marker.clusteringIdentifier = "Coffee identifier"
        marker.glyphText = "Coffee"
        marker.canShowCallout = true
        marker.leftCalloutAccessoryView = UIImageView(image: #imageLiteral(resourceName: "pin"))
        marker.rightCalloutAccessoryView = UIImageView(image: #imageLiteral(resourceName: "chevron"))
        setupMapSnapshot(annotation: marker)
        return marker
    }

}
