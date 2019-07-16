//
//  NotificationSwitchTableViewCell.swift
//  UUBuy
//
//  Created by Jack on 2019/6/17.
//  Copyright © 2019 com.timi.test.test. All rights reserved.
//

import UIKit

class NotificationSwitchTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        layer.cornerRadius = 5
        clipsToBounds = true
        
        let view = UIView()
        
        let mySwitch = UISwitch()
        addSubview(mySwitch)
        mySwitch.snp.makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.right.equalTo(self).offset(-10)
        }
        
        let label = UILabel()
        label.text = "通知设定"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .black
        addSubview(label)
        label.snp.makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.left.equalTo(self).offset(20)
        }
        
        drawLine(startX: 10, toEndingX: 10, startingY: 14, toEndingY: 30, ofColor: UIColor(hex: 0xFFC101), widthOfLine: 5, inView: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func drawLine(startX: Int, toEndingX endX: Int, startingY startY: Int, toEndingY endY: Int, ofColor lineColor: UIColor, widthOfLine lineWidth: CGFloat, inView view: UIView) {
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: startX, y: startY))
        path.addLine(to: CGPoint(x: endX, y: endY))
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = lineColor.cgColor
        shapeLayer.lineWidth = lineWidth
        
        view.layer.addSublayer(shapeLayer)
        
    }
    
}

func drawLine(startX: Int, toEndingX endX: Int, startingY startY: Int, toEndingY endY: Int, ofColor lineColor: UIColor, widthOfLine lineWidth: CGFloat, inView view: UIView) {
    
    let path = UIBezierPath()
    path.move(to: CGPoint(x: startX, y: startY))
    path.addLine(to: CGPoint(x: endX, y: endY))
    
    let shapeLayer = CAShapeLayer()
    shapeLayer.path = path.cgPath
    shapeLayer.strokeColor = lineColor.cgColor
    shapeLayer.lineWidth = lineWidth
    
    view.layer.addSublayer(shapeLayer)
    
}
