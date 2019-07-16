//
//  NotificationTableViewController.swift
//  UUBuy
//
//  Created by Jack on 2019/6/14.
//  Copyright © 2019 com.timi.test.test. All rights reserved.
//

import UIKit

func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
    let size = image.size
    
    let widthRatio  = targetSize.width  / size.width
    let heightRatio = targetSize.height / size.height
    
    // Figure out what our orientation is, and use that to form the rectangle
    var newSize: CGSize
    if(widthRatio > heightRatio) {
        newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
    } else {
        newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
    }
    
    // This is the rect that we've calculated out and this is what is actually used below
    let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
    
    // Actually do the resizing to the rect using the ImageContext stuff
    UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
    image.draw(in: rect)
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return newImage!
}

class NotificationViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController!.navigationBar.setBackgroundImage(getGradientImage(width: width, height: 64), for: .default)

        title = "通知"
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        view.backgroundColor = UIColor(hex: 0xF0F0F0)
        
        let notificationTableView = NotificationTableView(frame: CGRect.zero, style: .grouped)
        view.addSubview(notificationTableView)
        notificationTableView.snp.makeConstraints { (make) in
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

class NotificationTableView : UITableView, UITableViewDelegate, UITableViewDataSource {
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        register(cellWithClass: NotifcationItemTableViewCell.self)
        register(cellWithClass: NotificationSwitchTableViewCell.self)
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
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1{
            return 2
        }
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section
        if section == 0 {
            let cell = dequeueReusableCell(withClass: NotificationSwitchTableViewCell.self)
            return cell
        }
        
        let cell = dequeueReusableCell(withClass: NotifcationItemTableViewCell.self)
        
        cell.titleLabel.text = "最强活动说明"
        cell.contentLabel.text = "今日下午超級特惠活動即將開始"
        cell.dateLabel.text = "2019_06_09"
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1 {
            let notificationHeader = NotificationHeader()
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

class NotificationHeader: UIView {
    let label = UILabel()
    override init(frame: CGRect) {
        super.init(frame: frame)
        //        backgroundColor = .white
        
        let v = UIView()
        
        //        v.roundCorners([.topRight, .topRight], radius: 10)
        v.backgroundColor = .clear
        v.layer.backgroundColor = UIColor.white.cgColor
        v.layer.cornerRadius = 5
        v.clipsToBounds = true
        addSubview(v)
        v.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(10)
            make.left.right.bottom.equalTo(self)
        }
        
        drawLine(startX: 10, toEndingX: 10, startingY: 14+4, toEndingY: 30+4, ofColor: UIColor(hex: 0xFFC101), widthOfLine: 5, inView: v)
        
        let label = UILabel()
        label.text = "通知"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .black
        addSubview(label)
        
        label.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(20)
            make.centerY.equalTo(self).offset(7)
        }
        
        let pathV = UIView()
        pathV.backgroundColor = .white
        addSubview(pathV)
        pathV.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.bottom).offset(-10)
            make.left.right.bottom.equalTo(self)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
