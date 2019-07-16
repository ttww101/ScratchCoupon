//
//  CustomView.swift
//  JXMarqueeView
//
//  Created by jiaxin on 2018/5/2.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

import UIKit

class RankView: UIView{
    var poetry: [String]?
    let colors = [marqueeRedColor, marqueeRedColor, marqueeOrangeColor, marqueeBlueColor, marqueeRedColor, marqueeOrangeColor]
    let names = ["小明", "小王", "小華", "小櫻", "小明", "小王", "小華", "小櫻"]
    let amounts = [50, 40, 30, 20, 10, 1]

    init() {
        super.init(frame: CGRect.zero)

        backgroundColor = UIColor(hex: 0xB01616)
        
        for i in 0..<colors.count {
            let color = colors[i]
            let name = names[i]
            let amount = amounts[i]
            let rewardRow = RewardRowView()
            rewardRow.backgroundColor = color
            let width = UIScreen.main.bounds.width
            rewardRow.frame = CGRect(x: width*0.1, y: 35*CGFloat(i), width: width*0.8, height: 30)
            rewardRow.setText(first: "福", second: "中獎", third: "\(name)刮中刮中\(amount)元")
            addSubview(rewardRow)
//            rewardRow.snp.makeConstraints { (make) in
//                make.centerX.equalTo(self)
//                make.top.equalTo(self).offset(35*i+10)
//                make.left.equalTo(self).offset(10)
//                make.right.equalTo(self).offset(-10)
//                make.height.equalTo(30)
//            }
        }
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func sizeThatFits(_ size: CGSize) -> CGSize {
        return CGSize(width: width, height: CGFloat(35*colors.count))
    }

}
