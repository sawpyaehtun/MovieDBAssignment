//
//  ArrayExtension.swift
//  contact-core-date
//
//  Created by saw pyaehtun on 22/09/2019.
//  Copyright © 2019 padc. All rights reserved.
//

import Foundation

extension Array {

    func toGenreROs() -> [GenreRO]{
        guard let genreVOs = self as? [GenreVO] else { return []}
        let genreROs = genreVOs.map { (genreVO) -> GenreRO in
            return GenreRO(id: genreVO.id, name: genreVO.name)
        }
        return genreROs
    }
    
    func toGenreVOs() -> [GenreVO]{
        guard let genreROs = self as? [GenreRO] else { return []}
        let genreVOs = genreROs.map { (genreRO) -> GenreVO in
            return GenreVO(id: genreRO.id, name: genreRO.name)
        }
        return genreVOs
    }
    
    func toMovieVOs() -> [MovieVO]{
        guard let movieROs = self as? [MovieRO] else { return []}
        let movieVOs = movieROs.map { (movieRO) -> MovieVO in
            return movieRO.toMovieVO()
        }
        return movieVOs
    }
    
    func toMovieROs() -> [MovieRO] {
        guard  let movieVOs = self as? [MovieVO] else { return []}
        let movieROs = movieVOs.map { (movieVO) -> MovieRO in
            return movieVO.toMovieRO()
        }
        return movieROs
    }
    
}
