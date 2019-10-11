//
//  SearchViewModel.swift
//  MovieAsignWithRealm
//
//  Created by saw pyaehtun on 04/10/2019.
//  Copyright © 2019 saw pyaehtun. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class SearchViewModel: BaseViewModel {
    var searchResultmovieList = BehaviorRelay<[MovieVO]>(value: [])
    
    func searchMovie(movieName : String) {
        loadingObservable.accept(true)
        MovieModel.shared.searchMovie(movieName: movieName, success: { (movieResult) in
            self.loadingObservable.accept(false)
            self.searchResultmovieList.accept(movieResult)
        }) { (error) in
            self.loadingObservable.accept(false)
            print(error)
        }
    }
}

