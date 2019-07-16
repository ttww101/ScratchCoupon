//
//  CollectionViewController.swift
//  UUBuy
//
//  Created by Jack on 2019/6/12.
//  Copyright © 2019 com.timi.test.test. All rights reserved.
//

import UIKit
import Moya
import YYKit
import SVProgressHUD

private let reuseIdentifier = "Cell"
private let goodCellIdentifier = "GoodCollectionViewCell"

class HomeCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    public override func rt_navigationBarClass() -> AnyClass! {
        return MyNavavigationBar.self
    }
    
    let headerText = ["明星单品", "一元竞标"]
    var homeViewModel: HomeViewModel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let provider = MoyaProvider<API>(plugins: [MoyaCacheablePlugin()])
        homeViewModel = HomeViewModel(input: (
                collectionView: collectionView,
                navigationController: navigationController!,
                viewController: self
            ),
          dependency: (
            provider: provider, object: NSObject()
            )
        )
    
        collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView!.register(GoodCollectionViewCell.self, forCellWithReuseIdentifier: goodCellIdentifier)
        collectionView.register(cellWithClass: BannerCollectionViewCell.self)
        
        collectionView.register(supplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withClass: HomeHeaderCollectionReusableView.self)
        
        collectionView.backgroundColor = UIColor(hex: 0xF0F0F0)
        collectionView.dataSource = self
        collectionView.contentInset = UIEdgeInsets(top: 26, left: 0, bottom: 0, right: 0)
    }
 
}

// MARK: UICollectionViewDataSource
extension HomeCollectionViewController {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return 8
        }
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = indexPath.section
        if section == 0 {
            let bannerCell = collectionView.dequeueReusableCell(withClass: BannerCollectionViewCell.self, for: indexPath)
            return bannerCell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: goodCellIdentifier, for: indexPath) as! GoodCollectionViewCell
        
        cell.collectBtn.rx.tap.subscribe(onNext:{
            self.homeViewModel.collectBtnTaped(indexPath: indexPath)
        })
        
        homeViewModel.setupCell(indexPath: indexPath, reuseCell: cell)
        
        return cell
    }
}

extension HomeCollectionViewController {
    // MARK: UICollectionViewDelegate
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        homeViewModel.collectBtnTaped(indexPath: indexPath)
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSize.zero
        }
        return CGSize(width: width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let section = indexPath.section
        if section == 0 {
            return CGSize(width: width, height: width * 0.406)
        }
        return CGSize(width: 70, height: 110)
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withClass: HomeHeaderCollectionReusableView.self, for: indexPath)
        let section = indexPath.section
        header.label.text = headerText[section-1]
        
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section != 0 {
            return UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        } else {
            return UIEdgeInsets.zero
        }
    }
}
