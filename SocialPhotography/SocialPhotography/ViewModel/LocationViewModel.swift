//
//  LocationViewModel.swift
//  SocialPhotography
//
//  Created by Danish Aziz on 12/10/19.
//  Copyright © 2019 Danish Aziz. All rights reserved.
//

import UIKit
import CoreLocation

class LocationViewModel: NSObject {
    
    var dbManager: DBManager? = DBManager()
    
    // Add Location into Realm
    func addLocation(locationModel: LocationModel) {
        self.dbManager?.add(locationModel)
    }
    
    // Add Location into Realm
    func addLocations(locationModels: Locations) {
        self.dbManager?.add(locationModels)
    }
    
    // update Location into Realm
    func updateLocations(by id: Int, note: String) {
        self.dbManager?.update(id, note: note)
    }
    
    // Get Location from Realm
    func getLocations() -> Notes {
        let result = self.dbManager?.getObjectList(type: LocationModel.self)
        let locations = result?.toArray(ofType: LocationModel.self) ?? []
        var notes: Notes = []
        for location in locations {
            notes.append(Note(name: location.name, message: location.note, location: CLLocationCoordinate2D(latitude: location.lat, longitude: location.long), id: location.id))
        }
        return notes
    }
    
    func saveLocalLocationIntoRealm() {
        guard let filepath = Bundle.main.url(forResource: "locations", withExtension: "json")
            else {
                return
        }
        do {
            let data = try Data(contentsOf: filepath)
            if let locations = try? JSONDecoder().decode(Location.self, from: data) {
                var locationModels: Locations = []
                for (index, location) in locations.locations.enumerated() {
                    locationModels.append(LocationModel(name: location.name, lat: location.lat, long: location.lng, note: "", id: index + 1))
                }
                if locationModels.count > 0 {
                    self.addLocations(locationModels: locationModels)
                }
            }
        } catch {
            print("Error")
        }
    }
}
