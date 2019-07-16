//
//  OneDollarViewController.swift
//  UUBuy
//
//  Created by Jack on 2019/6/17.
//  Copyright © 2019 com.timi.test.test. All rights reserved.
//

import UIKit
import Moya
import YYKit

class OneDollarCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var goodIds: [Int] = []
    let headerText = ["Hot", "Now"]
    //    let goodIds = [137, 137, 137, 137, 137, 137, 137, 137]
    var goodModels: [GoodModel?] = []
    
    public override func rt_navigationBarClass() -> AnyClass! {
        return MyNavavigationBar.self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        collectionView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        
        collectionView!.register(cellWithClass: OneDollarGoodCollectionViewCell.self)
        
        collectionView.register(supplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withClass: HomeHeaderCollectionReusableView.self)
        let v = UICollectionReusableView()
        // Do any additional setup after loading the view.
        
        for _ in 0..<8 {
            goodModels.append(nil)
        }
        collectionView.backgroundColor = UIColor(hex: 0xF0F0F0)
        collectionView.dataSource = self
        collectionView.contentInset = UIEdgeInsets(top: 26, left: 0, bottom: 0, right: 0)
    }
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 4
        }
        goodIds = []
        for i in BidManager.shared.oneDollarModels {
            goodIds.append(i.id)
        }
        return 8
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = indexPath.section
        
        let cell = collectionView.dequeueReusableCell(withClass: OneDollarGoodCollectionViewCell.self, for: indexPath)
        
        let item = indexPath.item
        let id = goodIds[item]
        let oneDollarModel = BidManager.shared.oneDollarModels[item]
        let provider = MoyaProvider<API>(plugins: [MoyaCacheablePlugin()])
        provider.request(.getProduct(id: id)) { (result) in
            switch result {
            case .success(let moyaResponse):
                let data = moyaResponse.data // 获取到的数据
                //                let statusCode = moyaResponse.statusCode // 请求状态： 200, 401, 500, etc
                
                let good = parseGood(data: data)
                self.goodModels[item] = good
                cell.label.text = good.name
                cell.priceLabel.text = good.price
                cell.timerLabel.timeInterval = Int(oneDollarModel.deadline.timeIntervalSince1970 - Date().timeIntervalSince1970)
//                                let imgData = try? Data(contentsOf: URL(string: good.bigImgs[0])!)
                //                cell.imageView.image = UIImage(data: imgData!)
                cell.imageView.imageURL = URL(string: good.bigImgs[0])
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        print(indexPath)
        let row = indexPath.item
        let vc = OneDollarDetailTableViewController()
        vc.model = goodModels[row]
        vc.hidesBottomBarWhenPushed = true
        vc.oneDollarModel = BidManager.shared.oneDollarModels[row]
        navigationController?.pushViewController(vc)
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let section = indexPath.section
        if section == 0 {
            return CGSize(width: 75, height: 130)
        }
        return CGSize(width: 150, height: 260)
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withClass: HomeHeaderCollectionReusableView.self, for: indexPath)
        let section = indexPath.section
        header.label.text = headerText[section]
        
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 20, bottom: 10, right: 20)
    }
    
}
