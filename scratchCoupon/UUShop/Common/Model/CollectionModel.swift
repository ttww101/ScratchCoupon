//
//  CollectionModel.swift
//  UUBuy
//
//  Created by Jack on 2019/6/20.
//  Copyright © 2019 com.timi.test.test. All rights reserved.
//

import Foundation

class CollectionModel: NSObject, Codable {
    static let shared = CollectionModel()
    var goodModels: [GoodModel] = []
    
    func addGood(good: GoodModel) {
        let goodNo = good.goodNo
        for i in goodModels {
            if i.goodNo == goodNo {
                return
            }
        }
        goodModels.append(good)
    }
    
    func removeGood(good: GoodModel) {
        let goodNo = good.goodNo
        for i in goodModels {
            if i.goodNo == goodNo {
                goodModels.removeAll(i)
            }
        }
    }
}
