//
//  CartModel.swift
//  UUBuy
//
//  Created by Jack on 2019/6/19.
//  Copyright © 2019 com.timi.test.test. All rights reserved.
//

import Foundation

class CartModel: NSObject {
    func getPrice(str: String) -> Double {
        let regular = try! NSRegularExpression(pattern: "\\d+\\.?\\d*")
        let result = regular.firstMatch(in: str, range: NSRange(str.startIndex..., in: str))!
        let price = String(str[Range(result.range, in: str)!])
        return Double(price)!
    }
    static let shared = CartModel()
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
    
    func total() -> Double {
        var sum: Double = 0
        for i in goodModels {
            let price = getPrice(str: i.price) * Double(i.count)
            sum += price
        }
        return sum
    }
}

func archive(object: Codable, path: String) {
    let data = try! NSKeyedArchiver.archivedData(withRootObject: object, requiringSecureCoding: false)
    let libPath = "file://" + NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true).last!
    let savePath = libPath + "/\(path).archiver"
    try! data.write(to: URL(string: savePath)!)
}

func unarchive(path: String) -> NSCoding? {
    let libPath = "file://" + NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true).last!
    let savePath = libPath + "/\(path).archiver"
    let data = try? Data(contentsOf: URL(string: savePath)!)
    if let data = data {
        let codingObj = try! NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data)
        return codingObj as! NSCoding
    }
    return nil
    
}
