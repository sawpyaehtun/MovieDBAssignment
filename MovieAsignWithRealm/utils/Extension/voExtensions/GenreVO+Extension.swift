//
//  GenreRO+Extension.swift
//  MovieRealm
//
//  Created by saw pyaehtun on 29/09/2019.
//  Copyright © 2019 saw pyaehtun. All rights reserved.
//

import Foundation

extension GenreVO {
    func toGenreRO() -> GenreRO {
        return GenreRO(id: self.id, name: self.name)
    }
}
