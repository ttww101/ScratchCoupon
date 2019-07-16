//
//  UserStateModel.swift
//  scratchCoupon
//
//  Created by Jack on 2019/7/15.
//  Copyright © 2019 com. All rights reserved.
//

import UIKit

class UserStateModel: Codable {
    static var shared = UserStateModel()
    
    var cardDate1: Date?
    var cardDate2: Date?
    var cardDate3: Date?
    
    
    func isUsed1() -> Bool {
        if let cardDate1 = cardDate1 {
            return Calendar.current.isDateInToday(cardDate1)
        }
        return false
    }
    
    func isUsed2() -> Bool {
        if let cardDate2 = cardDate2 {
            return Calendar.current.isDateInToday(cardDate2)
        }
        return false
    }
    
    func isUsed3() -> Bool {
        if let cardDate3 = cardDate3 {
            return Calendar.current.isDateInToday(cardDate3)
        }
        return false
    }
}
