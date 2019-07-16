//
//  OneDollarGoodCollectionViewCell.swift
//  UUBuy
//
//  Created by Jack on 2019/6/18.
//  Copyright © 2019 com.timi.test.test. All rights reserved.
//

import UIKit

class OneDollarGoodCollectionViewCell: UICollectionViewCell {
    let imageView = UIImageView()
    let label = UILabel()
    let collectBtn = UIButton()
    let buyBtn = UIButton()
    let priceLabel = UILabel()
    let timerLabel = TimerLabel()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let rate = frame.size.width / 75
        
        addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.width.equalTo(self)
            make.height.equalTo(self.snp.width)
        }
        addSubview(label)
        label.font = UIFont.systemFont(ofSize: 10*rate)
        label.snp.makeConstraints { (make) in
            make.width.equalTo(self)
            make.centerX.equalTo(self)
            make.top.equalTo(imageView.snp.bottom).offset(2)
        }
        label.text = "Loading"
        
        addSubview(priceLabel)
        priceLabel.textColor = redColor
        priceLabel.textAlignment = .left
        priceLabel.font = UIFont.systemFont(ofSize: 10*rate)
        priceLabel.snp.makeConstraints { (make) in
            make.width.equalTo(self)
            make.centerX.equalTo(self)
            make.top.equalTo(label.snp.bottom).offset(2)
        }
        priceLabel.text = "Loading"
        
        timerLabel.text = "00:00:00"
        timerLabel.font = UIFont.systemFont(ofSize: 7*rate)
        
        timerLabel.textColor = .white
        timerLabel.backgroundColor = .gray
        timerLabel.layer.cornerRadius = 3
        timerLabel.clipsToBounds = true
        addSubview(timerLabel)
        timerLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(priceLabel)
            make.right.equalTo(self)
        }
        
        let btn = UIButton()
        btn.setTitle("参与竞标", for: .normal)
        btn.backgroundColor = orangeColor
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 8*rate)
        addSubview(btn)
        btn.snp.makeConstraints { (make) in
            make.left.right.equalTo(self)
            make.top.equalTo(priceLabel.snp.bottom)
            make.height.equalTo(10*rate)
        }
        btn.layer.cornerRadius = 5*rate
        btn.clipsToBounds = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class TimerLabel: UILabel {
    var timeInterval = 3600
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let timer = Timer(timeInterval: 1, repeats: true) { _ in
//            print("count")
            self.timerText()
        }
        
        RunLoop.current.add(timer, forMode: .default)
        timer.fire()
    }
    
    func timerText() {
        if timeInterval < 0 {
            return
        }
        let hour = timeInterval / 3600
        let min = (timeInterval % 3600) / 60
        let sec = timeInterval % 60
        let timerText = String(format: "%02d:%02d:%02d", hour, min, sec)
        text = timerText
        timeInterval -= 1
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
