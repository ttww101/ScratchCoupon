//
//  RewardRowView.swift
//  scratchCoupon
//
//  Created by Jack on 2019/7/15.
//  Copyright © 2019 com. All rights reserved.
//

import UIKit

class RewardRowView: UIView {
    let firstLabel = UILabel()
    let secondLabel = UILabel()
    let thirdLabel = UILabel()
    
    func setText(first: String, second: String, third: String) {
        firstLabel.text = first
        secondLabel.text = second
        thirdLabel.text = third
        
        firstLabel.sizeToFit()
        secondLabel.sizeToFit()
        thirdLabel.sizeToFit()
        
        firstLabel.center.y = 15
        firstLabel.frame.origin.x = 10
        
        secondLabel.center.y = 15
        secondLabel.frame.origin.x = firstLabel.frame.origin.x + firstLabel.width + 10
        
        thirdLabel.center.y = 15
        thirdLabel.frame.origin.x = secondLabel.frame.origin.x + secondLabel.width + 30
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.cornerRadius = 15
        clipsToBounds = true
        addSubview(firstLabel)
        addSubview(secondLabel)
        addSubview(thirdLabel)
        
        firstLabel.textColor = .white
        firstLabel.font = UIFont.systemFont(ofSize: 20)
        
        secondLabel.textColor = UIColor(hex: 0xFFEA00)
        secondLabel.font = UIFont.systemFont(ofSize: 20)
        
        thirdLabel.textColor = UIColor(hex: 0xFFEA00)
        thirdLabel.font = UIFont.systemFont(ofSize: 16)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.cornerRadius = 15
        clipsToBounds = true
        addSubview(firstLabel)
        addSubview(secondLabel)
        addSubview(thirdLabel)
        
        firstLabel.textColor = .white
        firstLabel.font = UIFont.systemFont(ofSize: 16)
        
        firstLabel.textColor = UIColor(hex: 0xFFEA00)
        firstLabel.font = UIFont.systemFont(ofSize: 16)
        
        firstLabel.textColor = UIColor(hex: 0xFFEA00)
        firstLabel.font = UIFont.systemFont(ofSize: 12)
        
        firstLabel.center.y = centerY
        firstLabel.frame.origin.x = 10
        
        secondLabel.center.y = centerY
        secondLabel.frame.origin.x = firstLabel.frame.origin.x + 10
        
        thirdLabel.center.y = centerY
        thirdLabel.frame.origin.x = secondLabel.frame.origin.x + 30
        
        //        firstLabel.snp.makeConstraints { (make) in
        //            make.centerY.equalTo(self)
        //            make.left.equalTo(self).offset(10)
        //        }
        //
        //        secondLabel.snp.makeConstraints { (make) in
        //            make.centerY.equalTo(self)
        //            make.left.equalTo(firstLabel.snp.right).offset(10)
        //        }
        //
        //        thirdLabel.snp.makeConstraints { (make) in
        //            make.centerY.equalTo(self)
        //            make.left.equalTo(secondLabel.snp.right).offset(30)
        //        }
    }
}
