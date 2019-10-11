//
//  PlayTraillerViewController.swift
//  MovieAsignWithRealm
//
//  Created by saw pyaehtun on 05/10/2019.
//  Copyright © 2019 saw pyaehtun. All rights reserved.
//

import UIKit
import WebKit

class PlayTraillerViewController: BaseViewController {
    
    @IBOutlet weak var wkWebView: WKWebView!
    
    var viewModel = PlayTrailerViewModel()
    var movieID : Int = 0 {
        didSet {
            getTrillerVideos()
        }
    }
    
    var trillerList : [VideoVO] = []{
        didSet {
            if trillerList.count > 0 {
                playTriller(key: trillerList.first!.key!)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func playTriller(key : String){
        //        let myURL = URL(string: "https://www.youtube.com/watch?v=\(key)")
        let myURL = URL(string: "https://www.youtube.com/embed/\(key)")
        let youtubeRequest = URLRequest(url: myURL!)
        wkWebView.load(youtubeRequest)
    }
    
    override func bindModel() {
        super.bindModel()
        viewModel.bindViewModel(in: self)
    }
    
    private func getTrillerVideos(){
        viewModel.getTrillerVideos(movieId: movieID)
    }
    
    override func bindData() {
        viewModel.trillerVideos.subscribe(onNext: { (videoList) in
            if let videoList = videoList {
                self.trillerList = videoList
            }
        }).disposed(by: disposableBag)
    }
    
    override func setUpUIs() {
        super.setUpUIs()
        self.view.isUserInteractionEnabled = true
        let tapGestureRecogniser = UITapGestureRecognizer(target: self, action: #selector(closeThis))
        self.view.addGestureRecognizer(tapGestureRecogniser)
        wkWebView.navigationDelegate = self
    }
    
    @objc func closeThis(){
        hl_removeFromParentViewController(moveupAnimation: true)
    }
    
}

extension PlayTraillerViewController : WKNavigationDelegate{
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        hideLoading()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        hideLoading()
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        showLoading()
    }
}
