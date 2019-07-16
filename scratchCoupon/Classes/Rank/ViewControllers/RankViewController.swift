//
//  RankViewController.swift
//  scratchCoupon
//
//  Created by Jack on 2019/7/5.
//  Copyright © 2019 com. All rights reserved.
//

import UIKit

class RankViewController: ViewController {
    
    @IBOutlet weak var firstUserName: UILabel!
    @IBOutlet weak var firstUserAmount: UILabel!
    @IBOutlet weak var secondUserName: UILabel!
    @IBOutlet weak var secondUserAmount: UILabel!
    @IBOutlet weak var thirdUserName: UILabel!
    @IBOutlet weak var thirdUserAmount: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        _ = DefaultRewardHistoryDataSource.shared.getRank().subscribe(onNext: { (arr) in
            self.firstUserName.text = arr[0].name
            self.firstUserAmount.text = String(arr[0].amount)
            
            self.secondUserName.text = arr[1].name
            self.secondUserAmount.text = String(arr[1].amount)
            
            self.thirdUserName.text = arr[2].name
            self.thirdUserAmount.text = String(arr[2].amount)
        })
    }

}
