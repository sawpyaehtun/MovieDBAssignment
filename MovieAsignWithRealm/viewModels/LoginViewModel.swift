//
//  LoginViewModel.swift
//  MovieAsignWithRealm
//
//  Created by saw pyaehtun on 08/10/2019.
//  Copyright © 2019 saw pyaehtun. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class LoginViewModel: BaseViewModel {
    
    var isValidLogin = BehaviorRelay<Bool>(value: true)
    
    func login(username : String,
               password : String,
               success : @escaping () -> Void) {
        loadingObservable.accept(true)
        UserModel.shared.getNewToken(success: { (loginAndRespnse) in
            let userInfoForLogin = UserVO(username: username, password: password, requestToken: loginAndRespnse.requestToken)
            UserModel.shared.login(userInfoLogin: userInfoForLogin, success: {
                self.loadingObservable.accept(false)
                success()
            }) { (loginError) in
                self.loadingObservable.accept(false)
                self.isValidLogin.accept(false)
                print("an error occur while login . . . \(loginError)")
            }
        }) { (error) in
            self.isValidLogin.accept(false)
            self.loadingObservable.accept(false)
            print("an eror occur while getting new token . . . \(error)")
        }
    }
}
