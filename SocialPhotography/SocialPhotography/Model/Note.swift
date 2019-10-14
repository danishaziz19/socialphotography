//
//  Note.swift
//  SocialPhotography
//
//  Created by Danish Aziz on 12/10/19.
//  Copyright © 2019 Danish Aziz. All rights reserved.
//

import Foundation
import MapKit
import CoreLocation

class Note: NSObject, MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D
    let message: String
    var name: String
    var title: String?
    var id: Int = 0
    
    init(name: String, message: String, location: CLLocationCoordinate2D, id: Int = 0) {
        self.message = message
        self.coordinate = location
        self.name = name
        self.title = name
        self.id = id
        super.init()
    }
    
    var imageName: String? {
        return "Flag"
    }
    
    var location: CLLocation {
        return CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
    }
    
    func distance(to location: CLLocation) -> CLLocationDistance {
        return location.distance(from: self.location)
    }
}

typealias Notes = [Note]
