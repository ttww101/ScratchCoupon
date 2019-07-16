//
//  BeautyViewController.swift
//  JXScratchTicketView
//
//  Created by jiaxin on 2018/6/25.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

import UIKit
import SVProgressHUD

class CardDetailViewController: UIViewController, JXScratchViewDelegate {
    func scratchView(scratchView: JXScratchView, didScratched percent: Float) {
        if percent > 0.3 {
            scratchView.showContentView()
            if amount != 0 {
                SVProgressHUD.showInfo(withStatus: "恭喜刮中\(amount)元優惠券")
            } else {
                SVProgressHUD.showInfo(withStatus: "再接再厲")
            }
        }
    }
    
    var aboveImageView: UIImageView!
    var underImageView: UIImageView!
    var beautyView: JXScratchView!

    var currentIndex: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.lightGray

        aboveImageView = UIImageView()
        underImageView = UIImageView()

        beautyView = JXScratchView(contentView: underImageView, maskView: aboveImageView)
        beautyView.delegate = self
        beautyView.strokeLineWidth = 30
        let margin: CGFloat = 20
        let width = UIScreen.main.bounds.size.width - margin*2
        let height = width*(480/320)
        beautyView.frame = CGRect(x: margin, y: 100, width: width, height: height)
        self.view.addSubview(beautyView)

        
        reloadData()

        let tap = UITapGestureRecognizer(target: self, action: #selector(nextBeauty))
        tap.numberOfTapsRequired = 2
        tap.numberOfTouchesRequired = 1
        self.view.addGestureRecognizer(tap)
    }

    @objc func nextBeauty() {
        currentIndex += 1
        reloadData()
    }

    var index = 1
    var amount = 0
    func reloadData() {
        let cardImages1 = ["card_1242x2208_01_00", "card_1242x2208_01_05", "card_1242x2208_01_10", "card_1242x2208_01_50"]
        let cardImages2 = ["card_1242x2208_02_00", "card_1242x2208_02_05", "card_1242x2208_02_10", "card_1242x2208_02_100"]
        let cardImages3 = ["card_1242x2208_03_00", "card_1242x2208_03_05", "card_1242x2208_03_10", "card_1242x2208_03_50"]
        let cardImages = [cardImages1, cardImages2, cardImages3]
        let random = Int(arc4random() % 4)
        
        var aboveImageName = String(format: "card_1242x2208_0%d示意圖", index)
        var underImageName = cardImages[index-1][random]
        
        let matchText = matches(for: "\\d{2,3}", in: underImageName)
        
        amount = Int(matchText[3])!
        aboveImageView.image = UIImage(named: aboveImageName)
        underImageView.image = UIImage(named: underImageName)
        if amount > 0 {
            let coupon = CouponModel()
            coupon.amount = Double(amount)
            CouponManager.shared.add(coupon: coupon)
        }
        
        
//        beautyView.resetState()
    }

}

func matches(for regex: String, in text: String) -> [String] {
    
    do {
        let regex = try NSRegularExpression(pattern: regex)
        let results = regex.matches(in: text,
                                    range: NSRange(text.startIndex..., in: text))
        return results.map {
            String(text[Range($0.range, in: text)!])
        }
    } catch let error {
        print("invalid regex: \(error.localizedDescription)")
        return []
    }
}
