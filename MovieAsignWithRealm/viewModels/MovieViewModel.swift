//
//  MovieViewModel.swift
//  Movie
//
//  Created by saw pyaehtun on 27/09/2019.
//  Copyright © 2019 saw pyaehtun. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

final class MovieViewModel : BaseViewModel {
    
    var allMovieList = BehaviorRelay<[MovieVO]>(value: [])
    
    func fetchAllMovie() {
        loadingObservable.accept(true)
        MovieModel.shared.fetchAllmovie(success: { moivieVOs in
            print(moivieVOs.count)
            self.loadingObservable.accept(false)
            self.allMovieList.accept(moivieVOs)
        }) { (err) in
            self.loadingObservable.accept(false)
            print(err)
            self.errorObservable.accept(err)
        }
    }
    
    func getMovie() {
        allMovieList.accept(MovieModel.shared.getMovie())
    }
    
}
