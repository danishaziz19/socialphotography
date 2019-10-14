//
//  LocationModel.swift
//  SocialPhotography
//
//  Created by Danish Aziz on 12/10/19.
//  Copyright © 2019 Danish Aziz. All rights reserved.
//

import Foundation
import RealmSwift
import CoreLocation

class LocationModel: Object {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var lat: Double = 0.0
    @objc dynamic var long: Double = 0.0
    @objc dynamic var note: String = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    func incrementID() -> Int {
        let realm = try! Realm()
        return (realm.objects(LocationModel.self).max(ofProperty: "id") as Int? ?? 0) + 1
    }
    
    convenience init(name: String, lat: Double, long: Double, note: String) {
        self.init()
        self.id = self.incrementID()
        self.name = name
        self.lat = lat
        self.long = long
        self.note = note
    }
    
    convenience init(name: String, lat: Double, long: Double, note: String, id: Int) {
        self.init()
        self.id = id
        self.name = name
        self.lat = lat
        self.long = long
        self.note = note
    }
}

typealias Locations = [LocationModel]
