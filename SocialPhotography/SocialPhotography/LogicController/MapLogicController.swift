//
//  MapLogicController.swift
//  SocialPhotography
//
//  Created by Danish Aziz on 12/10/19.
//  Copyright © 2019 Danish Aziz. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapLogicController: NSObject {
    
    var mapView: MKMapView!
    var navigation: UINavigationController?
    let regionRadius: CLLocationDistance = 1000
    let locationManager = CLLocationManager()
    var lastKnonwLocation = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    let viewModel: LocationViewModel = LocationViewModel()
    var notes: Notes = []
    
    // Setup mapview
    func setupMap(mapView: MKMapView, navigation: UINavigationController?) {
        self.navigation = navigation
        self.mapView = mapView
        self.mapView.delegate = self
        self.mapView.showsUserLocation = true
        self.mapView.register(NoteView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        self.checkLocationAuthorizationStatus()
        self.getNotes()
        NotificationCenter.default.addObserver(self, selector: #selector(updateNotes(notification:)), name: .updateNote, object: nil)
    }
    
    @objc
    private func updateNotes(notification: NSNotification) {
        self.getNotes()
    }
    
    // add location
    func addLocation(name: String, message: String) {
        self.viewModel.addLocation(locationModel: LocationModel(name: name, lat: self.lastKnonwLocation.latitude, long: self.lastKnonwLocation.longitude, note: message))
        self.getNotes()
    }
    
    // get notes
    func getNotes() {
        self.mapView.removeAnnotations(notes)
        self.notes = viewModel.getLocations()
        self.mapView.addAnnotations(notes)
    }
}

// MARK: - CLLocationManager

extension MapLogicController: CLLocationManagerDelegate {
    
    // location authoriza status
    func checkLocationAuthorizationStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedAlways {
            self.mapView.showsUserLocation = true
        } else {
            self.locationManager.requestAlwaysAuthorization()
            self.locationManager.requestWhenInUseAuthorization()
        }
        
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            let coordinateRegion = MKCoordinateRegion(center: center, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
            self.lastKnonwLocation = center
            self.mapView.setRegion(coordinateRegion, animated: true)
            self.locationManager.stopUpdatingLocation()
        }
    }
    
    // set current location into the map
    func setCurrentLocaion() {
        self.locationManager.stopUpdatingLocation()
        self.locationManager.startUpdatingLocation()
    }
}

// MARK: - MKMapViewDelegate

extension MapLogicController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        self.lastKnonwLocation = userLocation.coordinate
    }
    
    // Click on information icon on NoteMapView if there are more maps in
    // same place it will sent to the Search screen and show all notes on that location
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView,
                 calloutAccessoryControlTapped control: UIControl) {
//        let note = view.annotation as! Note
//        let allNotes = notes.filter( { $0.coordinate.latitude == note.coordinate.latitude &&  $0.coordinate.longitude == note.coordinate.longitude })
//
//        if allNotes.count  > 1 {
//            let alert = UIAlertController(title: nil, message: "There are more notes in this location. You want to see ?", preferredStyle: UIAlertController.Style.alert)
//
//            alert.addAction(UIAlertAction(title: "Cancel".uppercased(), style: .cancel, handler: nil))
//
//            alert.addAction(UIAlertAction(title: "Yes".uppercased(), style: .default, handler: { (action: UIAlertAction!) in
//                if let navigation = self.navigation {
//                //    let searchCoordinator: SearchCoordinator = SearchCoordinator(navigation: navigation, notes: allNotes)
//                //    searchCoordinator.start()
//                }
//            }))
//
//            UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
//        }
    }
}
