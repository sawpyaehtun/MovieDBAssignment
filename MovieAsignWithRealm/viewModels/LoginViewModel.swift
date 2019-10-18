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
    
    
    
    // input
    let userName = BehaviorRelay<String>(value: "")
    let password = BehaviorRelay<String>(value: "")
    
    // output
    let isSuccessLogin = BehaviorRelay<Bool?>(value: nil)
    let isShowPassword = BehaviorRelay<Bool>(value: false)
    
    // user interaction
    let tapSignIn : AnyObserver<Void>
    let didTapSignIn : Observable<Void>
    
    let tapShowHidePassword : AnyObserver<Void>
    let didTapShowHidePassword : Observable<Void>

    override init() {
        let _tapSignIn = PublishSubject<Void>()
        self.tapSignIn = _tapSignIn.asObserver()
        self.didTapSignIn = _tapSignIn.asObservable()
        
        let _tapShowHidePassword = PublishSubject<Void>()
        self.tapShowHidePassword = _tapShowHidePassword.asObserver()
        self.didTapShowHidePassword = _tapShowHidePassword.asObservable()
        
        super.init()
        
        didTapSignIn.subscribe(onNext: { (_) in
            self.login(username: self.userName.value, password: self.password.value)
        }).disposed(by: disposableBag)
        
        didTapShowHidePassword.subscribe(onNext: { _ in
            self.isShowPassword.accept(!self.isShowPassword.value)
        }).disposed(by: disposableBag)
    }
}

extension LoginViewModel{
    
    func login(username : String,
               password : String) {
        loadingObservable.accept(true)
        UserModel.shared.getNewToken(success: { (loginAndRespnse) in
            let userInfoForLogin = UserVO(username: username, password: password, requestToken: loginAndRespnse.requestToken)
            UserModel.shared.login(userInfoLogin: userInfoForLogin, success: {
                self.loadingObservable.accept(false)
                self.isSuccessLogin.accept(true)
            }) { (loginError) in
                self.loadingObservable.accept(false)
                self.isSuccessLogin.accept(false)
                print("an error occur while login . . . \(loginError)")
            }
        }) { (error) in
            self.isSuccessLogin.accept(false)
            self.loadingObservable.accept(false)
            print("an eror occur while getting new token . . . \(error)")
        }
    }
}
