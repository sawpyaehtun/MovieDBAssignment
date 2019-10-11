//
//  ProductionCompanyRO.swift
//  MovieRealm
//
//  Created by saw pyaehtun on 29/09/2019.
//  Copyright © 2019 saw pyaehtun. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers final class ProductionCompanyRO : Object{
    dynamic var id : Int?
    dynamic var name : String?
    dynamic var logoPath : String?
    dynamic var originCountry : String?
    
    convenience init(id : Int,name : String, logoPath : String, originCountry : String){
        self.init()
        self.id = id
        self.name = name
        self.logoPath = logoPath
        self.originCountry = originCountry
    }
}

