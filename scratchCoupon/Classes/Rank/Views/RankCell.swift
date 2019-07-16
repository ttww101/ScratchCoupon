//
//  RankCell.swift
//  scratchCoupon
//
//  Created by Jack on 2019/7/4.
//  Copyright © 2019 com. All rights reserved.
//

import UIKit

class RankCell: UITableViewCell {
    @IBOutlet weak var rankNumLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var collectCoinNum: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
