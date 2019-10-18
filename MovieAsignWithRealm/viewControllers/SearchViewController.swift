//
//  SearchViewController.swift
//  Movie
//
//  Created by saw pyaehtun on 26/09/2019.
//  Copyright © 2019 saw pyaehtun. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class SearchViewController: BaseViewController {

    @IBOutlet weak var searchBar: SearchBarView!
    @IBOutlet weak var collectionViewSearchedMovieList: UICollectionView!
    @IBOutlet weak var lblResultTitle: UILabel!
    
    let numberOfItemsInRow : CGFloat = 3.0
    let spacing : CGFloat = 10
    let leadingSpace : CGFloat = 10
    let TrailingSpace : CGFloat = 10
    
    var viewModel = SearchViewModel()
    
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
    
    override func bindData() {
        searchBar.tfSearch.rx.text.orEmpty.bind(to: viewModel.movieName).disposed(by: disposableBag)
        searchBar.tfSearch.rx.controlEvent(.editingDidEnd).bind(to: viewModel.tapSearch).disposed(by: disposableBag)
        
        viewModel.searchResultmovieList
            .observeOn(MainScheduler.instance)
            .do(onNext: { (movielist) in
                self.lblResultTitle.text = movielist.isEmpty ? "No result found . . " : "Movies & TV"
            }).bind(to: collectionViewSearchedMovieList.rx.items(cellIdentifier: String(describing: MoviePosetCollectionViewCell.self), cellType: MoviePosetCollectionViewCell.self)){ row, model, cell in
                cell.movieVO = model
        }.disposed(by: disposableBag)
        
        collectionViewSearchedMovieList.rx.modelSelected(MovieVO.self).subscribe(onNext: { (movie) in
            let vc = MovieDetailViewController.init()
            vc.movieVO = movie
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        }).disposed(by: disposableBag)
    }
    
    private func setupCollectionView(){
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

extension SearchViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
