//
//  SearchableViewController.swift
//  UUBuy
//
//  Created by Jack on 2019/6/18.
//  Copyright © 2019 com.timi.test.test. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import RTRootNavigationController
import Moya

public class SearchableNavigationController: RTRootNavigationController {
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        //        let textField = SearchTextField()
        //        textField.frame = CGRect(x: 10, y: 30, width: 300, height: 35)
        //        textField.placeholder = "明星商品"
        //
        //        let searchImgView = UIImageView(named: "buy_s")
        //        textField.addSubview(searchImgView)
        //        textField.contentVerticalAlignment = .center
        //        searchImgView.snp.makeConstraints { (make) in
        //            make.centerY.equalTo(textField)
        //            make.width.height.equalTo(18)
        //            make.left.equalTo(textField).offset(10)
        //        }
        //        textField.addSubview(searchImgView)
        //        view.addSubview(textField)
        //
        //        let btn = UIButton()
        //        view.addSubview(btn)
        //
        //        btn.setImage(UIImage(named: "buy_car"), for: .normal)
        //        btn.snp.makeConstraints { (make) in
        //            make.centerY.equalTo(textField)
        //            make.width.height.equalTo(25)
        //            make.right.equalTo(view).offset(-25)
        //        }
        //        btn.rx.tap.subscribe(onNext: {
        //            let cartTableViewController = CartTableViewController()
        //            cartTableViewController.hidesBottomBarWhenPushed = true
        //            self.pushViewController(cartTableViewController)
        //        })
    }
    
}

class MyNavavigationBar: UINavigationBar, UITextFieldDelegate {
    var customHeight : CGFloat = 90
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let keyword = textField.text!
        let provider = MoyaProvider<API>(plugins: [MoyaCacheablePlugin()])
        provider.request(.searchGood(keyword: keyword)) { (result) in
            switch result {
            case .success(let moyaResponse):
                let data = moyaResponse.data // 获取到的数据
                
                let goods = parseGoods(data: data)
                var arr: [Int] = []
                for i in goods {
                    arr.append(i.1)
                }
                let searchResultViewController = SearchResultViewController()
                searchResultViewController.ids = arr
                let navigationController = self.viewController! as! UINavigationController
                navigationController.pushViewController(searchResultViewController)
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        return true
    }
    
    @objc func doneWithNumberPad() {
        UIApplication.shared.sendAction(#selector(resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        isTranslucent = true
        
        let textField = SearchTextField()
        textField.frame = CGRect(x: 10, y: 30, width: 300, height: 35)
        textField.placeholder = "明星商品"
        
        let searchImgView = UIImageView(named: "buy_s")
        textField.addSubview(searchImgView)
        textField.contentVerticalAlignment = .center
        let numberToolbar = UIToolbar(frame:CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        numberToolbar.barStyle = .default
        numberToolbar.items = [
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneWithNumberPad))]
        numberToolbar.sizeToFit()
        textField.inputAccessoryView = numberToolbar
        
        
        
        searchImgView.snp.makeConstraints { (make) in
            make.centerY.equalTo(textField)
            make.width.height.equalTo(18)
            make.left.equalTo(textField).offset(10)
        }
        textField.delegate = self
        textField.addSubview(searchImgView)
        addSubview(textField)
        
        let btn = UIButton()
        addSubview(btn)
        
        btn.setImage(UIImage(named: "buy_car"), for: .normal)
        btn.snp.makeConstraints { (make) in
            make.centerY.equalTo(textField)
            make.width.height.equalTo(25)
            make.right.equalTo(self).offset(-25)
        }
        btn.rx.tap.subscribe(onNext: {
            if UserModel.shared.isLogin() {
                let cartTableViewController = CartTableViewController(style: .grouped)
                cartTableViewController.hidesBottomBarWhenPushed = true
                let navController = self.viewController as! UINavigationController
                navController.pushViewController(cartTableViewController)
            } else {
                LoginView.show()
            }
            
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        
        return CGSize(width: UIScreen.main.bounds.width, height: customHeight)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        frame = CGRect(x: frame.origin.x, y:  0, width: frame.size.width, height: customHeight)
        
        // title position (statusbar height / 2)
        setTitleVerticalPositionAdjustment(-10, for: UIBarMetrics.default)
        
        for subview in self.subviews {
            var stringFromClass = NSStringFromClass(subview.classForCoder)
            if stringFromClass.contains("BarBackground") {
                //                subview.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: customHeight)
                //                subview.backgroundColor = .yellow
                
            }
            
            stringFromClass = NSStringFromClass(subview.classForCoder)
            if stringFromClass.contains("BarContent") {
                
                subview.frame = CGRect(x: subview.frame.origin.x, y: 0, width: subview.frame.width, height: customHeight)
                
                subview.backgroundColor = UIColor(red: 20/255, green: 20/255, blue: 20/255, alpha: 0.4)
                let image = UIImage(named: "tabbar-image")
                let imageView = UIImageView(image: image)
                imageView.frame = subview.frame
                subview.addSubview(imageView)
                
            }
        }
    }
}
