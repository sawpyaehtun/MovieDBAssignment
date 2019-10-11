//
//  MovieVO+Extension.swift
//  Movie
//
//  Created by saw pyaehtun on 28/09/2019.
//  Copyright © 2019 saw pyaehtun. All rights reserved.
//

import Foundation
import RealmSwift

extension MovieVO{
    func toMovieRO() -> MovieRO{
    
        let generidList = List<GenreRO>()
        self.genreIds?.forEach({ (genreId) in
            generidList.append(GenreModel.shared.getGenreROByID(genreId: genreId)!)
        })
        
        let categoryList = List<CategoryRO>()
        self.categories?.forEach({ (categoryID) in
            categoryList.append(CategoryModel.shared.getCategoryROByID(categoryID: categoryID))
        })
        
        let movieRO = MovieRO(popularity: self.popularity,
                              voteCount: self.voteCount,
                              video: self.video,
                              posterPath: self.posterPath,
                              id: self.id, adult: self.adult,
                              backdropPath: self.backdropPath,
                              originalLanguage: self.originalLanguage,
                              originalTitle: self.originalTitle,
                              genreROs: generidList,
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
                              categories: categoryList)
        return movieRO
    }
}
