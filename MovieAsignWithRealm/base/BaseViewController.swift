//
//  BaseViewController.swift
//  HouseListApp
//
//  Created by saw pyaehtun on 12/09/2019.
//  Copyright © 2019 saw pyaehtun. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import RxCocoa
import RxSwift

class BaseViewController: UIViewController {

    let disposableBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationBar()
        setUpUIs()
        bindData()
        bindModel()
    }
    
    func setUpNavigationBar() {

    }
    
    func setUpUIs() {
        
    }
    
    func bindData() {
        
    }
    
    func bindModel() {
        
    }

}


extension BaseViewController {
    
    func showAlertDialog(message : String) {
        let alert = UIAlertController(title: "Failed", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}

// Note: this is for Loading View
extension BaseViewController : NVActivityIndicatorViewable {
    func showLoading(message : String = "") {
        startAnimating(CGSize(width: 30, height: 30), message: message, type: .audioEqualizer)
    }
    
    func hideLoading() {
        stopAnimating()
    }
}

// Note: this functions for setup and customise the navigation bar
//extension BaseViewController {
//    func setupMenuLeftBar() {
//        let menuBar = UIBarButtonItem(image: #imageLiteral(resourceName: "menuWhite"), style: .plain, target: self, action: #selector(openSideMenuTapped))
//        navigationItem.leftBarButtonItems = [menuBar]
//    }
//
//    func setupNavigationBar() {
//        if navigationItem.leftBarButtonItems?.count ?? 0 > 0 {
//            return
//        }
//        let backBar = UIBarButtonItem(image: #imageLiteral(resourceName: "backButtonWhite"), style: .plain, target: self, action: #selector(onBack))
//        navigationItem.leftBarButtonItems = [backBar]
//    }
//
//    func setupNavigatonBarRightItem() {
//        navigationItem.leftBarButtonItem = nil
//        navigationItem.hidesBackButton = true
//
//        if navigationItem.rightBarButtonItems?.count ?? 0 > 0 {
//            return
//        }
//
//    }
//}
