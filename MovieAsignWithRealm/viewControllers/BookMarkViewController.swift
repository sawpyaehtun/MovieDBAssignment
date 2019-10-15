//
//  BookMarkViewController.swift
//  Movie
//
//  Created by saw pyaehtun on 26/09/2019.
//  Copyright © 2019 saw pyaehtun. All rights reserved.
//

import UIKit

class BookMarkViewController: BaseViewController {
    @IBOutlet weak var collectionView: UICollectionView!
        
        let numberOfItemsInRow : CGFloat = 3.0
        let spacing : CGFloat = 10
        let leadingSpace : CGFloat = 10
        let TrailingSpace : CGFloat = 10
        let viewModel = BookMarkViewModel()
     var movieList : [MovieVO] = []
        override func viewDidLoad() {
            super.viewDidLoad()
         
            setupCollerctionView()
        }
    
    override func viewWillAppear(_ animated: Bool) {
        getBookMarkList()
        collectionView.reloadData()
    }
    
    func getBookMarkList() {
//        viewModel.getmoviesInBookmark()
    }
    
    override func bindData() {
        viewModel.moviesInBookmark.subscribe(onNext: { (movieVOs) in
            self.movieList = movieVOs
            }).disposed(by: disposableBag)
    }
    
    override func bindModel() {
        super.bindModel()
        viewModel.bindViewModel(in: self)
    }
        
        private func setupCollerctionView(){
            collectionView.delegate = self
            collectionView.dataSource = self
            
            collectionView.registerForCell(strID: String(describing: MoviePosetCollectionViewCell.self))
            
            let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
            layout.minimumLineSpacing = spacing
            layout.minimumInteritemSpacing = spacing
            
            // calculating total padding
            let totalPadding : CGFloat = (numberOfItemsInRow * spacing) + leadingSpace + TrailingSpace
            let itemWidth = (self.view.frame.width - totalPadding) / numberOfItemsInRow
            
            layout.itemSize = CGSize(width: itemWidth, height: itemWidth * 1.45)
        }
        
    }

    extension BookMarkViewController : UICollectionViewDelegate{
        func numberOfSections(in collectionView: UICollectionView) -> Int {
            return 1
        }
        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            let vc = MovieDetailViewController.init()
            vc.movieVO = movieList[indexPath.row]
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
//            navigationController?.pushViewController(vc, animated: true)
        }
    }

    extension BookMarkViewController : UICollectionViewDataSource{
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return movieList.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let item = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: MoviePosetCollectionViewCell.self), for: indexPath) as? MoviePosetCollectionViewCell
            item?.movieVO = movieList[indexPath.row]
            return item!
        }
}
