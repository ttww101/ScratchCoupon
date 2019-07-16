//
//  MeTableView.swift
//  UUBuy
//
//  Created by Jack on 2019/6/13.
//  Copyright © 2019 com.timi.test.test. All rights reserved.
//

import UIKit

class MeTableView: UITableView, UITableViewDataSource, UITableViewDelegate {
    
    var nav: UINavigationController? = nil
    let titles = ["购买清单", "我的竞标", "我的收藏", "领红包"]
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        
        let cell = dequeueReusableCell(withClass: UITableViewCell.self)
        cell.textLabel?.text = titles[row]
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let row = indexPath.row
        let buyListViewController = BuyListViewController()
        buyListViewController.navigationItem.title = titles[row]
        let navTitle = titles[row]
        if row == 0 {
            buyListViewController.navTitle = navTitle
            buyListViewController.goodModels = CartModel.shared.goodModels
        } else if row == 1 {
            let vc = OneDollarBidListViewController()
            self.nav?.pushViewController(vc)
            return
        } else if row == 2 {
            buyListViewController.navTitle = navTitle
            buyListViewController.goodModels = CollectionModel.shared.goodModels
        } else if row == 3 {
            let vc = ReceiveRedEnvelopesViewController()
//        vc.navigationController!.navigationBar.setBackgroundImage(getGradientImage(width: width, height: 64), for: .default)

            self.nav?.pushViewController(vc)
            return
        }
        self.nav?.pushViewController(buyListViewController)
    }
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        delegate = self
        dataSource = self
        register(cellWithClass: UITableViewCell.self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
