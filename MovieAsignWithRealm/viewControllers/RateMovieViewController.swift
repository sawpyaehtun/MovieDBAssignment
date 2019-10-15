//
//  RateMovieViewController.swift
//  MovieAsignWithRealm
//
//  Created by saw pyaehtun on 15/10/2019.
//  Copyright © 2019 saw pyaehtun. All rights reserved.
//

import UIKit
import Cosmos

protocol RateMovieDelegate {
    func didRateMovie(value : Double)
}

class RateMovieViewController: BaseViewController {
    
    @IBOutlet weak var lblMovieTitle: UILabel!
    @IBOutlet weak var ratingView: CosmosView!
    
    var rateMovieDelegate : RateMovieDelegate?
    var movieTitle : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setUpUIs() {
        super.setUpUIs()
        
//        let tapGestureRecogniser = UITapGestureRecognizer(target: self, action: #selector(didTapToBackGroundView(sender:)))
//        self.view.isUserInteractionEnabled = true
//        self.view.addGestureRecognizer(tapGestureRecogniser)
        
        lblMovieTitle.text = movieTitle
    }
    
    @objc func didTapToBackGroundView(sender : UITapGestureRecognizer){
        if !self.view.subviews.contains(sender.view!){
            self.closeThis()
        }
    }
    
    private func closeThis(){
        hl_removeFromParentViewController(moveupAnimation: false)
    }
    
    @IBAction func didTapRateBtn(_ sender: Any) {
        rateMovieDelegate?.didRateMovie(value: ratingView.rating * 2)
        closeThis()
    }
    
    @IBAction func didTapCancelBtn(_ sender: Any) {
        closeThis()
    }
}
