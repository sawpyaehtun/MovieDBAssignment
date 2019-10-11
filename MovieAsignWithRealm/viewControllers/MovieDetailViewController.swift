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
    
    var similarMovieList : [MovieVO] = []
    let viewModel = MovieDetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpNavigationBar()
    }
    
    @IBAction func btnClose(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
        viewModel.checkMovieInWatchList(movieID: movie?.id ?? 0)
    }
    
    private func setupScrollview(){
        scrollViewMovieDetail.contentInsetAdjustmentBehavior = .never
    }
    
    @IBAction func didTapRate(_ sender: Any) {
        
    }
    
    @IBAction func didTapMyList(_ sender: Any) {
        if imgMyList.tintColor == UIColor.white {
            viewModel.addToWatchList(movieID: movie?.id ?? 0)
        } else {
            viewModel.reMoveFromWatchList(movieID: movie?.id ?? 0)
        }
    }
    
    @IBAction func btnPlay(_ sender: Any) {
        let vc = PlayTraillerViewController.init()
        vc.movieID = (movie?.id)!
        hl_addChildViewController(vc, toContainerView: self.view)
    }
    
    private func displayInformation(){
        lblOverView.text = movie?.overview
        imgBlurView.frame.size.height = viewTopView.frame.height
        let adultText : String = (movie?.adult!)! ? "18+" : ""
        lblReleaseDateAdultMovieTime.text = "\(movie?.releaseDate ?? "") \(adultText) \(movie?.runtime ?? 0)"
        checkMovieInWatchList()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imgBlurView.heightConstaint?.constant = viewTopView.frame.height
    }
    
    override func bindData() {
        viewModel.similarMovieListObserable.subscribe(onNext: { (movielist) in
            self.similarMovieList = movielist
            self.collectionViewSimilarMovieList.reloadData()
        }).disposed(by: disposableBag)
        
        viewModel.movieDetailObserable.subscribe(onNext: { (movie) in
            if let movie = movie {
                self.movie = movie
                self.displayInformation()
            }
        }).disposed(by: disposableBag)
        
        viewModel.isAddedToWatchListObserable.subscribe(onNext: { (flag) in
            self.imgMyList.tintColor = flag ? UIColor.red : UIColor.white
        }).disposed(by: disposableBag)
    }
    
    private func setupCollectionView(){
        collectionViewSimilarMovieList.delegate = self
        collectionViewSimilarMovieList.dataSource = self
        
        collectionViewSimilarMovieList.registerForCell(strID: String(describing: MoviePosetCollectionViewCell.self))
        
        let layout = collectionViewSimilarMovieList.collectionViewLayout as! UICollectionViewFlowLayout
        
        layout.itemSize = CGSize(width: 130, height: 180)
    }
    
}

extension MovieDetailViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = MovieDetailViewController.init()
        vc.movieVO = similarMovieList[indexPath.row]
        self.present(vc, animated: true, completion: nil)
    }
}

extension MovieDetailViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return similarMovieList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: MoviePosetCollectionViewCell.self), for: indexPath) as? MoviePosetCollectionViewCell
        item?.movieVO = similarMovieList[indexPath.row]
        return item!
    }
    
    
}
