//
//  ProfileViewModel.swift
//  MovieAsignWithRealm
//
//  Created by saw pyaehtun on 08/10/2019.
//  Copyright © 2019 saw pyaehtun. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class ProfileViewModel: BaseViewModel {
    
    var watchListMovies = BehaviorRelay<[MovieVO]>(value: [])
    var ratedMovieList = BehaviorRelay<[MovieVO]>(value: [])
    var userName = BehaviorRelay<String>(value: "")
    
    func getWatchListMovie() {
        loadingObservable.accept(true)
        if NetworkClient.checkReachable() == false {
            loadingObservable.accept(false)
            let movieList = UserModel.shared.getwatchListMovieFromRealm()
            watchListMovies.accept(movieList)
        } else {
            UserModel.shared.getWatchListMovies(success: { (movieList) in
                self.loadingObservable.accept(false)
                self.watchListMovies.accept(movieList)
            }) { (err) in
                self.loadingObservable.accept(false)
                self.errorObservable.accept(err)
                print(err)
            }
        }
        
    }
    
    func getRatedMovies() {
        loadingObservable.accept(true)
        if NetworkClient.checkReachable() == false {
            loadingObservable.accept(false)
            let movieList = UserModel.shared.getRatedListMovieFromRealm()
            ratedMovieList.accept(movieList)
        } else {
            UserModel.shared.getRatedMovie(success: { (movielist) in
                self.loadingObservable.accept(false)
                self.ratedMovieList.accept(movielist)
            }) { (err) in
                self.loadingObservable.accept(false)
                self.errorObservable.accept(err)
                print(err)
            }
        }
        
    }
}
