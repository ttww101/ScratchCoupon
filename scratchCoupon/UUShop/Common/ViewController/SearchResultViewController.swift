//
//  SearchResultViewController.swift
//  UUBuy
//
//  Created by Jack on 2019/6/19.
//  Copyright © 2019 com.timi.test.test. All rights reserved.
//

import UIKit
import Moya

class SearchResultViewController: UIViewController, UICollectionViewDelegate {

    var ids: [Int] = []
    var goods: [(String, String, [(String, Int)])] = []
    var collectionView: ShopCollectionView! = nil
    
    public override func rt_navigationBarClass() -> AnyClass! {
        return MyNavavigationBar.self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let navBar = MyNavavigationBar()
        view.addSubview(navBar)
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 150, height: 200)
        layout.minimumLineSpacing = 5
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        collectionView = ShopCollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.ids = ids
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(view.snp.topMargin)
            make.left.right.equalTo(view)
            make.bottom.equalTo(view.snp.bottomMargin)
        }
        collectionView.delegate = self
        collectionView.contentInset = UIEdgeInsets(top: 26, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let row = indexPath.item
        let vc = GoodDetailTableViewController()
        
        vc.model = self.collectionView.goodModels[row]
        vc.hidesBottomBarWhenPushed = true
        
        navigationController?.pushViewController(vc)
    }

}
