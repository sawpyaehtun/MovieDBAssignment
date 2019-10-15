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
    var isRatedMovieObserable = BehaviorRelay<Bool>(value: false)
    let internetConnectionError = "Please Check Your Internet Connection!"
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
    
    func getMovieAndCheckInWatchList(movieID : Int) {
        loadingObservable.accept(true)
        if NetworkClient.checkReachable() == false {
            loadingObservable.accept(false)
            let movieList = getMovieWatchListFromRealm()
            checkMovieInWatchList(movieID: movieID, movieWatchList: movieList)
        } else {
            UserModel.shared.getWatchListMovies(success: { (movieList) in
                self.loadingObservable.accept(false)
                self.checkMovieInWatchList(movieID: movieID, movieWatchList: movieList)
            }) { (err) in
                print(err)
                self.loadingObservable.accept(false)
                self.errorObservable.accept(err)
            }
        }
    }
    
    private func getMovieWatchListFromRealm() -> [MovieVO]{
       return UserModel.shared.getwatchListMovieFromRealm()
    }
    
    private func getRatedMovieListFromRealm() -> [MovieVO]{
        return UserModel.shared.getRatedListMovieFromRealm()
    }
    
    private func checkMovieInWatchList(movieID : Int,movieWatchList : [MovieVO]){
        if !movieWatchList.isEmpty {
            let idArray = movieWatchList.map { (movie) -> Int in
                return movie.id ?? 0
            }
            if idArray.contains(movieID) {
                self.isAddedToWatchListObserable.accept(true)
            } else {
                self.isAddedToWatchListObserable.accept(false)
            }
        }
    }
    
    func getMovieAndCheckInRatedList(movieID : Int) {
        loadingObservable.accept(true)
        
        if NetworkClient.checkReachable() == false {
            loadingObservable.accept(false)
            let movieList = getRatedMovieListFromRealm()
            checkMovieInRatedList(movieID: movieID, ratedMovieList: movieList)
        } else {
            UserModel.shared.getRatedMovie(success: { (movielist) in
                self.loadingObservable.accept(false)
                self.checkMovieInRatedList(movieID: movieID, ratedMovieList: movielist)
            }) { (err) in
                print(err)
                self.loadingObservable.accept(false)
                self.errorObservable.accept(err)
            }
        }
        
    }
    
    private func checkMovieInRatedList(movieID : Int, ratedMovieList : [MovieVO]){
        if !ratedMovieList.isEmpty {
            let idArray = ratedMovieList.map { (movie) -> Int in
                return movie.id ?? 0
            }
            
            if idArray.contains(movieID){
                self.isRatedMovieObserable.accept(true)
            } else {
                self.isRatedMovieObserable.accept(false)
            }
        }
    }
    
    func getMovieDetail(movieId : Int) {
        loadingObservable.accept(true)
        if NetworkClient.checkReachable() == false {
            loadingObservable.accept(false)
            self.movieDetailObserable.accept(MovieModel.shared.getMovieVOById(movieID: movieId))
        } else {
            MovieModel.shared.getMovieDetail(movieId: movieId, success: { (movie) in
                self.loadingObservable.accept(false)
                self.movieDetailObserable.accept(movie)
            }) { (error) in
                self.loadingObservable.accept(false)
                print(error)
            }
        }
       
    }
    
    func addToWatchList(movieID : Int) {
        loadingObservable.accept(true)
        if NetworkClient.checkReachable() == false {
            loadingObservable.accept(false)
            errorObservable.accept(internetConnectionError)
        } else {
            UserModel.shared.addToWatchListMovie(movieID: movieID, success: {
                self.loadingObservable.accept(false)
                self.isAddedToWatchListObserable.accept(true)
            }) { (err) in
                print(err)
                self.loadingObservable.accept(false)
                self.errorObservable.accept(err)
            }
        }
       
    }
    
    func removeFromWatchList(movieID : Int) {
        loadingObservable.accept(true)
        if NetworkClient.checkReachable() == false {
            loadingObservable.accept(false)
            errorObservable.accept(internetConnectionError)
        } else {
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
    
    func addToRatedList(movieID : Int,value : Double) {
        loadingObservable.accept(true)
        if NetworkClient.checkReachable() == false {
            loadingObservable.accept(false)
            errorObservable.accept(internetConnectionError)
        } else {
            UserModel.shared.addMovieToRatedList(movieID: movieID, value: value, success: {
                self.loadingObservable.accept(false)
                self.isRatedMovieObserable.accept(true)
            }) { (err) in
                self.loadingObservable.accept(false)
                self.errorObservable.accept(err)
            }
        }
        
    }
    
    func removeFromRatedList(movieID : Int) {
        loadingObservable.accept(true)
        if NetworkClient.checkReachable() == false {
            loadingObservable.accept(false)
            errorObservable.accept(internetConnectionError)
        } else {
            UserModel.shared.removeMovieFromRatedList(movieID: movieID, success: {
                self.loadingObservable.accept(false)
                self.isRatedMovieObserable.accept(false)
            }) { (err) in
                print(err)
                self.loadingObservable.accept(false)
                self.errorObservable.accept(err)
            }
        }
    }
}
