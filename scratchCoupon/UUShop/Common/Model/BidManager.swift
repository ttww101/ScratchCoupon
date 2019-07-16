//
//  BidManager.swift
//  UUBuy
//
//  Created by Jack on 2019/6/21.
//  Copyright © 2019 com.timi.test.test. All rights reserved.
//

import Foundation
import Moya

class BidManager: NSObject {
    static let shared = BidManager()
    
    let lastUpdateTime = Date()
    
    func printPool() {
        var goodsPool: [Int] = []
        let provider = MoyaProvider<API>(plugins: [MoyaCacheablePlugin()])
        provider.request(.getCatelory) { (result) in
            switch result {
            case .success(let moyaResponse):
                let data = moyaResponse.data // 获取到的数据
                let catelogory = parseCatelory(data: data)
 
                for i in catelogory {
                    for j in i.2 {
                        let provider = MoyaProvider<API>(plugins: [MoyaCacheablePlugin()])
                        provider.request(.getProducts(id: j.1)) { (result) in
                            switch result {
                            case .success(let moyaResponse):
                                let data = moyaResponse.data // 获取到的数据
                                let goods = parseGoods(data: data)
                                for good in goods {
                                    goodsPool.append(good.1)
                                }
                                print(goodsPool)
                                
                            case .failure(let error):
                                print(error.localizedDescription)
                            }
                        }
                    }
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    var oneDollarModels: [OneDollarGoodModel] = []
    
    func firstTime() {
        for i in 0..<8 {
            oneDollarModels.append(OneDollarGoodModel())
            newModel(i: i)
        }
    }
    
    func newModel(i: Int) {
        var goodsPool: [Int] = [107, 108, 111, 112, 110, 146, 130, 131, 132, 133, 134, 137, 135, 136, 140, 141, 138, 139, 145, 144, 143, 142, 122, 118, 121, 119, 117, 120, 114, 106, 113, 115, 116, 105, 123, 125, 126, 127, 128, 129, 147, 148, 124]

        var existModelId: [Int] = []
        for i in oneDollarModels {
//            i.id
            if !i.isOvertime() {
                existModelId.append(i.id)
            }
        }
        
        func isExit(id: Int) -> Bool {
            return existModelId.contains(id)
        }
    
        var randNum = Int(arc4random()) % goodsPool.count
        repeat {
            randNum = Int(arc4random()) % goodsPool.count
        } while isExit(id: goodsPool[randNum])
        
        let good = self.oneDollarModels[i]
        
        
        good.deadline = calendar.date(byAdding: Calendar.Component.hour, value: 1, to: Date())!
        good.currentBidPrice = 1
        good.startBidPrice = 1
        good.id = goodsPool[randNum]
        
    }
    let calendar = Calendar.current
    
    func timerJob() {
        // 3-5 分钟后更新一元商品得标价格
        
        // 每一分钟检查是否有商品需要更新
        for i in 0..<self.oneDollarModels.count {
            if self.oneDollarModels[i].isOvertime() {
                self.newModel(i: i)
            }
        }
        let timer = Timer(timeInterval: 5, block: { (_) in
            for i in 0..<self.oneDollarModels.count {
                if self.oneDollarModels[i].isOvertime() {
                    self.newModel(i: i)
                }
            }
        }, repeats: true)
        RunLoop.current.add(timer, forMode: .default)
        timer.fire()
    }
    
    func oneDollarGoods() {
        
    }
}
