//
//  OneDollarGoodModel.swift
//  UUBuy
//
//  Created by Jack on 2019/6/21.
//  Copyright © 2019 com.timi.test.test. All rights reserved.
//

import Foundation

class OneDollarGoodModel: Codable {
    var deadline = Date()
    var currentBidPrice: Double!
    var startBidPrice: Double!
    var bidUser: UserModel?
    var id: Int!
    
    func isOvertime() -> Bool {
        return Date() > deadline
    }
    
    func extendDeadline() {
        let calendar = Calendar.current
        deadline = calendar.date(byAdding: Calendar.Component.minute, value: 10, to: deadline)!
    }
}
