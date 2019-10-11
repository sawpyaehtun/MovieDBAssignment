//
//  WatchMovieResponse.swift
//  MovieAsignWithRealm
//
//  Created by saw pyaehtun on 10/10/2019.
//  Copyright © 2019 saw pyaehtun. All rights reserved.
//

import Foundation

struct ManageWatchListResponse : Codable {
    let statusCode : Int?
    let statusMessage : String?
}

extension ManageWatchListResponse {
    func isSuccess() -> Bool {
        if self.statusMessage == "Success." && self.statusCode == 1 {
            return true
        } else {
            return false
        }
    }
}
