//
//  DBManager.swift
//  SocialPhotography
//
//  Created by Danish Aziz on 12/10/19.
//  Copyright © 2019 Danish Aziz. All rights reserved.
//

import RealmSwift

class DBManager: NSObject {
    
    private let realm = try! Realm()
    
    func add(_ object: Object) {
        try! realm.write {
            realm.add(object)
        }
    }
    
    func add(_ objects: [Object]) {
        try! realm.write {
            realm.add(objects)
        }
    }
    
    func update(_ id: Int, note: String){
        let location = self.getObject(type: LocationModel.self, filter: "id == \(id)") as! LocationModel
        try! realm.write {
            location.note = note
        }
    }
    
    func update(_ objects: [Object]) {
        try! realm.write {
            realm.add(objects, update: .all)
        }
    }
    
    func delete(_ object: Object) {
        try! realm.write {
            realm.delete(object)
        }
    }
    
    func getObject(type: Object.Type, filter: String = "") -> Object? {
        if filter.isEmpty {
            let result = realm.objects(type).first
            return result
        } else {
            let result = realm.objects(type).filter(filter).first
            return result
        }
    }
    
    func getObjectList(type: Object.Type, filter: String = "") -> Results<Object> {
        if filter.isEmpty {
            let result = realm.objects(type)
            return result
        } else {
            let result = realm.objects(type).filter(filter)
            return result
        }
    }
}

