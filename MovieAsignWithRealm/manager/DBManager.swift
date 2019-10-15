//
//  DBManager.swift
//  Haulio
//
//  Created by saw pyaehtun on 15/07/2019.
//  Copyright © 2019 Haulio Pte Ltd. All rights reserved.
//

import Foundation
import RealmSwift

enum  ROname : String {
    case MovieRO
    case GenreRO
    case BookMarkRO
    case ProductionCompanyRO
    case CategoryRO
}

class DBManager {
    private var   database:Realm
    static let   sharedInstance = DBManager()
    
    private init() {
        database = try! Realm()
         print(Realm.Configuration.defaultConfiguration.fileURL!)
        
        if let categories = self.getDataFromDB(roName: .CategoryRO), categories.isEmpty {
            for i in 1...4 {
                var name = ""
                switch i {
                case Category.nowPlaying.rawValue :
                    name = "Now Playing"
                case Category.popular.rawValue :
                    name = "Popular"
                case Category.upComing.rawValue :
                    name = "Upcoming"
                case Category.topRated.rawValue :
                    name = "Top Rated"
                default:
                    name = ""
                }
                self.addData(object: CategoryRO(id: i, name: name))
            }
        }
    }
    
    //MARK:- retrieve all from of one model
    func getDataFromDB(roName : ROname) ->   [Object]! {
        switch roName {
        case .MovieRO:
            let results: Results<MovieRO> =   database.objects(MovieRO.self)
            return Array(results)
        case .GenreRO:
            let results: Results<GenreRO> =   database.objects(GenreRO.self)
            return Array(results)
        case .BookMarkRO:
            let results: Results<BookMarkRO> =   database.objects(BookMarkRO.self)
            return Array(results)
        case .ProductionCompanyRO:
            let results: Results<ProductionCompanyRO> =   database.objects(ProductionCompanyRO.self)
            return Array(results)
        case .CategoryRO:
            let results : Results<CategoryRO> = database.objects(CategoryRO.self)
            return Array(results)
        }
    }
    
    
    // MARK:- UPDATE
    func update(object : Object, dictiionary : [String : Any?]) {
        do {
            try database.write {
                for (key,value) in dictiionary {
                    object.setValue(value, forKey: key)
                }
            }
        } catch let dberror {
            print("Realm Debug : error occur when updating \(dberror.localizedDescription)")
        }
    }
    
    //MARK: create or insert to database
    func addData(object : Object) {
        do{
            try database.write {
                database.add(object,update: .modified)
                print("completely added . . .")
            }
        } catch {
            print("Realm Debug : error occur when adding \(error)")
        }
    }
    
    func addData(objectArray: [Object])   {
        do{
            try database.write {
                database.add(objectArray, update: .modified)
                print("completely added . . .")
            }
        } catch {
            print("Realm Debug : error occur when adding \(error)")
        }
    }
    
    //MARK:- retrieve by predicate
    func getObjectById(id : Int,roName : ROname) -> Object? {
        let predicate = NSPredicate(format: "id == \(id)")
        
        switch roName {
        case .MovieRO:
            let result = database.objects(MovieRO.self).filter(predicate)
            return result.count > 0 ? result[0] : nil
        case .GenreRO:
            let result = database.objects(GenreRO.self).filter(predicate)
            return result.count > 0 ? result[0] : nil
        case .BookMarkRO:
            let result = database.objects(BookMarkRO.self).filter(predicate)
            return result.count > 0 ? result[0] : nil
        case .ProductionCompanyRO:
            let result = database.objects(ProductionCompanyRO.self).filter(predicate)
            return result.count > 0 ? result[0] : nil
        case .CategoryRO:
            let result = database.objects(CategoryRO.self).filter(predicate)
            return result.count > 0 ? result[0] : nil
        }
        
    }
    
    func getObjArrayByKey(key : String,property : String,roName : ROname) -> [Object]? {
           let predicate = NSPredicate(format: "\(property) == \(key)")
           
           switch roName {
           case .MovieRO:
               let result = database.objects(MovieRO.self).filter(predicate)
               return result.count > 0 ? Array(result) : nil
           case .GenreRO:
               let result = database.objects(GenreRO.self).filter(predicate)
               return result.count > 0 ? Array(result) : nil
           case .BookMarkRO:
               let result = database.objects(BookMarkRO.self).filter(predicate)
               return result.count > 0 ? Array(result) : nil
           case .ProductionCompanyRO:
               let result = database.objects(ProductionCompanyRO.self).filter(predicate)
               return result.count > 0 ? Array(result) : nil
           case .CategoryRO:
               let result = database.objects(CategoryRO.self).filter(predicate)
               return result.count > 0 ? Array(result) : nil
           }
           
       }
    
}
