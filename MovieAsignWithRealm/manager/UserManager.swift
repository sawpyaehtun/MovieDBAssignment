//
//  UserManager.swift
//  MovieAsignWithRealm
//
//  Created by saw pyaehtun on 10/10/2019.
//  Copyright © 2019 saw pyaehtun. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class UserManager {
    static let shared = UserManager()
    
    var accountDetailObserable = BehaviorRelay<AccountDetailVO?>(value: nil)
    
    var accountDetail : AccountDetailVO? {
        get{
            return accountDetailObserable.value
        }
        
        set {
            self.accountDetailObserable.accept(newValue)
        }
    }
    
    init() {
        if let accountDetail = CommonManger.shared.getUserAccountDetail(){
            self.accountDetail = accountDetail
        }
    }
}
