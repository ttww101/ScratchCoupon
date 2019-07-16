//
//  NotifcationItemTableViewCell.swift
//  UUBuy
//
//  Created by Jack on 2019/6/14.
//  Copyright © 2019 com.timi.test.test. All rights reserved.
//

import UIKit
import SnapKit

class NotifcationItemTableViewCell: UITableViewCell {
    let titleLabel = UILabel()
    let contentLabel = UILabel()
    let dateLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        titleLabel.text = ""
        titleLabel.font = UIFont.systemFont(ofSize: 16)
        titleLabel.textColor = .black
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(5)
            make.left.equalTo(self).offset(5)
            make.right.equalTo(self)
        }
        
        contentLabel.text = ""
        contentLabel.font = UIFont.systemFont(ofSize: 14)
        contentLabel.textColor = .gray
        addSubview(contentLabel)
        contentLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.left.equalTo(self).offset(5)
            make.right.equalTo(self)
            make.bottom.equalTo(self).offset(-5)
        }
        
        dateLabel.text = ""
        dateLabel.font = UIFont.systemFont(ofSize: 12)
        dateLabel.textColor = UIColor(hex: 0xEE4835)
        dateLabel.textAlignment = .right
        addSubview(dateLabel)
        dateLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(10)
            make.left.equalTo(self).offset(5)
            make.right.equalTo(self).offset(-5)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
