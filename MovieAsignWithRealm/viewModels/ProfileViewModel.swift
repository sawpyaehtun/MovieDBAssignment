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
        UserModel.shared.getWatchListMovies(success: { (movieList) in
            self.loadingObservable.accept(false)
            self.watchListMovies.accept(movieList)
        }) { (err) in
            self.loadingObservable.accept(false)
            print(err)
        }
    }
}
