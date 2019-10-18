//
//  ViewController.swift
//  Movie
//
//  Created by saw pyaehtun on 25/09/2019.
//  Copyright © 2019 saw pyaehtun. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class MovieViewController: BaseViewController {
    
    @IBOutlet weak var tableViewMovie: UITableView!
    let numberOfItemsInRow : CGFloat = 3.0
    let spacing : CGFloat = 10
    let leadingSpace : CGFloat = 10
    let TrailingSpace : CGFloat = 10
    
    var viewModel = MovieViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setUpUIs() {
        super.setUpUIs()
        setUpTableView()
        setUpRefreshControl()
    }
    
    private func setUpTableView(){
        
        // REGISTER NEEDED CELLS
        tableViewMovie.registerForCell(strID: String(describing: MovieListTableViewCell.self))
        
        //  TABLEVIEW ROWS HEIGHT
        
        let totalPadding : CGFloat = (numberOfItemsInRow * spacing) + leadingSpace + TrailingSpace
        let itemWidth = (self.view.frame.width - totalPadding) / numberOfItemsInRow
        
        tableViewMovie.rowHeight = itemWidth * 1.9 + 50.5
        tableViewMovie.separatorStyle = .none
        tableViewMovie.refreshControl = refreshControl
        
    }
    
    override func bindModel() {
        viewModel.bindViewModel(in: self)
    }
    
    override func bindData() {
        
        refreshControl.rx.controlEvent(.valueChanged).bind(to: viewModel.tapRefetchData).disposed(by: disposableBag)
        
        viewModel.allMovieList.observeOn(MainScheduler.instance)
            .do(onNext: { [weak self] _ in
                self?.refreshControl.endRefreshing()
            })
            .bind(to: tableViewMovie.rx.items(cellIdentifier: String(describing: MovieListTableViewCell.self), cellType: MovieListTableViewCell.self)){ row, model, cell in
            switch row {
            case Category.nowPlaying.rawValue :
                cell.lblCategoryTitle.text = "Now Playing"
            case Category.popular.rawValue:
                cell.lblCategoryTitle.text = "Popular"
            case Category.topRated.rawValue:
                cell.lblCategoryTitle.text = "Top Rated"
            case Category.upComing.rawValue:
                cell.lblCategoryTitle.text = "Upcoming"
            default:
                break
            }
            cell.movieList = model
            cell.movieListTableViewCellDelegate = self
        }.disposed(by: disposableBag)
    }
}

extension MovieViewController : MovieListTableViewCellDelegate {
    func didTapCell(movie: MovieVO) {
        let vc = MovieDetailViewController.init()
        vc.movieVO = movie
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
        
    }
}
