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
    
    var genreList = BehaviorRelay<[GenreVO]>(value: [])
    
    func fetchGenre() {
        loadingObservable.accept(true)
        GenreModel.shared.fetchGeners(success: { (genreVOs) in
            self.loadingObservable.accept(false)
            self.genreList.accept(genreVOs)
        }) { (err) in
            self.loadingObservable.accept(false)
            print(err)
        }
    }
    
    func getMovie(success : @escaping () -> Void) {
       
    }
    
}
