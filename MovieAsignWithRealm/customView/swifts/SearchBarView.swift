//
//  SearchDataView.swift
//  PADCHotelBooking
//
//  Created by saw pyaehtun on 06/09/2019.
//  Copyright © 2019 saw pyaehtun. All rights reserved.
//

import UIKit

class SearchBarView: UIView {

    @IBOutlet weak var tfSearch: UITextField!
    @IBOutlet weak var imgClearText: UIImageView!
    
    var id : Int?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInitialization()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInitialization()
    }
    
    func commonInitialization() {
        let view = Bundle.main.loadNibNamed(String(describing: SearchBarView.self), owner: self, options: nil)?.first as! UIView
        view.frame = self.bounds
        self.addSubview(view)
        
        imgClearText.isUserInteractionEnabled = true
        let tapGestureRecogniser = UITapGestureRecognizer(target: self, action: #selector(didTapImgClearText))
        imgClearText.addGestureRecognizer(tapGestureRecogniser)
    }
    
    @objc func didTapImgClearText(){
        tfSearch.text = ""
    }
}
