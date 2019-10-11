//
//  MovieListTableViewCell.swift
//  MovieAsignWithRealm
//
//  Created by saw pyaehtun on 04/10/2019.
//  Copyright © 2019 saw pyaehtun. All rights reserved.
//

import UIKit

protocol MovieListTableViewCellDelegate {
    func didTapCell(movie : MovieVO)
}

class MovieListTableViewCell: BaseTableViewCell {

    @IBOutlet weak var lblCategoryTitle: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    let numberOfItemsInRow : CGFloat = 3.0
    let spacing : CGFloat = 10
    let leadingSpace : CGFloat = 10
    let TrailingSpace : CGFloat = 10
    var movieListTableViewCellDelegate : MovieListTableViewCellDelegate?
    var movieList : [MovieVO] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }
    
    override func setupUIs() {
        setupCollectionView()
    }

    private func setupCollectionView(){
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.registerForCell(strID: String(describing: MoviePosetCollectionViewCell.self))
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        
        // calculating total padding
        let totalPadding : CGFloat = (numberOfItemsInRow * spacing) + leadingSpace + TrailingSpace
        let itemWidth = (self.contentView.frame.width - totalPadding) / numberOfItemsInRow
        
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth * 1.45)
    }
    
}

extension MovieListTableViewCell : UICollectionViewDelegate{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        movieListTableViewCellDelegate?.didTapCell(movie: movieList[indexPath.row])
    }
}

extension MovieListTableViewCell : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: MoviePosetCollectionViewCell.self), for: indexPath) as? MoviePosetCollectionViewCell
        item?.movieVO = movieList[indexPath.row]
        return item!
    }
    
}



