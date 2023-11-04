//
//  CastTableViewCell.swift
//  TotalAPIProject
//
//  Created by Jae Oh on 2023/08/17.
//

import UIKit

class CastTableViewCell: UITableViewCell {

    @IBOutlet var actorImageView: UIImageView!
    @IBOutlet var actorNameLabel: UILabel!
    @IBOutlet var characterNameLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
