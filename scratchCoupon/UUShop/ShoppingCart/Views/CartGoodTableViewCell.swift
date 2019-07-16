//
//  CartGoodTableViewCell.swift
//  UUBuy
//
//  Created by Jack on 2019/7/1.
//  Copyright © 2019 com.timi.test.test. All rights reserved.
//

import UIKit
import SnappingStepper

class CartGoodTableViewCell: UITableViewCell {
    let goodImgView = UIImageView()
    let goodNameLabel = UILabel()
    let priceLabel = UILabel()
    let deleteBtn = UIButton()
    let stepper = SnappingStepper()
    var row = -1
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        goodImgView.layer.cornerRadius = 5
        goodImgView.clipsToBounds = true
        addSubview(goodImgView)
        goodImgView.snp.makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.width.height.equalTo(80)
            make.left.equalTo(self).offset(20)
            make.top.equalTo(self).offset(5)
            make.bottom.equalTo(self).offset(-5)
        }
        goodImgView.backgroundColor = .red
        
        goodNameLabel.text = "fsdkaljkd"
        goodNameLabel.font = UIFont.systemFont(ofSize: 14)
        goodNameLabel.textColor = .black
        addSubview(goodNameLabel)
        goodNameLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(self).offset(-20)
            make.left.equalTo(goodImgView.snp.right).offset(10)
        }
        //        goodNameLabel.backgroundColor = .green
        
        priceLabel.text = "dsjal"
        priceLabel.font = UIFont.systemFont(ofSize: 14)
        priceLabel.textColor = UIColor(hex: 0xD96800)
        addSubview(priceLabel)
        priceLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(self).offset(20)
            make.left.equalTo(goodNameLabel)
        }
        
        deleteBtn.setImage(UIImage(named: "buy_trash"), for: .normal)
        addSubview(deleteBtn)
        deleteBtn.snp.makeConstraints { (make) in
            make.right.equalTo(self).offset(-10)
            make.top.equalTo(self).offset(10)
            make.size.equalTo(CGSize(width: 20, height: 20))
        }
        
        stepper.symbolFont           = UIFont(name: "TrebuchetMS-Bold", size: 30)
        stepper.symbolFontColor      = .white
        stepper.backgroundColor      = UIColor(hex: 0xFF8300)
        stepper.thumbWidthRatio      = 0.5
        stepper.thumbText            = nil
        stepper.thumbFont            = UIFont(name: "TrebuchetMS-Bold", size: 30)
        stepper.thumbBackgroundColor = .white
        stepper.thumbTextColor       = .black
        //        stepper.thumbBorderColor = .red
        
        stepper.minimumValue = 1
        stepper.maximumValue = 9
        stepper.stepValue    = 1
        
        addSubview(stepper)
        stepper.snp.makeConstraints { (make) in
            make.bottom.equalTo(self).offset(-10)
            make.right.equalTo(self).offset(-10)
            make.size.equalTo(CGSize(width: 90, height: 20))
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
