//
//  MeTable.swift
//  scratchCoupon
//
//  Created by Jack on 2019/7/2.
//  Copyright © 2019 com. All rights reserved.
//

import UIKit
import SVProgressHUD
import RxCocoa
import RxSwift

class MeTable: UITableView {
    
    let tableItems = ["邀請好友", "我的排行榜", "我的購物車"]

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        dataSource = self
        delegate = self
        register(cellWithClass: UITableViewCell.self)
        tableFooterView = UIView()

        let timer = Timer(timeInterval: 1, repeats: true) { _ in
            //            self.nameLabel.text = UserModel.shared.isLogin() ? "登入用户" : "游客"
            //            self.emailLabel.text = UserModel.shared.email
            let indexPath = IndexPath(row: 0, section: 0)
            self.reloadRow(at: indexPath, with: .none)
        }
        
        RunLoop.current.add(timer, forMode: .default)
        timer.fire()
    }
}

extension MeTable: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        
        if row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "memberCard") as! MeCell
            cell.nameLabel.text = UserModel.shared.isLogin() ? "登入用户" : "游客"
            cell.signIntroductionLabel.text = UserModel.shared.email
            cell.selectionStyle = .none
            return cell
        } else  {
            let cell = tableView.dequeueReusableCell(withClass: UITableViewCell.self)
            
            cell.textLabel?.text = tableItems[row-1]
            
            return cell
        }
        fatalError()
    }

}

extension MeTable: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let row = indexPath.row
    
        if row == 1 {
            let activityViewController = UIActivityViewController(activityItems: ["歡迎加入"], applicationActivities: nil)
            viewController?.present(activityViewController, animated: true, completion: nil)
        } else if row == 2 {
            let rank = arc4random() % 100 + 100
            
            SVProgressHUD.showInfo(withStatus: "排名:\(rank)")
        } else if row == 3 {
            if UserModel.shared.isLogin() {
                let cartTableViewController = CartTableViewController(style: .grouped)
                cartTableViewController.hidesBottomBarWhenPushed = true
                let navController = self.viewController?.navigationController as! UINavigationController
                navController.pushViewController(cartTableViewController)
            } else {
                LoginView.show()
            }
        }
    }
}
