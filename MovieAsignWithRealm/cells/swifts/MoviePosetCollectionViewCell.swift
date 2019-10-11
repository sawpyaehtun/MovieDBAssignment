//
//  MoviePosetCollectionViewCell.swift
//  Movie
//
//  Created by saw pyaehtun on 26/09/2019.
//  Copyright © 2019 saw pyaehtun. All rights reserved.
//

import UIKit
import SDWebImage

class MoviePosetCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageViewMoviePoster: UIImageView!
    
    var movieVO : MovieVO? {
        didSet {
            if let movieVO = movieVO {
                imageViewMoviePoster.sd_setImage(with: URL(string: "\(NetworkConfiguration.BASE_IMG_URL)\(movieVO.posterPath ?? "")"), completed: nil)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
