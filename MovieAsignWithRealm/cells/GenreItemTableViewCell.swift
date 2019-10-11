//
//  GenreItemTableViewCell.swift
//  Movie
//
//  Created by saw pyaehtun on 27/09/2019.
//  Copyright © 2019 saw pyaehtun. All rights reserved.
//

import UIKit

class GenreItemTableViewCell: UITableViewCell {
    @IBOutlet weak var lblGenre: UILabel!
    var genreVO : GenreVO? {
        didSet{
            lblGenre.text = genreVO?.name
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
