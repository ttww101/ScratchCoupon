//
//  SearchTextField.swift
//  UUBuy
//
//  Created by Jack on 2019/6/18.
//  Copyright © 2019 com.timi.test.test. All rights reserved.
//

import UIKit

class SearchTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layer.cornerRadius = 10
        clipsToBounds = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 35, dy: 0)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 35, dy: 0)
    }
}
