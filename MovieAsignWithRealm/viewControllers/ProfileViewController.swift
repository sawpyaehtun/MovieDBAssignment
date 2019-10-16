//
//  ProfileViewController.swift
//  MovieAsignWithRealm
//
//  Created by saw pyaehtun on 07/10/2019.
//  Copyright © 2019 saw pyaehtun. All rights reserved.
//

import UIKit

class ProfileViewController: BaseViewController {
    
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblUsername: UILabel!
    @IBOutlet weak var collectionViewWatchList: UICollectionView!
    @IBOutlet weak var collectionViewRatedMovieList: UICollectionView!
    @IBOutlet weak var lblNoMovieInWatchList: UILabel!
    @IBOutlet weak var lblNoMovieInRatedList: UILabel!
    
    var accountDatil : AccountDetailVO?
    
    var watchListMovies : [MovieVO] = []{
        didSet {
            lblNoMovieInWatchList.isHidden = watchListMovies.isEmpty ? false : true
        }
    }
    
    var ratedMovieList : [MovieVO] = [] {
        didSet {
            lblNoMovieInRatedList.isHidden = ratedMovieList.isEmpty ? false : true
        }
    }
    
    let viewModel = ProfileViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setUpUIs() {
        super.setUpUIs()
        imgProfile.tintColor = UIColor.white
        setupCollectionViewWatchList()
        setupCollectionViewRatedMovieList()
    }
    
    private func setupCollectionViewWatchList(){
        collectionViewWatchList.delegate = self
        collectionViewWatchList.dataSource = self
        
        collectionViewWatchList.registerForCell(strID: String(describing: MoviePosetCollectionViewCell.self))
        
        let layout = collectionViewWatchList.collectionViewLayout as! UICollectionViewFlowLayout
        let itemHeight = collectionViewWatchList.frame.height - 20
        let itemWidth = itemHeight / 1.45
        layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
    }
    
    private func setupCollectionViewRatedMovieList(){
        collectionViewRatedMovieList.delegate = self
        collectionViewRatedMovieList.dataSource = self
        
        collectionViewRatedMovieList.registerForCell(strID: String(describing: MoviePosetCollectionViewCell.self))
        
        let layout = collectionViewRatedMovieList.collectionViewLayout as! UICollectionViewFlowLayout
        let itemHeight = collectionViewRatedMovieList.frame.height - 20
        let itemWidth = itemHeight / 1.45
        layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
    }
    
    override func bindModel() {
        super.bindModel()
        viewModel.bindViewModel(in: self)
    }
    
    private func displayProfile(){
        if let accountDetail = UserManager.shared.accountDetail {
            lblUsername.text = accountDetail.username
        }
        fetchWatchList()
        fetchRatedList()
    }
    
    override func bindData() {
        super.bindData()
        viewModel.userName.bind(to: lblUsername.rx.text).disposed(by: disposableBag)
        
        viewModel.watchListMovies.subscribe(onNext: { (movieList) in
            self.watchListMovies = movieList
            self.collectionViewWatchList.reloadData()
        }).disposed(by: disposableBag)
        
        viewModel.ratedMovieList.subscribe(onNext: { (movieList) in
            self.ratedMovieList = movieList
            self.collectionViewRatedMovieList.reloadData()
            }).disposed(by: disposableBag)
    }
    
    private func fetchWatchList(){
        viewModel.getWatchListMovie()
    }
    
    private func fetchRatedList(){
        viewModel.getRatedMovies()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkUserLoginAndDisplay()
    }
    
    private func checkUserLoginAndDisplay(){
        if CommonManger.shared.isUserLogin(){
            displayProfile()
        } else {
            let vc = LoginViewController.init()
            vc.loginViewControllerDelegate = self
            navigationController?.pushViewController(vc, animated: false)
        }
    }
    
}

//MARK:- USER INTERACTIONS
extension ProfileViewController {
    @IBAction func didTapBtnLogOut(_ sender: Any) {
        let vc = LoginViewController.init()
        vc.loginViewControllerDelegate = self
        CommonManger.shared.saveBoolToNSUserDefault(value: false, key: CommonManger.IS_USER_LOGIN)
        navigationController?.pushViewController(vc, animated: false)
    }
}

//MARK:- LoginViewController Delegate
extension ProfileViewController : LoginViewControllerDelegate{
    func successLogin() {
        displayProfile()
    }
}

//MARK:- COLLECTION VEIEWS DELEGATES AND DATASOURCES
extension ProfileViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = MovieDetailViewController.init()
        if collectionView == self.collectionViewWatchList {
            vc.movieVO = watchListMovies[indexPath.row]
        } else {
            vc.movieVO  = ratedMovieList[indexPath.row]
        }
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
}

extension ProfileViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.collectionViewWatchList {
            return watchListMovies.count
        } else {
            return ratedMovieList.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: MoviePosetCollectionViewCell.self), for: indexPath) as? MoviePosetCollectionViewCell
        if collectionView == self.collectionViewWatchList {
            item?.movieVO = watchListMovies[indexPath.row]
        } else {
            item?.movieVO = ratedMovieList[indexPath.row]
        }
        return item!
    }
    
}
