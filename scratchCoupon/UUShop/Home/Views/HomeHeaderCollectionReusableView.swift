//
//  HomeHeaderCollectionReusableView.swift
//  UUBuy
//
//  Created by Jack on 2019/6/17.
//  Copyright © 2019 com.timi.test.test. All rights reserved.
//

import UIKit

class HomeHeaderCollectionReusableView: UICollectionReusableView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        //        backgroundColor = .yellow
        
        let decorationView = UIView()
        decorationView.layer.cornerRadius = 12
        decorationView.clipsToBounds = true
        decorationView.backgroundColor = .white
        addSubview(decorationView)
        decorationView.snp.makeConstraints { (make) in
            make.center.equalTo(self)
            make.width.equalTo(200)
            make.height.equalTo(24)
        }
        
        label.text = "明星单品"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor(hex: 0xFF574A)
        addSubview(label)
        label.snp.makeConstraints { (make) in
            make.center.equalTo(self)
        }
    }
    
    let label = UILabel()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        let orangeColor = UIColor(hex: 0xFFB046)
        let centerX = center.x
        
        let down: Int = 10
        drawLine(startX: Int(centerX-40), toEndingX: Int(centerX-40-8), startingY: 10+down, toEndingY: 20+down, ofColor: orangeColor!, widthOfLine: 2, inView: self)
        drawLine(startX: Int(centerX-50), toEndingX: Int(centerX-50-8), startingY: 10+down, toEndingY: 20+down, ofColor: orangeColor!, widthOfLine: 2, inView: self)
        drawLine(startX: Int(centerX+60), toEndingX: Int(centerX+60-8), startingY: 10+down, toEndingY: 20+down, ofColor: orangeColor!, widthOfLine: 2, inView: self)
        drawLine(startX: Int(centerX+50), toEndingX: Int(centerX+50-8), startingY: 10+down, toEndingY: 20+down, ofColor: orangeColor!, widthOfLine: 2, inView: self)
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
