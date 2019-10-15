//
//  WatchMovieResponse.swift
//  MovieAsignWithRealm
//
//  Created by saw pyaehtun on 10/10/2019.
//  Copyright © 2019 saw pyaehtun. All rights reserved.
//

import Foundation

struct ManageListResponse : Codable {
    let statusCode : Int?
    let statusMessage : String?
}

extension ManageListResponse {
    func isSuccess() -> Bool {
        if self.statusMessage == "Success." && self.statusCode == 1 {
            return true
        } else {
            return false
        }
    }
}
