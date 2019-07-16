//
//  HomeTable.swift
//  scratchCoupon
//
//  Created by Jack on 2019/7/2.
//  Copyright © 2019 com. All rights reserved.
//

import UIKit
import SwifterSwift
import RxCocoa
import RxSwift

let marqueeOrangeColor = UIColor(hex: 0xFF8947)
let marqueeRedColor = UIColor(hex: 0xFF485D)
let marqueeBlueColor = UIColor(hex: 0x54B6F5)

class HomeTable: UITableView {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        dataSource = self
        delegate = self
//        register(nibWithCellClass: ScratchCell.self)
        register(cellWithClass: ScratchCell.self)
        register(cellWithClass: MarqueeCell.self)
    }

}

extension HomeTable: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let section = indexPath.section
        let row = indexPath.row

        if row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "banner")
            return cell!
        } else if row == 1 {
            let cell: ScratchCell = tableView.dequeueReusableCell(withIdentifier: "scratch") as! ScratchCell
            
//            let observer: AnyObserver<Bool> = AnyObserver { [weak self] (event) in
//                switch event {
//                case .next(let isHidden):
//                    self?.usernameValidOutlet.isHidden = isHidden
//                default:
//                    break
//                }
//            }
//            cell.cardBtn1.rx.isEnabled.
            
//            cell.cardBtn1.rx.isEnabled
//            let isEnable1 = Observable<Bool>.just(false).bind(to: cell.cardBtn2.rx.isEnabled)
            
            cell.cardBtn1.isEnabled = !UserStateModel.shared.isUsed1()
            cell.cardBtn2.isEnabled = !UserStateModel.shared.isUsed2()
            cell.cardBtn3.isEnabled = !UserStateModel.shared.isUsed3()
            
            _ = cell.cardBtn1.rx.tap.subscribe(onNext: { (_) in
                let cardVC = CardDetailViewController()
                self.viewController!.navigationController?.pushViewController(cardVC)
                UserStateModel.shared.cardDate1 = Date()
                cell.cardBtn1.isEnabled = false
            })
            _ = cell.cardBtn2.rx.tap.subscribe(onNext: {
                let cardVC = CardDetailViewController()
                cardVC.index = 2
                self.viewController!.navigationController?.pushViewController(cardVC)
                UserStateModel.shared.cardDate2 = Date()
                cell.cardBtn2.isEnabled = false
            })
            _ = cell.cardBtn3.rx.tap.subscribe(onNext: {
                let cardVC = CardDetailViewController()
                cardVC.index = 3
                self.viewController!.navigationController?.pushViewController(cardVC)
                UserStateModel.shared.cardDate3 = Date()
                cell.cardBtn3.isEnabled = false
            })
            
            return cell
        } else if row == 2 {
            let cell = tableView.dequeueReusableCell(withClass: MarqueeCell.self)
            
            return cell
        }
        fatalError()
    }
    
    
}

extension HomeTable: UITableViewDelegate {
    
}
