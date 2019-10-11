//
//  MovieRO+Extension.swift
//  MovieRealm
//
//  Created by saw pyaehtun on 30/09/2019.
//  Copyright © 2019 saw pyaehtun. All rights reserved.
//

import Foundation

extension MovieRO {
    func toMovieVO() -> MovieVO {
        
        let genreVOs = Array(self.generROs).toGenreVOs()
        let genreIds = genreVOs.map { (genreVO) -> Int in
            return genreVO.id ?? 0
        }
    
        let categoryROs = Array(self.categories)
        let categories = categoryROs.map { (categoryRO) -> Int in
            return categoryRO.id
        }
        
        return MovieVO(popularity: self.popularity,
                       voteCount: self.voteCount,
                       video: self.video.value,
                       posterPath: self.posterPath,
                       id: self.id,
                       adult: self.adult.value,
                       backdropPath: self.backdropPath,
                       originalLanguage: self.originalLanguage,
                       originalTitle: self.originalTitle,
                       genreIds: genreIds,
                       title: self.title,
                       voteAverage: self.voteAverage,
                       overview: self.overview,
                       releaseDate: self.releaseDate,
                       budget: self.budget,
                       homepage: self.homepage,
                       imdbId: self.imdbId,
                       revenue: self.revenue,
                       runtime: self.runtime,
                       tagline: self.tagline,
                       genreVOs: genreVOs,
                       categories: categories)
    }
}
