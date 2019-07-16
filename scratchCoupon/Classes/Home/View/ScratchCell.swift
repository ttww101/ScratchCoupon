//
//  ScratchCell.swift
//  scratchCoupon
//
//  Created by Jack on 2019/7/2.
//  Copyright © 2019 com. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class ScratchCell: UITableViewCell {

    @IBOutlet weak var cardBtn1: UIButton!
    @IBOutlet weak var cardBtn2: UIButton!
    @IBOutlet weak var cardBtn3: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cardBtn1.imageView?.contentMode = .scaleAspectFit
        cardBtn2.imageView?.contentMode = .scaleAspectFit
        cardBtn3.imageView?.contentMode = .scaleAspectFit
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
