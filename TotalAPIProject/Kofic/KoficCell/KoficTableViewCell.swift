//
//  KoficTableViewCell.swift
//  TotalAPIProject
//
//  Created by Jae Oh on 2023/08/19.
//

import UIKit

class KoficTableViewCell: UITableViewCell {

    @IBOutlet var weeklyBoxOfficeRankLabel: UILabel!
    
    @IBOutlet var weeklyBoxOfficeTitleLabel: UILabel!
    
    @IBOutlet var weeklyBoxOfficedateLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()

        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
