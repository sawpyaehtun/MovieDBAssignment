//
//  ViewController.swift
//  Movie
//
//  Created by saw pyaehtun on 25/09/2019.
//  Copyright © 2019 saw pyaehtun. All rights reserved.
//

import UIKit

class MovieViewController: BaseViewController {
    
    @IBOutlet weak var tableViewMovie: UITableView!
    let numberOfItemsInRow : CGFloat = 3.0
    let spacing : CGFloat = 10
    let leadingSpace : CGFloat = 10
    let TrailingSpace : CGFloat = 10
    
    var viewModel = MovieViewModel()
    var allMovieList : [MovieVO] = [] {
        didSet {
            popularMovieList = allMovieList.filter({ (movieVO) -> Bool in
                return (movieVO.categories?.contains(Category.popular.rawValue))!
            })
            
            topRatedMovieList = allMovieList.filter({ (movieVO) -> Bool in
                return (movieVO.categories?.contains(Category.topRated.rawValue))!
            })
            
            nowPlayingMovieList = allMovieList.filter({ (movieVO) -> Bool in
                return (movieVO.categories?.contains(Category.nowPlaying.rawValue))!
            })
            
            upComingMovieList = allMovieList.filter({ (movieVO) -> Bool in
                return (movieVO.categories?.contains(Category.upComing.rawValue))!
            })
        }
    }
    var popularMovieList : [MovieVO] = []
    var topRatedMovieList : [MovieVO] = []
    var nowPlayingMovieList : [MovieVO] = []
    var upComingMovieList : [MovieVO] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        print(MovieAPI.movie.urlString())
        fetchAllMovies()
    }
    
    override func setUpUIs() {
        super.setUpUIs()
       setUpTableView()
    }
    
    private func setUpTableView(){
        //MARK:- SETUP DELEGATE AND DATASOURCE
        tableViewMovie.delegate = self
        tableViewMovie.dataSource = self
        
        //MARK:- REGISTER NEEDED CELLS
        tableViewMovie.registerForCell(strID: String(describing: MovieListTableViewCell.self))
        
        //MARK:- TABLEVIEW ROWS HEIGHT
        
        let totalPadding : CGFloat = (numberOfItemsInRow * spacing) + leadingSpace + TrailingSpace
        let itemWidth = (self.view.frame.width - totalPadding) / numberOfItemsInRow
        
        tableViewMovie.rowHeight = itemWidth * 1.9 + 50.5
        tableViewMovie.separatorStyle = .none

    }
    
    private func fetchAllMovies(){
            viewModel.fetchAllMovie()
    }
    
    override func bindModel() {
        viewModel.allMovieList.subscribe(onNext: { (movieVOs) in
            self.allMovieList = movieVOs
            self.tableViewMovie.reloadData()
        }).disposed(by: disposableBag)
    }
    
    override func bindData() {
        viewModel.bindViewModel(in: self)
    }
}

extension MovieViewController : UITableViewDelegate{
    
}

extension MovieViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MovieListTableViewCell.self), for: indexPath) as? MovieListTableViewCell {
            switch indexPath.row {
            case 0:
                cell.movieList = nowPlayingMovieList
                cell.lblCategoryTitle.text = "Now Playing"
            case 1:
                cell.movieList = popularMovieList
                cell.lblCategoryTitle.text = "Popular"
            case 2:
                cell.movieList = topRatedMovieList
                cell.lblCategoryTitle.text = "Top Rated"
            case 3:
                cell.movieList = upComingMovieList
                cell.lblCategoryTitle.text = "Upcoming"
            default:
                break
            }
            cell.movieListTableViewCellDelegate = self
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
}

extension MovieViewController : MovieListTableViewCellDelegate {
    func didTapCell(movie: MovieVO) {
        let vc = MovieDetailViewController.init()
        vc.movieVO = movie
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
//        navigationController?.pushViewController(vc, animated: true)
    }
}
