//
//  AppDelegate.swift
//  scratchCoupon
//
//  Created by Jack on 2019/7/1.
//  Copyright © 2019 com. All rights reserved.
//

import UIKit
import Moya
import SVProgressHUD
import Shallows
import RTRootNavigationController

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func applicationWillTerminate(_ application: UIApplication) {
        //        do {
        //            let diskStorage = DiskStorage.main.folder("carts", in: .cachesDirectory)
        //                .mapJSONObject(Array<GoodModel>.self) // Storage<Filename, City>
        //
        //            let cartModels = CartModel.shared.goodModels
        //            diskStorage.set(cartModels, forKey: "cartModels")
        //        }
        
        
        //        diskStorage.retrieve(forKey: "cartModels") { (result) in
        //            if let city = result.value { print(city) }
        //        }
        do {
            let jsonData = try JSONEncoder().encode(CartModel.shared.goodModels)
            let jsonString = String(decoding: jsonData, as: UTF8.self)
            print(jsonString)
            archive(object: jsonString, path: "cart")
        }catch{
            print(error.localizedDescription)
        }
        
        do {
            let jsonData = try JSONEncoder().encode(CollectionModel.shared.goodModels)
            let jsonString = String(decoding: jsonData, as: UTF8.self)
            print(jsonString)
            archive(object: jsonString, path: "collection")
        }catch{
            print(error.localizedDescription)
        }
        
        do {
            let jsonData = try JSONEncoder().encode(UserModel.allUser)
            let jsonString = String(decoding: jsonData, as: UTF8.self)
            print(jsonString)
            archive(object: jsonString, path: "user")
        }catch{
            print(error.localizedDescription)
        }
        
        do {
            let jsonData = try JSONEncoder().encode(UserModel.shared)
            let jsonString = String(decoding: jsonData, as: UTF8.self)
            print(jsonString)
            archive(object: jsonString, path: "currentUser")
        }catch{
            print(error.localizedDescription)
        }
        
        do {
            let jsonData = try JSONEncoder().encode(BidManager.shared.oneDollarModels)
            let jsonString = String(decoding: jsonData, as: UTF8.self)
            print(jsonString)
            archive(object: jsonString, path: "oneDollar")
        }catch{
            print(error.localizedDescription)
        }
        
        do {
            let jsonData = try JSONEncoder().encode(UserStateModel.shared)
            let jsonString = String(decoding: jsonData, as: UTF8.self)
            print(jsonString)
            archive(object: jsonString, path: "UserStateModel")
        }catch{
            print(error.localizedDescription)
        }
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        //        BidManager.shared.scheduleGenerator()
        BidManager.shared.timerJob()
        SVProgressHUD.setMaxSupportedWindowLevel(UIWindow.Level.alert + 1)
        
        //        do {
        //            let diskStorage = DiskStorage.main.folder("carts", in: .cachesDirectory)
        //                .mapJSONObject(Array<GoodModel>.self) // Storage<Filename, City>
        //
        ////            let cartModels = CartModel.shared.goodModels
        ////            diskStorage.set(cartModels, forKey: "cartModels")
        //
        //            diskStorage.retrieve(forKey: "cartModels") { (result) in
        //                if let cartModels = result.value {
        //                    CartModel.shared.goodModels = cartModels
        //                }
        //            }
        //        }
        
        do {
            let jsonStr = unarchive(path: "UserStateModel") as? String
            if let jsonStr = jsonStr {
                UserStateModel.shared = try! JSONDecoder().decode(UserStateModel.self,from: jsonStr.data(using: .utf8)!)
            }
        }
        
        do {
            let jsonStr = unarchive(path: "cart") as? String
            if let jsonStr = jsonStr {
                CartModel.shared.goodModels = try! JSONDecoder().decode(Array<GoodModel>.self,from: jsonStr.data(using: .utf8)!)
            }
        }
        
        do {
            let jsonStr = unarchive(path: "collection") as? String
            if let jsonStr = jsonStr {
                CollectionModel.shared.goodModels = try! JSONDecoder().decode(Array<GoodModel>.self,from: jsonStr.data(using: .utf8)!)
            }
        }
        
        do {
            let jsonStr = unarchive(path: "user") as? String
            if let jsonStr = jsonStr {
                UserModel.allUser = try! JSONDecoder().decode(Array<UserModel>.self,from: jsonStr.data(using: .utf8)!)
            }
        }
        
        do {
            let jsonStr = unarchive(path: "currentUser") as? String
            if let jsonStr = jsonStr {
                UserModel.shared = try! JSONDecoder().decode(UserModel.self,from: jsonStr.data(using: .utf8)!)
            }
        }
        
        do {
            let jsonStr = unarchive(path: "oneDollar") as? String
            //            print("dsafjdjaskjfksdal \(jsonStr)")
            if jsonStr == nil {
                BidManager.shared.firstTime()
            } else {
                if let jsonStr = jsonStr {
                    BidManager.shared.oneDollarModels = try! JSONDecoder().decode(Array<OneDollarGoodModel>.self,from: jsonStr.data(using: .utf8)!)
                }
            }
        }
        
        let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
        if launchedBefore  {
            print("Not first launch.")
        } else {
            print("First launch, setting UserDefault.")
            UserModel.shared.register(email: "test001@gmail.com", password: "shop999", address: "address")
            UserModel.shared.logout()
            UserDefaults.standard.set(true, forKey: "launchedBefore")
        }

        // set rootViewController
//        window = UIWindow()
//        self.window = UIWindow()
//        self.window?.backgroundColor = .white
//        let viewController = <#UIViewController#>
//        self.window?.rootViewController = viewController
//        self.window?.makeKeyAndVisible()
        
        return true
    }

}

