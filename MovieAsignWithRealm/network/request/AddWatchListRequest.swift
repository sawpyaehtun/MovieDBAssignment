//
//  AddWatchListRequest.swift
//  MovieAsignWithRealm
//
//  Created by saw pyaehtun on 09/10/2019.
//  Copyright © 2019 saw pyaehtun. All rights reserved.
//

import Foundation

struct AddWatchListRequest : Codable {
    let mediaType : String?
    let mediaId : Int?
    let watchlist : Bool?
}

extension AddWatchListRequest {
    func toDictionary() -> [String: Any] {
        let jsonEncoder = JSONEncoder()
        jsonEncoder.keyEncodingStrategy = .convertToSnakeCase
        let params = try! jsonEncoder.encode(self).toDictionary()
        return params
    }
}
