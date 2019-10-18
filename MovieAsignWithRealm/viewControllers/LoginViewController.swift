//
//  LoginViewController.swift
//  MovieAsignWithRealm
//
//  Created by saw pyaehtun on 08/10/2019.
//  Copyright © 2019 saw pyaehtun. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

protocol LoginViewControllerDelegate {
    func successLogin()
}
class LoginViewController: BaseViewController {
    
    @IBOutlet weak var lblErrorLogin: UILabel!
    @IBOutlet weak var tfUsername: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var btnPasswordShowHide: PasswordShowHideButton!
    @IBOutlet weak var btnSignIn: ButtonLabelAndBorderWhite!
    
    var loginViewControllerDelegate : LoginViewControllerDelegate?
    let viewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func bindModel() {
        super.bindModel()
        viewModel.bindViewModel(in: self)
    }
    
    override func bindData() {
        tfUsername.rx.text.orEmpty.bind(to: viewModel.userName).disposed(by: disposableBag)
        tfPassword.rx.text.orEmpty.bind(to: viewModel.password).disposed(by: disposableBag)
        btnSignIn.rx.tap.bind(to: viewModel.tapSignIn).disposed(by: disposableBag)
        btnPasswordShowHide.rx.tap.bind(to: viewModel.tapShowHidePassword).disposed(by: disposableBag)
        
        viewModel.isShowPassword.subscribe(onNext: { (isShowPass) in
            self.btnPasswordShowHide.isDisplaying = isShowPass
            self.tfPassword.isSecureTextEntry = !isShowPass
            }).disposed(by: disposableBag)
        
        viewModel.isSuccessLogin.subscribe(onNext: { (isSuccess) in
            guard let isSuccess = isSuccess else {return}
            if isSuccess {
                self.loginViewControllerDelegate?.successLogin()
                CommonManger.shared.saveBoolToNSUserDefault(value: true, key: CommonManger.IS_USER_LOGIN)
                self.navigationController?.viewControllers.removeLast()
            } else {
                self.lblErrorLogin.isHidden = isSuccess
            }
        }).disposed(by: disposableBag)
    }
}
