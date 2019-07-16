//
//  File.swift
//  scratchCoupon
//
//  Created by Jack on 2019/7/5.
//  Copyright © 2019 com. All rights reserved.
//

import Foundation
import GameplayKit
import RxCocoa
import RxSwift

class RankModel {
    var rankNum: Int!
    var name: String!
    var amount: Int!
}

class RewardListModel {
    var rewardType: String!
    var userName: String!
    var amount: Int!
}

class ScratchCardModel {
    var rewardType: String!
    var amount: Int!
}

protocol RewardHistoryDataSource {
    
    /// 返回得獎總額排名
    ///
    /// - Returns: 前 20 名會被返回
    func getRank() -> Observable<Array<RankModel>>
    
    /// 最近中獎獎項
    ///
    /// - Returns: 按照中獎時間順序返回
    func getRewardList() -> Observable<Array<RewardListModel>>
}

import Alamofire

class DefaultRewardHistoryDataSource: RewardHistoryDataSource {
    
    let random = GKRandomSource()
    
    static let shared = DefaultRewardHistoryDataSource()
    
    var rankObservable: Observable<Array<RankModel>>!
    
    init() {
        self.rankObservable = Observable<Array<RankModel>>.create{ observer in
            while true {
                
                
                let dice3d6 = GKGaussianDistribution(randomSource: self.random, lowestValue: 2000, highestValue: 20000)
                var amount = dice3d6.nextInt()
                var arr: [RankModel] = []
                
                Alamofire.request("https://randomuser.me/api/?results=20").responseJSON(completionHandler: { (response) in
                    if let JSON = response.result.value {
                        let dict = JSON as! Dictionary<String,AnyObject>
                        let results = dict["results"] as! [Dictionary<String, AnyObject>]
                        for (i, result) in results.enumerated() {
                            let login = result["login"] as! Dictionary<String, String>
                            
                            let model = RankModel()
                            let generator = PayViewController()
                            model.name = login["username"]
                            model.rankNum = i + 1
                            
                            let dice3d6 = GKGaussianDistribution(randomSource: self.random, lowestValue: 10, highestValue: 50)
                            amount -= dice3d6.nextInt()
                            model.amount = amount
                            arr.append(model)
                        }
                        
                        observer.onNext(arr)
                    }
                    
                })
                
                sleep(1800)
            }
            
            
            //            observer.onNext(arr)
            observer.onCompleted()
            return Disposables.create()
            }.observeOn(MainScheduler.instance)
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .share(replay: 1)
    }
    
    func getRank() -> Observable<Array<RankModel>> {
        return rankObservable
    }
    
    func getRewardList() -> Observable<Array<RewardListModel>> {
        let observable = Observable<Array<RewardListModel>>.create{ observer in
            
//            while true {
//                let arr: [RankModel] = []
//                for i in 1...20 {
//                    let model = RankModel()
//                    let generator = PayViewController()
//                    model.name = generator.randomString(len: 10)
//                    model.rankNum = i
//                    model.amount = 10
//                }
//                observer.onNext(arr)
//                sleep(3)
//            }
            
            
        //            observer.onNext(arr)
        observer.onCompleted()
        return Disposables.create()
        }.observeOn(MainScheduler.instance)
        .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
        return observable
    }
}

enum ScratchCardType {
    case 福
    case 彩
    case 寶
}

class ScratchCardFactory {
    
    let random = GKRandomSource()
    func getFoo() -> ScratchCardModel {
        let dice3d6 = GKGaussianDistribution(randomSource: random, lowestValue: 50, highestValue: 500)
        let card = ScratchCardModel()
        card.amount = dice3d6.nextInt()
        card.rewardType = "福"
        return card
    }
    
    func getChi() -> ScratchCardModel {
        let dice3d6 = GKGaussianDistribution(randomSource: random, lowestValue: 80, highestValue: 800)
        let card = ScratchCardModel()
        card.amount = dice3d6.nextInt()
        card.rewardType = "財"
        return card
    }
    
    func getBou() -> ScratchCardModel {
        let dice3d6 = GKGaussianDistribution(randomSource: random, lowestValue: 12, highestValue: 120)
        let card = ScratchCardModel()
        card.amount = dice3d6.nextInt()
        card.rewardType = "寶"
        return card
    }
}

//class UserScratchManager {
//    static let shared = UserScratchManager()
//
//    let fooCard: Observable<ScratchCardModel>
//
//
//    init {
//
//    }
//}

