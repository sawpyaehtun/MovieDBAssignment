//
//  CategoryRO.swift
//  MovieAsignWithRealm
//
//  Created by saw pyaehtun on 03/10/2019.
//  Copyright © 2019 saw pyaehtun. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers class CategoryRO : Object {
    dynamic var id  : Int = 0
    dynamic var name : String?
    
    convenience init(id : Int, name : String) {
        self.init()
        self.id = id
        self.name = name
    }
    
    override class func primaryKey() -> String? {
        return "id"
    }
}
