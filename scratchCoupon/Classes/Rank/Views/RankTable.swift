//
//  RankTable.swift
//  scratchCoupon
//
//  Created by Jack on 2019/7/4.
//  Copyright © 2019 com. All rights reserved.
//

import UIKit

class RankTable: UITableView {
    var arr: [RankModel] = []
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        dataSource = self
        register(cellWithClass: RankCell.self)
        allowsSelection = false
        
        let observable = DefaultRewardHistoryDataSource.shared.getRank()
        _ = observable.subscribe(onNext: { (arr) in
            self.arr = arr
            self.reloadData()
        })
    }
}

extension RankTable: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section
        let row = indexPath.row
        let item = indexPath.item

//        let cell = tableView.dequeueReusableCell(withClass: RankCell.self)
        let model = arr[row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "rank") as! RankCell
        cell.rankNumLabel.text = String(model.rankNum)
        cell.userNameLabel.text = model.name
        cell.collectCoinNum.text = String(model.amount)
        
        return cell
    }
    
    
}
