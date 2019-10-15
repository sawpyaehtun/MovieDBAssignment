//
//  RateMovieRequest.swift
//  MovieAsignWithRealm
//
//  Created by saw pyaehtun on 11/10/2019.
//  Copyright © 2019 saw pyaehtun. All rights reserved.
//

import Foundation

struct RateMovieRequest : Codable {
    let value : Double?
}

extension RateMovieRequest {
    func toDictionary() -> [String: Any] {
        let jsonEncoder = JSONEncoder()
        jsonEncoder.keyEncodingStrategy = .convertToSnakeCase
        let params = try! jsonEncoder.encode(self).toDictionary()
        return params
    }
}
