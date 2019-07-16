//
//  NavigationController.swift
//  scratchCoupon
//
//  Created by Jack on 2019/7/4.
//  Copyright © 2019 com. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationBar.setBackgroundImage(getGradientImage(width: width, height: 64), for: .default)
//        title = "福彩寶刮刮樂"
        navigationBar.tintColor = .white
        navigationBar.setTitleFont(UIFont.boldSystemFont(ofSize: 18), color: .white)
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
