//
//  LoginResponse.swift
//  MovieAsignWithRealm
//
//  Created by saw pyaehtun on 08/10/2019.
//  Copyright © 2019 saw pyaehtun. All rights reserved.
//

import Foundation

struct LoginAndRequestTokenResponse : Codable{
    let success : Bool?
    let expiresAt : String?
    let requestToken : String?
}
