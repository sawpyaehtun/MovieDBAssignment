//
//  BlurView.swift
//  MovieAsignWithRealm
//
//  Created by saw pyaehtun on 04/10/2019.
//  Copyright © 2019 saw pyaehtun. All rights reserved.
//

import UIKit

@IBDesignable
class BlurView: UIVisualEffectView {

    override func layoutSubviews() {
        let blurEffectc = UIBlurEffect(style: .dark)
        self.effect = blurEffectc
    }
    
}
