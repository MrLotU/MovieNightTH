//
//  GenreTableViewCell.swift
//  MovieNight
//
//  Created by Jari Koopman on 23/05/2017.
//  Copyright © 2017 JarICT. All rights reserved.
//

import UIKit

class GenreTableViewCell: UITableViewCell {

    @IBOutlet weak var checker: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    var genreIsSelected: Bool = false
    var genre: Genre!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
