//
//  MovieTableViewCell.swift
//  TotalAPIProject
//
//  Created by Jae Oh on 2023/08/17.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet var movieDateLabel: UILabel!
    @IBOutlet var movieGenreLabel: UILabel!
    @IBOutlet var movieImageView: UIImageView!
    @IBOutlet var movieTitleLabel: UILabel!
    @IBOutlet var movieCastLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
     
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

     
    }

}
