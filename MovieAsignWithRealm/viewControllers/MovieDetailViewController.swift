//
//  MovieDetailViewController.swift
//  Movie
//
//  Created by saw pyaehtun on 27/09/2019.
//  Copyright © 2019 saw pyaehtun. All rights reserved.
//

import UIKit
import SDWebImage

class MovieDetailViewController: BaseViewController {
    
    //    @IBOutlet weak var imgBlurViewHeigh: NSLayoutConstraint!
    @IBOutlet weak var imgBlurView: UIImageView!
    @IBOutlet weak var imgPoster: UIImageView!
    @IBOutlet weak var lblReleaseDateAdultMovieTime: UILabel!
    @IBOutlet weak var lblOverView: UILabel!
    @IBOutlet weak var collectionViewSimilarMovieList: UICollectionView!
    @IBOutlet weak var viewTopView: UIView!
    @IBOutlet weak var scrollViewMovieDetail: UIScrollView!
    @IBOutlet weak var imgMyList: UIImageView!
    @IBOutlet weak var imgRate: UIImageView!
    
    var movieVO : MovieVO? {
        didSet {
            getMovieDetail()
        }
    }
    
    var movie : MovieVO? {
        didSet {
            getSimilarMovie()
        }
    }
    
    var viewModel = MovieDetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpNavigationBar()
    }
    
    
    private func getMovieDetail(){
        if let movieVO = movieVO {
            viewModel.getMovieDetail(movieId: (movieVO.id)!)
        }
    }
    
    private func getSimilarMovie(){
        if let movie = movie {
            viewModel.getSimilarMovie(movieId: movie.id ?? 0)
        }
    }
    
    override func bindModel() {
        super.bindModel()
        viewModel.bindViewModel(in: self)
    }
    
    override func setUpUIs() {
        setupCollectionView()
        setupScrollview()
        guard let movieVO = movieVO else {return}
        imgPoster.sd_setImage(with: URL(string: "\(NetworkConfiguration.BASE_IMG_URL)\(movieVO.posterPath ?? "")"), completed: nil)
        imgBlurView.image = imgPoster.image
    }
    
    private func checkMovieInWatchList(){
        viewModel.getMovieAndCheckInWatchList(movieID: movie?.id ?? 0)
    }
    
    private func checkMovieInRatedList(){
        viewModel.getMovieAndCheckInRatedList(movieID: movie?.id ?? 0)
    }
    
    private func setupScrollview(){
        scrollViewMovieDetail.contentInsetAdjustmentBehavior = .never
    }
    
    private func displayInformation(){
        lblOverView.text = movie?.overview
        imgBlurView.frame.size.height = viewTopView.frame.height
        let adultText : String = (movie?.adult!)! ? "18+" : ""
        lblReleaseDateAdultMovieTime.text = "\(movie?.releaseDate ?? "") \(adultText) \(movie?.runtime ?? 0)"
        checkMovieInWatchList()
        checkMovieInRatedList()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imgBlurView.heightConstaint?.constant = viewTopView.frame.height
        view.superview!.setNeedsLayout()
        view.superview!.layoutIfNeeded()
    }
    
    override func bindData() {
        
        collectionViewSimilarMovieList.rx.modelSelected(MovieVO.self).subscribe(onNext: { (movie) in
            let vc = MovieDetailViewController.init()
            vc.movieVO = movie
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        }).disposed(by: disposableBag)
        
        viewModel.similarMovieListObserable.bind(to: collectionViewSimilarMovieList.rx.items(cellIdentifier: String(describing: MoviePosetCollectionViewCell.self), cellType: MoviePosetCollectionViewCell.self)){ row, model, cell in
            cell.movieVO = model
        }.disposed(by: disposableBag)
        
        viewModel.movieDetailObserable.subscribe(onNext: { (movie) in
            if let movie = movie {
                self.movie = movie
                self.displayInformation()
            }
        }).disposed(by: disposableBag)
        
        viewModel.isAddedToWatchListObserable.subscribe(onNext: { (flag) in
            self.imgMyList.tintColor = flag ? UIColor.red : UIColor.white
        }).disposed(by: disposableBag)
        
        viewModel.isRatedMovieObserable.subscribe(onNext: { (flag) in
            self.imgRate.tintColor = flag ? UIColor.red : UIColor.white
        }).disposed(by: disposableBag)
    }
    
    private func setupCollectionView(){
        
        collectionViewSimilarMovieList.registerForCell(strID: String(describing: MoviePosetCollectionViewCell.self))
        
        let layout = collectionViewSimilarMovieList.collectionViewLayout as! UICollectionViewFlowLayout
        
        layout.itemSize = CGSize(width: 130, height: 180)
    }
    
}
//MARK:- User Interaction
extension MovieDetailViewController {
    
    @IBAction func btnClose(_ sender: Any) {
//        UIApplication.shared.keyWindow?.rootViewController?.dismiss(animated: false, completion: nil)
//        self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
//        self.view.window!.rootViewController?.dismiss(animated: false, completion: nil)
//        Timer.invalidate(<#T##self: Timer##Timer#>)
        self.dismiss(animated: true, completion: nil)
//        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func didTapRate(_ sender: Any) {
        if imgRate.tintColor == UIColor.white {
            let vc = RateMovieViewController.init()
            vc.movieTitle = (movie?.title) ?? ""
            vc.rateMovieDelegate = self
            hl_addChildViewController(vc, toContainerView: self.view)
        } else {
            viewModel.removeFromRatedList(movieID: movie?.id ?? 0)
        }
    }
    
    @IBAction func didTapMyList(_ sender: Any) {
        if imgMyList.tintColor == UIColor.white {
            viewModel.addToWatchList(movieID: movie?.id ?? 0)
        } else {
            viewModel.removeFromWatchList(movieID: movie?.id ?? 0)
        }
    }
    
    @IBAction func btnPlay(_ sender: Any) {
        let vc = PlayTraillerViewController.init()
        vc.movieID = (movie?.id)!
        hl_addChildViewController(vc, toContainerView: self.view)
    }
}


//MARK:- Rate movie Delegate
extension MovieDetailViewController : RateMovieDelegate{
    func didRateMovie(value: Double) {
        viewModel.addToRatedList(movieID: movie?.id ?? 0,value : value)
    }
}
