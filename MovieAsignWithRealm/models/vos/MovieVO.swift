//
//  MovieVO.swift
//  Movie
//
//  Created by saw pyaehtun on 27/09/2019.
//  Copyright © 2019 saw pyaehtun. All rights reserved.
//

import Foundation

struct MovieVO : Codable{
    let popularity : Double?
    let voteCount : Int?
    let video : Bool?
    let posterPath : String?
    let id : Int?
    let adult : Bool?
    let backdropPath : String?
    let originalLanguage : String?
    let originalTitle : String?
    var genreIds: [Int]?
    let title : String?
    let voteAverage : Double?
    let overview : String?
    let releaseDate : String?
    let budget : Int?
    let homepage : String?
    let imdbId : String?
    let revenue : Int?
    let runtime : Int?
    let tagline : String?
    let genreVOs :[GenreVO]?
    var categories : [Int]?
    var isRated : Bool?
    var isAddedWatchList : Bool?
}
