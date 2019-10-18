//
//  GenreViewModel.swift
//  Movie
//
//  Created by saw pyaehtun on 27/09/2019.
//  Copyright © 2019 saw pyaehtun. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

final class GenreViewModel : BaseViewModel {
    
    // output
    var genreList = BehaviorRelay<[GenreVO]>(value: [])
    
    // Interaction
    let tapRefetchData : AnyObserver<Void>
    let didTapRefetchData : Observable<Void>
    
    override init() {
        let _tapRefetchData = PublishSubject<Void>()
        self.tapRefetchData = _tapRefetchData.asObserver()
        self.didTapRefetchData = _tapRefetchData.asObservable()
        
        super.init()
        self.fetchGenre()
        didTapRefetchData.subscribe(onNext: { (_) in
            self.fetchGenre()
        }).disposed(by: disposableBag)
    }
}

extension GenreViewModel{
    
    func fetchGenre() {
        loadingObservable.accept(true)
        if NetworkClient.checkReachable() == false {
            loadingObservable.accept(false)
            getGenre()
        } else {
            GenreModel.shared.fetchGeners(success: { (genreVOs) in
                self.loadingObservable.accept(false)
                self.genreList.accept(genreVOs)
            }) { (err) in
                self.loadingObservable.accept(false)
                print(err)
            }
        }
    }
    
    func getGenre() {
        GenreModel.shared.getGenreList { (genreVOs) in
            self.genreList.accept(genreVOs)
        }
    }
    
}
