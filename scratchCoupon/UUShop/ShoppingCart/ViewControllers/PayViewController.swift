//
//  PayViewController.swift
//  UUBuy
//
//  Created by Jack on 2019/6/25.
//  Copyright © 2019 com.timi.test.test. All rights reserved.
//

import UIKit
import Alamofire
import WebKit

class PayViewController: UIViewController {
    
    override func rt_customBackItem(withTarget target: Any!, action: Selector!) -> UIBarButtonItem! {
        let btn = UIButton()
        btn.addTarget(target, action: action, for: .touchUpInside)
        btn.setImage(UIImage(named: "back"), for: .normal)
        return UIBarButtonItem(customView: btn)
    }
    
    lazy var webView: WKWebView = { [unowned self] in
        let wkWebView = WKWebView(frame: self.view.frame)
        return wkWebView
    }()
    
    func randomString(len:Int) -> String {
        let charSet = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
        var c = Array(charSet)
        var s:String = ""
        for n in (1...len) {
            s.append(c[Int(arc4random()) % c.count])
        }
        return s
    }

    var sum = 99.9
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(webView)
        navigationController!.navigationBar.setBackgroundImage(getGradientImage(width: width, height: 64), for: .default)

        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let ts = dateFormatterGet.string(from: Date())
        
        let pay_memberid = "10113"
        let pay_orderid = randomString(len: 20)
        let pay_applydate = ts
        let pay_bankcode = "902"
        let pay_notifyurl = "https://example.com"
        let pay_callbackurl = "https://example.com"
        let pay_amount = "\(sum)"
        let pay_productname = "测试商品"
        
        let str = "pay_amount=\(pay_amount)&pay_applydate=\(pay_applydate)&pay_bankcode=\(pay_bankcode)&pay_callbackurl=\(pay_callbackurl)&pay_memberid=\(pay_memberid)&pay_notifyurl=\(pay_notifyurl)&pay_orderid=\(pay_orderid)&key=03t0qntryrk48cfnchsumkojeuxuu737"
        print(str)
        let pay_md5sign = str.md5().uppercased()
        
        let parameters = [
            "pay_memberid": pay_memberid,
            "pay_orderid": pay_orderid,
            "pay_applydate": pay_applydate,
            "pay_bankcode": pay_bankcode,
            "pay_notifyurl": pay_notifyurl,
            "pay_callbackurl": pay_callbackurl,
            "pay_amount": pay_amount,
            "pay_md5sign": pay_md5sign,
            "pay_productname": pay_productname
        ]
        
        let headers = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        Alamofire.request("http://www.lodewn.cn/Pay_Index.html", method: .post, parameters: parameters, encoding: URLEncoding(), headers: headers).response { (response) in
//            print(response.request)
//            print(response.response)
            print(String(data: response.data!, encoding: .utf8))
            let htmlStr = String(data: response.data!, encoding: .utf8)!
            self.webView.loadHTMLString(htmlStr, baseURL: URL(string: "http://www.lodewn.cn/Pay_Index.html"))
            print(response.error)
        }
    }

}
