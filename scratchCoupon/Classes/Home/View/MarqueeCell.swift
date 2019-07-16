//
//  MarqueeCell.swift
//  scratchCoupon
//
//  Created by Jack on 2019/7/5.
//  Copyright © 2019 com. All rights reserved.
//

import UIKit
import SnapKit

class MarqueeCell: UITableViewCell {

    private let marqueeView = JXMarqueeView()
    
    func setCellBackgroundColor(color: UIColor) {
        backgroundColor = color
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        let view = RankView()
        marqueeView.contentView = view
        marqueeView.marqueeType = .up
        marqueeView.pointsPerFrame = 1
        marqueeView.backgroundColor = UIColor(hex: 0xB01616)
        marqueeView.contentMargin = 0
        addSubview(marqueeView)
//        marqueeView.bounds = CGRect(x:0, y:0, width: bounds.width, height: 500)
//        marqueeView.center = center
        marqueeView.snp.makeConstraints { (make) in
            make.center.equalTo(self)
            make.top.bottom.equalTo(self)
            make.height.equalTo(200)
            make.width.equalTo(self)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
