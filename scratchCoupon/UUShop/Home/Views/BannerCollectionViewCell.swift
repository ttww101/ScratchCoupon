//
//  BannerCollectionViewCell.swift
//  UUBuy
//
//  Created by Jack on 2019/6/17.
//  Copyright © 2019 com.timi.test.test. All rights reserved.
//

import UIKit

class BannerCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let imageView = UIImageView(named: "buy_banner")
        addSubview(imageView)
        imageView.frame = CGRect(x: 0, y: 0, width: width, height: width * 0.406)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
