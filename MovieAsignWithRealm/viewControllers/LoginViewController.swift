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
        viewModel.isValidLogin.bind(to: lblErrorLogin.rx.isHidden).disposed(by: disposableBag)
    }
}

//MARK:- USER INTERACTIONS
extension LoginViewController{
    
    @IBAction func didTapBtnPasswordShowHide(_ sender: Any) {
        btnPasswordShowHide.isDisplaying = !btnPasswordShowHide.isDisplaying
        tfPassword.isSecureTextEntry = !btnPasswordShowHide.isDisplaying
    }
    
    @IBAction func didTapBtnSignIn(_ sender: Any) {
        viewModel.login(username: tfUsername.text!, password: tfPassword.text!) {
            self.loginViewControllerDelegate?.successLogin()
            CommonManger.shared.saveBoolToNSUserDefault(value: true, key: CommonManger.IS_USER_LOGIN)
            self.navigationController?.viewControllers.removeLast()
        }
    }
}
