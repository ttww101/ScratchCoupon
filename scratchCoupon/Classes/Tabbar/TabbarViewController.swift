//
//  TSTabbarViewController.swift
//  TSWeChat
//
//  Created by Hilen on 11/5/15.
//  Copyright © 2015 Hilen. All rights reserved.
//

import UIKit
import SwifterSwift

class TabbarViewController: UITabBarController {

    override func loadView() {
        super.loadView()
        let shopViewController = SearchableNavigationController(rootViewController: ShopViewController())
        shopViewController.tabBarItem = UITabBarItem(title: "商城", image: UIImage(named: "card_home_icon021"), selectedImage: UIImage(named: "card_home_icon02"))
        viewControllers![1] = shopViewController
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.isTranslucent = false
        tabBar.unselectedItemTintColor = UIColor(hex: 0xFFC248)
        tabBar.tintColor = UIColor(hex: 0xFFFFFF)
        tabBar.barTintColor = UIColor(hex: 0xFF9E00)
    }

    
}
