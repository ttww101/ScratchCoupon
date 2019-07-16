//
//  HomeViewModel.swift
//  UUBuy
//
//  Created by Jack on 2019/6/28.
//  Copyright © 2019 com.timi.test.test. All rights reserved.
//

import UIKit
import Moya
import SVProgressHUD // add me

class HomeViewModel {
    let goodIds = [137, 144, 141, 145, 121, 111, 146, 107]
    var goodModels: [GoodModel?] = []
    
    var viewController: UIViewController!
    
    init(input: (
            collectionView: UICollectionView,
            navigationController: UINavigationController,
            viewController: UIViewController
        ),
        dependency: (
            provider: MoyaProvider<API>, object: NSObject
        )
    ) {
        viewController = input.viewController
        goodIds.map { _ in
            goodModels.append(nil)
        }
    }
    
    func setupCell(indexPath: IndexPath, reuseCell: GoodCollectionViewCell) {
        let item = indexPath.item
        let id = goodIds[item]
        let provider = MoyaProvider<API>(plugins: [MoyaCacheablePlugin()])
        
        provider.request(.getProduct(id: id)) { (result) in
            switch result {
            case .success(let moyaResponse):
                let data = moyaResponse.data // 获取到的数据
                //                let statusCode = moyaResponse.statusCode // 请求状态： 200, 401, 500, etc
                
                let good = parseGood(data: data)
                reuseCell.set(model: good)
                self.goodModels[item] = good // fix me
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func collectBtnTaped(indexPath: IndexPath) {
        let item = indexPath.item

        if UserModel.shared.isLogin() {
            if let good = self.goodModels[item] {
                CollectionModel.shared.addGood(good: good)
                SVProgressHUD.showInfo(withStatus: "加入成功") // fix me
            }
        } else {
            LoginView.show()
        }
    }
    
    func cellDidSelected(indexPath: IndexPath) {
        let row = indexPath.item
        let vc = GoodDetailTableViewController()
        vc.model = goodModels[row]
        vc.hidesBottomBarWhenPushed = true
        viewController.navigationController?.pushViewController(vc)
    }
    
    
}

class HomeCollectionViewDataSoure {
    var sectionText: String = ""
    var sectionData: [GoodModel] = []
    
    
}
