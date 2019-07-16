//
//  DecorationView.swift
//  UUBuy
//
//  Created by Jack on 2019/6/13.
//  Copyright © 2019 com.timi.test.test. All rights reserved.
//

import UIKit

class DecorationView: UICollectionReusableView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        layer.cornerRadius = 10
        clipsToBounds = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
