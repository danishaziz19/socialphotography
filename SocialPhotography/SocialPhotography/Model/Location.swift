//
//  Location.swift
//  SocialPhotography
//
//  Created by Danish Aziz on 12/10/19.
//  Copyright © 2019 Danish Aziz. All rights reserved.
//

import UIKit

// MARK: - Location
struct Location: Codable {
    let locations: [LocationElement]
    let updated: String
    
    enum CodingKeys: String, CodingKey {
        case locations = "locations"
        case updated = "updated"
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.locations = try values.decode([LocationElement].self, forKey: .locations)
        self.updated = try values.decode(String.self, forKey: .updated)
    }
}

// MARK: - LocationElement
struct LocationElement: Codable {
    let name: String
    let lat: Double
    let lng: Double
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case lat = "lat"
        case lng = "lng"
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try values.decode(String.self, forKey: .name)
        self.lat = try values.decode(Double.self, forKey: .lat)
        self.lng = try values.decode(Double.self, forKey: .lng)
    }
}
