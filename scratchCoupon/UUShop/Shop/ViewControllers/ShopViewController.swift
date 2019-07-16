//
//  ShopViewController.swift
//  UUBuy
//
//  Created by Jack on 2019/6/17.
//  Copyright © 2019 com.timi.test.test. All rights reserved.
//

import UIKit
import JXSegmentedView
import Moya

class ShopViewController: UIViewController, JXSegmentedViewDelegate, UICollectionViewDelegate {
    let segmentedDataSource = JXSegmentedTitleDataSource()
    let segmentedDataSource1 = JXSegmentedTitleDataSource()
    let segmentView = JXSegmentedView()
    let detailSegmentView = JXSegmentedView()

    var mainSelectedIndex = 0
    var rawGoodArr: [(String, String, [(String, Int)])] = []
    var collectionView: ShopCollectionView! = nil
    
    public override func rt_navigationBarClass() -> AnyClass! {
        return MyNavavigationBar.self
    }
    
    func setupSegmentFrom(rawGoodArr: [(String, String, [(String, Int)])]) {
        var attr: [String] = []
        for good in self.rawGoodArr {
            attr.append(good.0)
        }
        self.segmentedDataSource.isTitleColorGradientEnabled = true
        
        self.segmentedDataSource.titles = attr
        segmentView.dataSource = self.segmentedDataSource
        self.segmentedDataSource.reloadData(selectedIndex: 0)
        segmentView.reloadData()
        self.segmentedView(segmentView, didClickSelectedItemAt: 0)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

//        let navBar = MyNavavigationBar()
//        view.addSubview(navBar)

        // setup segment
        
        segmentView.delegate = self
        
        let indicator = JXSegmentedIndicatorLineView()
        indicator.indicatorWidth = 20
        segmentView.indicators = [indicator]
        
        view.addSubview(segmentView)
        segmentView.snp.makeConstraints { (make) in
            make.top.equalTo(view.snp.topMargin).offset(26)
            make.left.right.equalTo(view)
            make.height.equalTo(30)
        }

        let provider = MoyaProvider<API>(plugins: [MoyaCacheablePlugin()])
        provider.request(.getCatelory) { (result) in
            switch result {
            case .success(let moyaResponse):
                let data = moyaResponse.data // 获取到的数据
                self.rawGoodArr = parseCatelory(data: data)
                self.setupSegmentFrom(rawGoodArr: self.rawGoodArr)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }

        // setup detail segment
        detailSegmentView.delegate = self
        
        let detailSegIndicator1 = JXSegmentedIndicatorLineView()
        detailSegIndicator1.indicatorWidth = 20
        detailSegmentView.indicators = [detailSegIndicator1]
        
        view.addSubview(detailSegmentView)
        detailSegmentView.snp.makeConstraints { (make) in
            make.top.equalTo(segmentView.snp.bottom)
            make.left.right.equalTo(view)
            make.height.equalTo(30)
        }
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 150, height: 200)
        layout.minimumLineSpacing = 5
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        collectionView = ShopCollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(detailSegmentView.snp.bottom)
            make.left.right.equalTo(view)
            make.bottom.equalTo(view.snp.bottomMargin)
        }
        
        collectionView.delegate = self
    }
    
    
    func setupCollectionViewFrom(rawGoodArr: [(String, Int)]) {
        var categoryIdArr: [Int] = []
        for rawGood in rawGoodArr {
            categoryIdArr.append(rawGood.1)
        }
        self.collectionView.ids = categoryIdArr
        self.collectionView.reloadData()
    }
    
    func segmentedView(_ segmentedView: JXSegmentedView, didClickSelectedItemAt index: Int) {
        if segmentedView == self.detailSegmentView {
            let id = rawGoodArr[mainSelectedIndex].2[index].1
            
            let provider = MoyaProvider<API>(plugins: [MoyaCacheablePlugin()])
            provider.request(.getProducts(id: id)) { (result) in
                switch result {
                case .success(let moyaResponse):
                    let data = moyaResponse.data // 获取到的数据
                    let rawGoodArr = parseGoods(data: data)
                    self.setupCollectionViewFrom(rawGoodArr: rawGoodArr)
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        } else {
            var attr: [String] = []
            mainSelectedIndex = index
            for rawGood in rawGoodArr[index].2 {
                attr.append(rawGood.0)
            }
            self.segmentedDataSource.isTitleColorGradientEnabled = true
        
            self.segmentedDataSource.titles = attr
            self.detailSegmentView.dataSource = self.segmentedDataSource
            self.segmentedDataSource.reloadData(selectedIndex: 0)
            self.detailSegmentView.reloadData()
            self.detailSegmentView.selectItemAt(index: 0)
            if first {
                first = false
                self.segmentedView(self.detailSegmentView, didClickSelectedItemAt: 0)
            }
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let row = indexPath.item
        let vc = GoodDetailTableViewController()
        
        vc.model = self.collectionView.goodModels[row]
        vc.hidesBottomBarWhenPushed = true
        
        navigationController?.pushViewController(vc)
    }
    
    var first = true

}
