//
//  PasswordShowHideButton.swift
//  MovieAsignWithRealm
//
//  Created by saw pyaehtun on 07/10/2019.
//  Copyright © 2019 saw pyaehtun. All rights reserved.
//

import UIKit

class PasswordShowHideButton: UIButton {
    
    var isDisplaying = false {
        didSet {
            layoutSubviews()
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        setTitle(isDisplaying ? "HIDE" : "SHOW", for: .normal)
    }

}
