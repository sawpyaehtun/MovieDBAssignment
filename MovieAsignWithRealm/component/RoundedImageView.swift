//
//  RoundedImageView.swift
//  MovieAsignWithRealm
//
//  Created by saw pyaehtun on 09/10/2019.
//  Copyright © 2019 saw pyaehtun. All rights reserved.
//

import UIKit

@IBDesignable
class RoundedImageView: UIImageView {

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = self.frame.height / 2
    }
}
