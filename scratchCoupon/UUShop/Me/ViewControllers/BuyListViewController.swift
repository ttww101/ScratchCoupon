//
//  BuyListViewController.swift
//  UUBuy
//
//  Created by Jack on 2019/6/20.
//  Copyright © 2019 com.timi.test.test. All rights reserved.
//

import UIKit

class BuyListViewController: MeViewController, UICollectionViewDelegate {
    var collectionView: ShopCollectionView! = nil
    
    override func rt_customBackItem(withTarget target: Any!, action: Selector!) -> UIBarButtonItem! {
        let btn = UIButton()
        btn.addTarget(target, action: action, for: .touchUpInside)
        btn.setImage(UIImage(named: "back"), for: .normal)
        return UIBarButtonItem(customView: btn)
    }
    
    var navTitle = ""

    var goodModels: [GoodModel] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController!.navigationBar.setBackgroundImage(getGradientImage(width: width, height: 64), for: .default)
        title = navTitle
        logoutBtn.isHidden = true
//        meTableView.isHidden = true
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 150, height: 200)
        layout.minimumLineSpacing = 5
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        collectionView = ShopCollectionView(frame: CGRect(x: 15, y: 160, width: width-30, height: height - 300), collectionViewLayout: layout)
        collectionView.layer.cornerRadius = 10
        collectionView.clipsToBounds = true
        collectionView.goodModels = goodModels
        collectionView.useId = false
        view.addSubview(collectionView)
        
        collectionView.delegate = self
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let row = indexPath.item
        let vc = GoodDetailTableViewController()
        
        vc.model = self.collectionView.goodModels[row]
        vc.hidesBottomBarWhenPushed = true
        
        navigationController?.pushViewController(vc)
    }
}

class OneDollarBidListViewController: MeViewController, UICollectionViewDelegate {
    var collectionView: OneDollarCollectionView! = nil
    
    override func rt_customBackItem(withTarget target: Any!, action: Selector!) -> UIBarButtonItem! {
        let btn = UIButton()
        btn.addTarget(target, action: action, for: .touchUpInside)
        btn.setImage(UIImage(named: "back"), for: .normal)
        return UIBarButtonItem(customView: btn)
    }
    
    var goodModels: [GoodModel] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController!.navigationBar.setBackgroundImage(getGradientImage(width: width, height: 64), for: .default)
        title = "我的竞标"
        logoutBtn.isHidden = true
//        meTableView.isHidden = true
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 150, height: 200)
        layout.minimumLineSpacing = 5
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        collectionView = OneDollarCollectionView(frame: CGRect(x: 15, y: 160, width: width-30, height: height - 300), collectionViewLayout: layout)
        collectionView.layer.cornerRadius = 10
        collectionView.clipsToBounds = true
        collectionView.goodModels = goodModels
        collectionView.useId = false
        view.addSubview(collectionView)
        
        collectionView.delegate = self
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let row = indexPath.item
        
        let id = self.collectionView.goodIds[row]
        
        
        var index = 0
        for (ii, m) in BidManager.shared.oneDollarModels.enumerated() {
            if m.id == id {
                index = ii
                break
            }
        }
        
        let vc = OneDollarDetailTableViewController()
        vc.model = self.collectionView.goodModels[row]
        vc.hidesBottomBarWhenPushed = true
        vc.oneDollarModel = BidManager.shared.oneDollarModels[index]
        navigationController?.pushViewController(vc)
        
//        let row = indexPath.item
//        let vc = GoodDetailTableViewController()
//
//
//        vc.model = self.collectionView.goodModels[row]
//        vc.hidesBottomBarWhenPushed = true
//
//        navigationController?.pushViewController(vc)
    }
}
