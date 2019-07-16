//
//  MeCell.swift
//  scratchCoupon
//
//  Created by Jack on 2019/7/16.
//  Copyright © 2019 com. All rights reserved.
//

import UIKit

class MeCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var signIntroductionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
