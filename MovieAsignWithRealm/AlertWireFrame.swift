//
//  AlertWireFrame.swift
//  MovieAsignWithRealm
//
//  Created by saw pyaehtun on 10/10/2019.
//  Copyright © 2019 saw pyaehtun. All rights reserved.
//

import Foundation
import UIKit

class AlertWireFrame {
    class func showAlert(_ title: String?, message: String?, confirmAction: UIAlertAction? = nil, cancelButtonTitle: String? = nil, cancelAction: (() -> Void)? = nil, inViewController viewController: UIViewController?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        if let confirmAction = confirmAction {
            alertController.addAction(confirmAction)
        }
        if let cancelButtonTitle = cancelButtonTitle {
            let alertCancelAction = UIAlertAction(title: cancelButtonTitle, style: .cancel) { (action) in
                cancelAction?()
            }
            alertController.addAction(alertCancelAction)
        }
        DispatchQueue.main.async {
            alertController.modalPresentationStyle = .fullScreen
            viewController?.present(alertController, animated: true, completion: nil)
        }
    }
    
    class func showCommonError(title : String = "Warning!", message : String, vc : BaseViewController) {
        showAlert(title, message: message, cancelButtonTitle: "OK", inViewController: vc)
    }
    
    
}
