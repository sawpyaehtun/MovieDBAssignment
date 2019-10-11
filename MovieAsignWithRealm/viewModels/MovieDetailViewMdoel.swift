//
//  MovieDetailViewMdoel.swift
//  Movie
//
//  Created by saw pyaehtun on 28/09/2019.
//  Copyright © 2019 saw pyaehtun. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class MovieDetailViewModel: BaseViewModel {
    
    var similarMovieListObserable = BehaviorRelay<[MovieVO]>(value: [])
    var movieDetailObserable = BehaviorRelay<MovieVO?>(value: nil)
    var isAddedToWatchListObserable = BehaviorRelay<Bool>(value: false)
    
    func getSimilarMovie(movieId : Int) {
        loadingObservable.accept(true)
        MovieModel.shared.getSimilarMovie(movieId: movieId, success: { (movieVOs) in
            self.loadingObservable.accept(false)
            self.similarMovieListObserable.accept(movieVOs)
        }) { (error) in
            self.loadingObservable.accept(false)
            print(error)
        }
    }
    
    func checkMovieInWatchList(movieID : Int) {
        UserModel.shared.getWatchListMovies(success: { (movieList) in
            if !movieList.isEmpty {
                let idArray = movieList.map { (movie) -> Int in
                    return movie.id ?? 0
                }
                if idArray.contains(movieID) {
                    self.isAddedToWatchListObserable.accept(true)
                } else {
                    self.isAddedToWatchListObserable.accept(false)
                }
            }
        }) { (err) in
            print(err)
            self.errorObservable.accept(err)
        }
    }
    
    func getMovieDetail(movieId : Int) {
        loadingObservable.accept(true)
        MovieModel.shared.getMovieDetail(movieId: movieId, success: { (movie) in
            self.loadingObservable.accept(false)
            self.movieDetailObserable.accept(movie)
        }) { (error) in
            self.loadingObservable.accept(false)
            print(error)
        }
    }
    
    func addToWatchList(movieID : Int) {
        loadingObservable.accept(true)
        UserModel.shared.addToWatchListMovie(movieID: movieID, success: {
            self.loadingObservable.accept(false)
            self.isAddedToWatchListObserable.accept(true)
        }) { (err) in
            print(err)
            self.loadingObservable.accept(false)
            self.errorObservable.accept(err)
        }
    }
    
    func reMoveFromWatchList(movieID : Int) {
        loadingObservable.accept(true)
        UserModel.shared.removeFromWatchListMovie(movieID: movieID, success: {
            self.loadingObservable.accept(false)
            self.isAddedToWatchListObserable.accept(false)
        }) { (err) in
            print(err)
            self.loadingObservable.accept(false)
            self.errorObservable.accept(err)
        }
    }
}
