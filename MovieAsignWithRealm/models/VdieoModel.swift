//
//  VdieoModel.swift
//  MovieAsignWithRealm
//
//  Created by saw pyaehtun on 07/10/2019.
//  Copyright © 2019 saw pyaehtun. All rights reserved.
//

import Foundation
import SwiftyJSON

final class VideoModel {
    
    static let shared = VideoModel()
    init() {}
    
    func getTrailerVideos(movieId : Int, success : @escaping ([VideoVO]) -> Void,faulire : @escaping (String) -> Void) {
        NetworkClient.shared.request(url: String(format: MovieAPI.movie.video.urlString(), "\(movieId)"), success: { (data) in
            
            let json = JSON(data)
            let value = json["results"]
            let jsonString = value.rawString()
            do {
                
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                //MARK:- GET MOVIE LIST FORM API
                let videoList = try
                    decoder.decode([VideoVO].self, from: Data(jsonString!.utf8))
                success(videoList)
            } catch let jsonError{
                print(jsonError)
                faulire(jsonError.localizedDescription)
            }
        }) { (err) in
            print("fail fatching search movies result due to \(err)")
            faulire(err)
        }
    }
}
