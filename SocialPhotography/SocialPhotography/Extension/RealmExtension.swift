//
//  RealmExtension.swift
//  SocialPhotography
//
//  Created by Danish Aziz on 12/10/19.
//  Copyright © 2019 Danish Aziz. All rights reserved.
//

import RealmSwift

extension Results {
    func toArray<T>(ofType: T.Type) -> [T] {
        return compactMap { $0 as? T }
    }
}
