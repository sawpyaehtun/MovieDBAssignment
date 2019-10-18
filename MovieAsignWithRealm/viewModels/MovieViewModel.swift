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
    
    // output
    let allMovieList = BehaviorRelay<[[MovieVO]]>(value: [[]])
    
    // user interaction
    let tapRefetchData : AnyObserver<Void>
    let didTapRefetchData : Observable<Void>
       
    override init() {
        let _tapRefetchData = PublishSubject<Void>()
        self.tapRefetchData = _tapRefetchData.asObserver()
        self.didTapRefetchData = _tapRefetchData.asObservable()
        
        super.init()
        self.fetchAllMovie()
        didTapRefetchData.subscribe(onNext: { (_) in
            self.fetchAllMovie()
        }).disposed(by: disposableBag)
    }
}

extension MovieViewModel{
    
    func fetchAllMovie() {
        loadingObservable.accept(true)
        
        if NetworkClient.checkReachable() == false {
            loadingObservable.accept(false)
            prepareMovieListForVariousCategory(movieList: MovieModel.shared.getMovie())
        } else {
            MovieModel.shared.fetchAllmovie(success: { moivieVOs in
                print(moivieVOs.count)
                self.loadingObservable.accept(false)
                self.prepareMovieListForVariousCategory(movieList: moivieVOs)
            }) { (err) in
                self.loadingObservable.accept(false)
                print(err)
                self.errorObservable.accept(err)
            }
        }
    }
    
    private func prepareMovieListForVariousCategory(movieList : [MovieVO]) {
        var movieListsWithcategories : [[MovieVO]] = []
        
        for i in 0...3 {
            movieListsWithcategories.append(movieList.filter({ (movieVO) -> Bool in
                return (movieVO.categories?.contains(i))!
            }))
        }
        print(movieListsWithcategories.count)
        allMovieList.accept(movieListsWithcategories)
    }
    
}
