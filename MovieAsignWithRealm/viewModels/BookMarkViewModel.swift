//
//  BookMarkViewModel.swift
//  Movie
//
//  Created by saw pyaehtun on 28/09/2019.
//  Copyright © 2019 saw pyaehtun. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class BookMarkViewModel : BaseViewModel {
    
    var moviesInBookmark = BehaviorRelay<[MovieVO]>(value: [])
    
//    func getmoviesInBookmark() {
//        BookmarkModel.shared.getMoviesInBookMark { (movieVOs) in
//            self.moviesInBookmark.accept(movieVOs)
//        }
//    }
//    
}
