//
//  CartTableViewController.swift
//  UUBuy
//
//  Created by Jack on 2019/6/14.
//  Copyright © 2019 com.timi.test.test. All rights reserved.
//

import UIKit
import SnapKit
import SnappingStepper
import SVProgressHUD
import BEMCheckBox

class CartTableViewController: UITableViewController, BEMCheckBoxDelegate {
    
    @objc func checkBoxTap() {
        if !useCouponCheckBox.on {
            self.totalLabel.text = "合计：\(cartModel.total())元"
        } else {
            let amount = CouponManager.shared.show().amount
            self.totalLabel.text = "合计：\(cartModel.total() - amount)元"
        }
        
    }
    
    override func rt_customBackItem(withTarget target: Any!, action: Selector!) -> UIBarButtonItem! {
        let btn = UIButton()
        btn.addTarget(target, action: action, for: .touchUpInside)
        btn.setImage(UIImage(named: "back"), for: .normal)
        return UIBarButtonItem(customView: btn)
    }
    
    override init(style: UITableView.Style) {
        super.init(style: .grouped)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let totalLabel = UILabel()
    var cartModel: CartModel!
    let checkoutBtn = UIButton()
    
    
    let emptyCouponLabel = UILabel()
    let useCouponCheckBox: BEMCheckBox = {
        let checkBox = BEMCheckBox()
        checkBox.onAnimationType = BEMAnimationType.bounce
        checkBox.offAnimationType = BEMAnimationType.bounce
        checkBox.tintColor = .lightGray
        checkBox.onTintColor = orangeColor!
        checkBox.onFillColor = orangeColor!
        checkBox.onCheckColor = .white
        checkBox.addTarget(self, action: #selector(checkBoxTap), for: .valueChanged)
        
        return checkBox
    } ()
    let couponDetailLabel = UILabel()
    
    // 1. 優惠券為空，顯示無優惠券
    // 2. 多張優惠券，先進先出 (FIFO）
    //    可以選取是否使用優惠券
    func updateCoupon() {
        if CouponManager.shared.count == 0 {
            emptyCouponLabel.isHidden = false
            emptyCouponLabel.text = "無優惠券"
            useCouponCheckBox.isHidden = true
            couponDetailLabel.isHidden = true
        } else {
            emptyCouponLabel.isHidden = true
            useCouponCheckBox.isHidden = false
            couponDetailLabel.isHidden = false
            let amount = CouponManager.shared.show().amount
            couponDetailLabel.text = "折扣\(amount)元"
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cartModel = CartModel.shared
        
        tableView.allowsSelection = false
        navigationController?.navigationBar.setBackgroundImage(getGradientImage(width: width, height: 64), for: .default)
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        title = "购物车"
        
        totalLabel.text = "合计：\(cartModel.total())元"
        checkoutBtn.setTitle("结算", for: .normal)
        
        tableView.register(cellWithClass: CartGoodTableViewCell.self)
        tableView.contentInset = UIEdgeInsets(top: 26, left: 0, bottom: 50, right: 0)
        
        
        let fixedView = UIView()
        fixedView.backgroundColor = UIColor(hex: 0xF8F9FF)
        tableView.addSubview(fixedView)
        fixedView.snp.makeConstraints { (make) in
            make.left.equalTo(tableView)
            make.bottom.equalTo(tableView.safeAreaLayoutGuide.snp.bottom)
            make.height.equalTo(50)
            make.width.equalTo(tableView)
        }
        
        totalLabel.font = UIFont.systemFont(ofSize: 14)
        totalLabel.textColor = .black
        fixedView.addSubview(totalLabel)
        totalLabel.snp.makeConstraints { (make) in
            make.center.equalTo(fixedView)
        }
        
        view.addSubview(emptyCouponLabel)
        view.addSubview(useCouponCheckBox)
        view.addSubview(couponDetailLabel)
        emptyCouponLabel.font = UIFont.systemFont(ofSize: 12)
        emptyCouponLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(fixedView)
            make.left.equalTo(fixedView).offset(10)
            make.width.equalTo(200)
        }
        useCouponCheckBox.snp.makeConstraints { (make) in
            make.centerY.equalTo(fixedView)
            make.width.height.equalTo(20)
            make.left.equalTo(fixedView).offset(15)
        }
        couponDetailLabel.font = UIFont.systemFont(ofSize: 12)
        couponDetailLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(fixedView)
            make.left.equalTo(useCouponCheckBox.snp.right).offset(10)
            make.width.equalTo(200)
        }
        updateCoupon()
        
        checkoutBtn.setTitleColor(.white, for: .normal)
        checkoutBtn.setBackgroundImage(getGradientImage(width: 50, height: 100), for: .normal)
        view.addSubview(checkoutBtn)
        checkoutBtn.snp.makeConstraints { (make) in
            make.top.bottom.right.equalTo(fixedView)
            make.width.equalTo(100)
        }
        checkoutBtn.rx.tap.subscribe(onNext: {
            if self.cartModel.total() == 0 {
                SVProgressHUD.showError(withStatus: "购物车为空")
            } else {
                let vc = PayViewController()
                vc.sum = self.cartModel.total()
                if !self.useCouponCheckBox.on {
                    vc.sum = self.cartModel.total()
                } else {
                    let amount = CouponManager.shared.show().amount
                    vc.sum = self.cartModel.total() - amount
                }
                self.navigationController?.pushViewController(vc)
            }
        })
        
    }

    @objc
    func stepperValueChange(sender: AnyObject) {
        // Retrieve the value: stepper.value
        let sender = sender as! SnappingStepper
        let cell = sender.superview as! CartGoodTableViewCell
        let row = cell.row
        let good = cartModel.goodModels[row]
        good.count = Int(sender.value)
        
        //        cartModel.
        self.totalLabel.text = "合计：\(cartModel.total())元"
    }

}

// MARK: - Table view data source
extension CartTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartModel.goodModels.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row

        let cell = tableView.dequeueReusableCell(withClass: CartGoodTableViewCell.self)
        cell.stepper.addTarget(self, action: #selector(stepperValueChange(sender:)), for: .valueChanged)
        let goodModel = cartModel.goodModels[row]
        
        cell.goodImgView.imageURL = URL(string: goodModel.bigImgs[0])
        cell.priceLabel.text = goodModel.price
        cell.goodNameLabel.text = goodModel.name
        cell.row = row
        cell.stepper.value = Double(goodModel.count)
        
        cell.deleteBtn.rx.tap.subscribe(onNext: {
            self.cartModel.removeGood(good: goodModel)
            self.tableView.reloadData()
            self.totalLabel.text = "合计：\(self.cartModel.total())元"
        })
        
        return cell
    }
}
