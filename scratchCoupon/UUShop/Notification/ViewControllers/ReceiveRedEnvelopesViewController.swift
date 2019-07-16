//
//  ReceiveRedEnvelopesViewController.swift
//  UUBuy
//
//  Created by Jack on 2019/6/20.
//  Copyright © 2019 com.timi.test.test. All rights reserved.
//

import UIKit

class ReceiveRedEnvelopesViewController: UIViewController {
    override func rt_customBackItem(withTarget target: Any!, action: Selector!) -> UIBarButtonItem! {
        let btn = UIButton()
        btn.addTarget(target, action: action, for: .touchUpInside)
        btn.setImage(UIImage(named: "back"), for: .normal)
        return UIBarButtonItem(customView: btn)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController!.navigationBar.setBackgroundImage(getGradientImage(width: width, height: 64), for: .default)
        title = "领红包"
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        view.backgroundColor = UIColor(hex: 0xF0F0F0)
        
        let receiveRedEnvelopesTableView = ReceiveRedEnvelopesTableView(frame: CGRect.zero, style: .grouped)
        view.addSubview(receiveRedEnvelopesTableView)
        receiveRedEnvelopesTableView.snp.makeConstraints { (make) in
            make.left.equalTo(view).offset(10)
            make.right.equalTo(view).offset(-10)
            make.top.equalTo(view.snp.topMargin)
            make.bottom.equalTo(view.snp.bottom)
        }
        
        let btn = UIButton()
        btn.setImage(UIImage(named: "buy_car"), for: .normal)
        btn.rx.tap.subscribe(onNext: {
            if UserModel.shared.isLogin() {
                let cartTableViewController = CartTableViewController(style: .grouped)
                cartTableViewController.hidesBottomBarWhenPushed = true
                self.navigationController!.pushViewController(cartTableViewController)
            } else {
                LoginView.show()
            }
        })
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: btn)
        
    }
}

class ReceiveRedEnvelopesTableView : UITableView, UITableViewDelegate, UITableViewDataSource {
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        register(cellWithClass: RedECell.self)
        backgroundColor = .clear
        dataSource = self
        delegate = self
        let notificationHeaderView = NotificationHeaderView()
        notificationHeaderView.frame = CGRect(x: 0, y: 0, width: 300, height: 300*0.18+20)
        tableHeaderView = notificationHeaderView
        
        allowsSelection = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section
        let row = indexPath.row
        
        let text = ["7", "15", "20", "28"]
    
        let cell = dequeueReusableCell(withClass: RedECell.self)
        cell.label.text = "签到\(text[row])天可领取"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1 {
            let notificationHeader = NotificationHeader()
            notificationHeader.label.text = "领红包:"
            return notificationHeader
        }
        
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 {
            return 60
        }
        return 10
    }
}




class RedECell: UITableViewCell {
    let label = UILabel()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        let imgView = UIImageView(named: "open")
        addSubview(imgView)
        imgView.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(15)
            make.centerY.equalTo(self)
        }
        
        label.text = "签到天可领取"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .black
        addSubview(label)
        label.snp.makeConstraints { (make) in
            make.left.equalTo(imgView.snp.right).offset(5)
            make.centerY.equalTo(self)
        }
        
        let btn = UIButton()
        btn.setTitle("未领取", for: .normal)
        btn.setTitleColor(UIColor(hex: 0x9A9A9A), for: .normal)
        btn.titleLabel!.font = UIFont.systemFont(ofSize: 14)
        btn.backgroundColor = UIColor(hex: 0xF2F2F2)
        btn.layer.cornerRadius = 3
        btn.clipsToBounds = true
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor(hex: 0x9A9A9A).cgColor
        btn.layer.cornerRadius = 2
        btn.clipsToBounds = true
        addSubview(btn)
        btn.snp.makeConstraints { (make) in
            make.right.equalTo(self).offset(-15)
            make.centerY.equalTo(self)
            make.size.equalTo(CGSize(width: 70, height: 30))
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
