//
//  GoodsModel.swift
//  UUBuy
//
//  Created by Jack on 2019/6/12.
//  Copyright © 2019 com.timi.test.test. All rights reserved.
//

import Foundation

class GoodModel: NSObject, Codable {
    var name: String!
    var price: String!
    var goodNo: String!
    var stockNum: String!
    var readySellDate: String!
    var goodWeight: String!
    var goodAvailablePoint: String!
    
    var smallImgs: [String]! = []
    var bigImgs: [String]! = []
    var detailImgs: [String]! = []
    
    var count = 1
    
}
