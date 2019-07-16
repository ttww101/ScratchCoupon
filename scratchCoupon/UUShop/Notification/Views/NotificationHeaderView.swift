//
//  NotificationHeaderView.swift
//  UUBuy
//
//  Created by Jack on 2019/6/17.
//  Copyright © 2019 com.timi.test.test. All rights reserved.
//

import UIKit

class NotificationHeaderView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        let imageView = UIImageView(named: "buy_bbag")
        imageView.contentMode = .scaleAspectFit
        addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(10)
            make.left.right.bottom.equalTo(self)
        }
        
        let btn = UIButton()
        addSubview(btn)
        btn.snp.makeConstraints { (make) in
            make.right.top.bottom.equalTo(self)
            make.width.equalTo(imageView.snp.height)
        }
        btn.rx.tap.subscribe(onNext: {
            let vc = self.viewController
            vc?.navigationController?.pushViewController(ReceiveRedEnvelopesViewController())
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
