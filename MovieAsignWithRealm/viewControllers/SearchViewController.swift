//
//  SearchViewController.swift
//  Movie
//
//  Created by saw pyaehtun on 26/09/2019.
//  Copyright © 2019 saw pyaehtun. All rights reserved.
//

import UIKit

class SearchViewController: BaseViewController {

    @IBOutlet weak var searchBar: SearchBarView!
    @IBOutlet weak var collectionViewSearchedMovieList: UICollectionView!
    @IBOutlet weak var lblResultTitle: UILabel!
    
    let numberOfItemsInRow : CGFloat = 3.0
    let spacing : CGFloat = 10
    let leadingSpace : CGFloat = 10
    let TrailingSpace : CGFloat = 10
    
    var viewModel = SearchViewModel()
    var movieList : [MovieVO] = [] {
        didSet {
            lblResultTitle.text = movieList.isEmpty ? "No result found . . " : "Movies & TV"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func bindModel() {
        viewModel.bindViewModel(in: self)
    }
    
    override func setUpUIs() {
        super.setUpUIs()
        searchBar.tfSearch.delegate = self
        setupCollectionView()
    }
    
    private func searchMovie(movieName : String){
        viewModel.searchMovie(movieName: movieName)
    }
    
    override func bindData() {
        viewModel.searchResultmovieList.subscribe(onNext: { (movieResultList) in
            self.movieList = movieResultList
            self.collectionViewSearchedMovieList.reloadData()
        }).disposed(by: disposableBag)
    }
    
    private func setupCollectionView(){
        collectionViewSearchedMovieList.delegate = self
        collectionViewSearchedMovieList.dataSource = self
        
        collectionViewSearchedMovieList.registerForCell(strID: String(describing: MoviePosetCollectionViewCell.self))
        
        let layout = collectionViewSearchedMovieList.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        
        // calculating total padding
        let totalPadding : CGFloat = (numberOfItemsInRow * spacing) + leadingSpace + TrailingSpace
        let itemWidth = (self.view.frame.width - totalPadding) / numberOfItemsInRow
        
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth * 1.45)
    }
    
}

extension SearchViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = MovieDetailViewController.init()
        vc.movieVO = movieList[indexPath.row]
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
//        navigationController?.pushViewController(vc, animated: true)
    }
}

extension SearchViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: MoviePosetCollectionViewCell.self), for: indexPath) as? MoviePosetCollectionViewCell
        item?.movieVO = movieList[indexPath.row]
        return item!
    }
}

extension SearchViewController : UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        searchMovie(movieName: textField.text ?? "")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
