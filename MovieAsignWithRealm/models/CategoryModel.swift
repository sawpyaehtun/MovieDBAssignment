//
//  CategoryModel.swift
//  MovieAsignWithRealm
//
//  Created by saw pyaehtun on 04/10/2019.
//  Copyright © 2019 saw pyaehtun. All rights reserved.
//

import Foundation

final class CategoryModel {
    static let shared = CategoryModel()
    
    func getCategoryROByID(categoryID : Int) -> CategoryRO {
        let categoryRO = DBManager.sharedInstance.getObjectById(id: categoryID, roName: .CategoryRO) as! CategoryRO
        return categoryRO
    }
}
