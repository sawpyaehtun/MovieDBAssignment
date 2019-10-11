//
//  GenreRO.swift
//  MovieRealm
//
//  Created by saw pyaehtun on 29/09/2019.
//  Copyright © 2019 saw pyaehtun. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers final class GenreRO : Object {
    dynamic var id : Int = 0
    dynamic var name : String?
    
    convenience init(id : Int?, name : String?){
        self.init()
        self.id = id ?? 0
        self.name = name
    }
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
}

