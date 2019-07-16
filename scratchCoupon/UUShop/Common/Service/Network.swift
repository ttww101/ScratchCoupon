//
//  Network.swift
//  UUBuy
//
//  Created by Jack on 2019/6/12.
//  Copyright © 2019 com.timi.test.test. All rights reserved.
//

import Foundation
import Kanna
import SwifterSwift

func getId(str: String) -> Int {
    let regular = try! NSRegularExpression(pattern: "\\d+")
    let result = regular.firstMatch(in: str, range: NSRange(str.startIndex..., in: str))!
    let strId = String(str[Range(result.range, in: str)!])
    return Int(strId)!
}

func parseCatelory(data: Data) -> [(String, String, [(String, Int)])] {
    var catelories: [(String, String, [(String, Int)])] = []
    if let doc = try? HTML(html: data, encoding: .utf8) {
        // list
        for node in doc.css(".category-item") {
            let title = String(node.css(".title")[0].text!.trimmed.dropLast())
            let link = node.css(".title")[0]["href"]!
            
            var subList: [(String, Int)] = []
            for node1 in node.css(".children-list li a span") {
                // sub list
                let subListTitle = node1.text!.trimmed
                let subListLink = node1.parent!["href"]!
                let id = getId(str: subListLink)
                subList.append((subListTitle, id))
            }
            catelories.append((title, link, subList))
        }
    }
    return catelories
}

func parseGoods(data: Data) -> [(String, Int)] {
    var goods: [(String, Int)] = []
    if let doc = try? HTML(html: data, encoding: .utf8) {
        // list
        for node in doc.css(".goods-item .figure a") {
            
            let title = node.css("img")[0]["alt"]!
            let link = fullPath(str: node["href"]!)
            let id = getId(str: link)
//            print("title: \(title), link: \(link)")
            goods.append((title, id))
        }
    }
    return goods
}

func fullPath(str: String) -> String {
    if !str.hasPrefix("http") {
        return "http://www.szzzbao.cn/" + str
    }
    return str
}

func parseGood(data: Data) -> GoodModel {
    var goodModel = GoodModel()
    if let doc = try? HTML(html: data, encoding: .utf8) {
        let name = doc.css(".goods-name")[0].text!.trimmed
        let price = doc.css("#ECS_SHOPPRICE")[0].text!.trimmed

        let goodNo = doc.css(".loaded dd li em")[0].text!.trimmed
        let stockNum = doc.css(".loaded dd li em")[1].text!.trimmed
        let readySellDate = doc.css(".loaded dd li em")[2].text!.trimmed
        let goodWeight = doc.css(".loaded dd li em")[3].text!.trimmed
        let goodAvailablePoint = doc.css(".loaded dd li em")[4].text!.trimmed
        
        var smallImgs: [String] = []
        for node in doc.css("#item-thumbs img") {
            let url = fullPath(str: node["src"]!.trimmed)
            smallImgs.append(url)
        }
        
        var bigImgs: [String] = []
        for node in doc.css("#item-thumbs .bd a") {
            let url = fullPath(str: node["href"]!.trimmed)
            bigImgs.append(url)
        }
    
        var detailImgs: [String] = []
        for node in doc.css(".shape-container img") {
            let url = fullPath(str: node["src"]!.trimmed)
            detailImgs.append(url)
        }
        
        goodModel.name = name
        goodModel.price = price
        goodModel.goodNo = goodNo
        goodModel.stockNum = stockNum
        goodModel.readySellDate = readySellDate
        goodModel.goodWeight = goodWeight
        goodModel.goodAvailablePoint = goodAvailablePoint
        goodModel.smallImgs = smallImgs
        goodModel.bigImgs = bigImgs
        goodModel.detailImgs = detailImgs
    }
    return goodModel
}
