//
//  AccountDetailVO.swift
//  MovieAsignWithRealm
//
//  Created by saw pyaehtun on 08/10/2019.
//  Copyright © 2019 saw pyaehtun. All rights reserved.
//

import Foundation

struct AccountDetailVO : Codable {
    let id: Int?
    let name : String?
    let includeAdult : Bool?
    let username : String?
}

extension AccountDetailVO {
    func toData() -> Data? {
        let encoder = JSONEncoder()
        do {
            return try encoder.encode(self)
        } catch let encodingError {
            print(encodingError)
            return nil
        }
    }
}
