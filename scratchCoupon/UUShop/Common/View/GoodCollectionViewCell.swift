//
//  GoodCollectionViewCell.swift
//  UUBuy
//
//  Created by Jack on 2019/6/12.
//  Copyright © 2019 com.timi.test.test. All rights reserved.
//

import UIKit
import SnapKit

class GoodCollectionViewCell: UICollectionViewCell {
    let imageView = UIImageView()
    let label = UILabel()
    let collectBtn = UIButton()
    let buyBtn = UIButton()
    let priceLabel = UILabel()
    
    func set(model: GoodModel) {
        label.text = model.name
        priceLabel.text = model.price
        imageView.imageURL = URL(string: model.bigImgs[0])
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.width.equalTo(self)
            make.height.equalTo(self.snp.width)
        }
        addSubview(label)
        label.font = UIFont.systemFont(ofSize: 12)
        label.snp.makeConstraints { (make) in
            make.width.equalTo(self)
            make.centerX.equalTo(self)
            make.top.equalTo(imageView.snp.bottom).offset(2)
        }
        label.text = "Loading"
        
        let iconSize: CGFloat = 12
        
        addSubview(collectBtn)
        collectBtn.setImage(UIImage(named: "buy_slove"), for: .normal)
        collectBtn.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: iconSize, height: iconSize))
            make.top.equalTo(label.snp.bottom).offset(2)
            make.left.equalTo(self)
        }
        
        addSubview(buyBtn)
        buyBtn.setImage(UIImage(named: "buy_scar"), for: .normal)
        buyBtn.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: iconSize, height: iconSize))
            make.centerY.equalTo(collectBtn)
            make.right.equalTo(self)
        }
        buyBtn.rx.tap.subscribe(onNext: {
            
        })
        
        addSubview(priceLabel)
        priceLabel.textColor = redColor
        priceLabel.textAlignment = .center
        priceLabel.font = UIFont.systemFont(ofSize: 12)
        priceLabel.snp.makeConstraints { (make) in
            make.width.equalTo(self)
            make.centerX.equalTo(self)
            make.centerY.equalTo(collectBtn)
        }
        priceLabel.text = "Loading"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

let redColor = UIColor(hex: 0xFF6358)
