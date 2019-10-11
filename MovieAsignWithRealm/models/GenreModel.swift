//
//  GenreModel.swift
//  Movie
//
//  Created by saw pyaehtun on 27/09/2019.
//  Copyright © 2019 saw pyaehtun. All rights reserved.
//

import Foundation
import SwiftyJSON
import CoreData

class GenreModel {
    
    static let shared = GenreModel()
    
    func fetchGeners(success : @escaping ([GenreVO]) -> Void, failure: @escaping (String) -> Void) {
        NetworkClient.shared.request(url: MovieAPI.genre.urlString(), success: { (data) in
            
            data.filterByKey(key: MovieResponseKey.genres.keyString()).decode(modelType: [GenreVO].self, success: { (genreList) in
                self.saveToRealm(genreVOs: genreList)
                success(genreList)
            }) { (err) in
                print(err)
                failure(err)
            }
        }) { (err) in
            print("fail fatching top rated movies due to \(err)")
            failure(err)
        }
    }
    
    func saveToRealm(genreVO : GenreVO) {
        let genreRO = genreVO.toGenreRO()
        DBManager.sharedInstance.addData(object: genreRO)
    }
    
    func saveToRealm(genreVOs : [GenreVO]) {
        let genreROs = genreVOs.toGenreROs()
        DBManager.sharedInstance.addData(objectArray: genreROs)
    }
    
    func getGenreList(success : @escaping ([GenreVO]) -> Void) {
        if let genreROs = DBManager.sharedInstance.getDataFromDB(roName: .GenreRO){
            success(genreROs.toGenreVOs())
        }
    }
    
    func getGenreROByID(genreId : Int) -> GenreRO? {
        guard let genreRO = DBManager.sharedInstance.getObjectById(id: genreId, roName: .GenreRO) as? GenreRO else {return nil}
        return genreRO
    }
}

