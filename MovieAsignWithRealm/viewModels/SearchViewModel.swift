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
    
    // input
    let movieName = BehaviorRelay<String>(value: "")
    
    // output
    let searchResultmovieList = BehaviorRelay<[MovieVO]>(value: [])
    
    // user interaction
    let tapSearch : AnyObserver<Void>
    let didTapSearch : Observable<Void>
    
    override init() {
        let _tapSearch = PublishSubject<Void>()
        self.tapSearch = _tapSearch.asObserver()
        self.didTapSearch = _tapSearch.asObservable()
        super.init()
        
        didTapSearch.subscribe(onNext: { (_) in
            self.searchMovie(movieName: self.movieName.value)
            }).disposed(by: disposableBag)
    }
}

extension SearchViewModel{
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

