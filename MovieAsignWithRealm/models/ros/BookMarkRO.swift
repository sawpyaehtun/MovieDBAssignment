//
//  BookMarkRO.swift
//  MovieRealm
//
//  Created by saw pyaehtun on 29/09/2019.
//  Copyright © 2019 saw pyaehtun. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers final class BookMarkRO : Object {
    dynamic var id : Int?
    
    convenience init(id : Int){
        self.init()
        self.id = id
    }
}

