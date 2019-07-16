//
//  CouponModel.swift
//  scratchCoupon
//
//  Created by Jack on 2019/7/16.
//  Copyright © 2019 com. All rights reserved.
//

import Foundation


class CouponModel: Codable {
    var amount: Double = 0
}

class CouponManager {
    static var shared = CouponManager()
    
    var coupons: [CouponModel] = []
    
    func add(coupon: CouponModel) {
        coupons.append(coupon)
    }
    
    func use() -> CouponModel {
        return coupons.removeFirst()
    }
    
    func show() ->CouponModel {
        return coupons.first!
    }
    
    var count: Int {
        return coupons.count
    }
}
