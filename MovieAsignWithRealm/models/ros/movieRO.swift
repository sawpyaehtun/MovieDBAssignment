//
//  movieRO.swift
//  MovieRealm
//
//  Created by saw pyaehtun on 29/09/2019.
//  Copyright © 2019 saw pyaehtun. All rights reserved.
//

import Foundation
import RealmSwift

enum Category : Int{
    case nowPlaying = 1
    case popular = 2
    case topRated = 3
    case upComing = 4
}

@objcMembers final class MovieRO : Object{
    dynamic var popularity : Double?
    dynamic var voteCount : Int?
    let video = RealmOptional<Bool>()
    dynamic var posterPath : String?
    dynamic var id : Int = 0
    let adult = RealmOptional<Bool>()
    dynamic var backdropPath : String?
    dynamic var originalLanguage : String?
    dynamic var originalTitle : String?
    var generROs = List<GenreRO>()
    dynamic var title : String?
    dynamic var voteAverage : Double?
    dynamic var overview : String?
    dynamic var releaseDate : String?
    dynamic var budget : Int?
    dynamic var homepage : String?
    dynamic var imdbId : String?
    dynamic var revenue : Int?
    dynamic var runtime : Int?
    dynamic var tagline : String?
    var categories = List<CategoryRO>()
    let isRated = RealmOptional<Bool>()
    let isAddedWatchList = RealmOptional<Bool>()
    
    convenience init(popularity : Double?,
                     voteCount : Int?,
                     video : Bool?,
                     posterPath : String?,
                     id : Int?,
                     adult : Bool?,
                     backdropPath : String?,
                     originalLanguage : String?,
                     originalTitle : String?,
                     genreROs : List<GenreRO>,
                     title : String?,
                     voteAverage : Double?,
                     overview : String?,
                     releaseDate : String?,
                     budget : Int?,
                     homepage : String?,
                     imdbId : String?,
                     revenue : Int?,
                     runtime : Int?,
                     tagline : String?,
                     categories : List<CategoryRO>,
                     isRated : Bool?,
                     isAddedWatchList : Bool?){
        self.init()
        self.popularity = popularity
        self.voteCount = voteCount
        self.video.value = video
        self.posterPath = posterPath
        self.id = id ?? 0
        self.adult.value = adult
        self.backdropPath = backdropPath
        self.originalLanguage = originalLanguage
        self.originalTitle = originalTitle
        self.generROs = genreROs
        self.title =  title
        self.voteAverage = voteAverage
        self.overview = overview
        self.releaseDate = releaseDate
        self.budget = budget
        self.homepage = homepage
        self.imdbId = imdbId
        self.revenue = revenue
        self.runtime = runtime
        self.tagline = tagline
        self.categories = categories
        self.isAddedWatchList.value = isAddedWatchList
        self.isRated.value = isRated
    }
    
    override class func primaryKey() -> String? {
        return "id"
    }
}

