//
//  PlayTrailerViewModel.swift
//  MovieAsignWithRealm
//
//  Created by saw pyaehtun on 05/10/2019.
//  Copyright © 2019 saw pyaehtun. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

final class PlayTrailerViewModel : BaseViewModel {
    
    let trillerVideos = BehaviorRelay<[VideoVO]?>(value: nil)
    
    func getTrillerVideos(movieId : Int) {
        loadingObservable.accept(true)
        VideoModel.shared.getTrailerVideos(movieId: movieId, success: { (trillerVideos) in
            self.loadingObservable.accept(false)
            self.trillerVideos.accept(trillerVideos)
        }) { (error) in
            self.loadingObservable.accept(false)
            print(error)
        }
    }
    
}
