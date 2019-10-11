//
//  ButtonLabelAndBorderWhite.swift
//  MovieAsignWithRealm
//
//  Created by saw pyaehtun on 07/10/2019.
//  Copyright © 2019 saw pyaehtun. All rights reserved.
//

import UIKit

@IBDesignable
class ButtonLabelAndBorderWhite: UIButton {

    @IBInspectable var cornerRadius : CGFloat = 5
    @IBInspectable var borderWidth :  CGFloat = 1.0
    @IBInspectable var borderColor :  UIColor? = UIColor.white
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = cornerRadius
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor?.cgColor
    }

}
