//
//  UserVO.swift
//  MovieAsignWithRealm
//
//  Created by saw pyaehtun on 08/10/2019.
//  Copyright © 2019 saw pyaehtun. All rights reserved.
//

import Foundation

struct UserVO : Codable {
    let username : String?
    let password : String?
    let requestToken : String?
}

extension UserVO {
    func toDictionary() -> [String: Any] {
        let jsonEncoder = JSONEncoder()
        jsonEncoder.keyEncodingStrategy = .convertToSnakeCase
        let params = try! jsonEncoder.encode(self).toDictionary()
        return params
    }
}
