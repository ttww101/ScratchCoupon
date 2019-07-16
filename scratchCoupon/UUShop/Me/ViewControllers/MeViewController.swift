//
//  MeViewController.swift
//  UUBuy
//
//  Created by Jack on 2019/6/13.
//  Copyright © 2019 com.timi.test.test. All rights reserved.
//

import UIKit
import SnapKit
import SVProgressHUD

class MeViewController: ViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        nameLabel.text = UserModel.shared.isLogin() ? "登入用户" : "游客"
//        emailLabel.text = UserModel.shared.email
        if UserModel.shared.isLogin() {
            logoutBtn.setTitle("退出登入", for: .normal)
        } else {
            logoutBtn.setTitle("登入", for: .normal)
        }
        
    }
    let logoutBtn = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let timer = Timer(timeInterval: 1, repeats: true) { _ in
//            self.nameLabel.text = UserModel.shared.isLogin() ? "登入用户" : "游客"
//            self.emailLabel.text = UserModel.shared.email
            if UserModel.shared.isLogin() {
                self.logoutBtn.setTitle("退出登入", for: .normal)
            } else {
                self.logoutBtn.setTitle("登入", for: .normal)
            }
        }
        
        RunLoop.current.add(timer, forMode: .default)
        timer.fire()
//        navigationController!.navigationBar.setColors(background: .clear, text: .white)
        navigationController!.navigationBar.setBackgroundImage(getGradientImage(width: width, height: 64), for: .default)
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
        
        view.backgroundColor = grayColor
//        let navImageView = UIImageView(image: getGradientImage(width: width, height: 100))
//        navImageView.frame = CGRect(x: 0, y: -0, width: width, height: 175)
//        view.addSubview(navImageView)
        
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationItem.title = "个人"
        
//        let avatarImgView = UIImageView(named: "avatar")
//        view.addSubview(avatarImgView)
//
//        avatarImgView.snp.makeConstraints { (make) in
//
//            make.top.equalTo(view.snp.topMargin).offset(10)
//            make.left.equalTo(view).offset(10)
//            make.width.height.equalTo(70)
//        }
//        avatarImgView.layer.borderColor = UIColor.white.cgColor
//        avatarImgView.layer.borderWidth = 2
//        avatarImgView.layer.cornerRadius = 35
//        avatarImgView.clipsToBounds = true
        
//        nameLabel.text = UserModel.shared.isLogin() ? "登入用户" : "游客"
//        nameLabel.font = UIFont.systemFont(ofSize: 18)
//        nameLabel.textColor = .white
//        view.addSubview(nameLabel)
//        nameLabel.snp.makeConstraints { (make) in
//            make.top.equalTo(view.snp.topMargin).offset(25)
//            make.left.equalTo(avatarImgView.snp.right).offset(10)
//            make.right.equalTo(view)
//        }
        
        
//        emailLabel.text = UserModel.shared.email
//        emailLabel.font = UIFont.systemFont(ofSize: 18)
//        emailLabel.textColor = .white
//        view.addSubview(emailLabel)
//        emailLabel.snp.makeConstraints { (make) in
//            make.top.equalTo(nameLabel.snp.bottom).offset(10)
//            make.left.equalTo(nameLabel)
//            make.right.equalTo(view)
//        }
//
//
//        meTableView.layer.cornerRadius = 10
//        meTableView.clipsToBounds = true
//        meTableView.nav = navigationController
//        meTableView.tableFooterView = UIView()
//        view.addSubview(meTableView)
        
        if UserModel.shared.isLogin() {
            logoutBtn.setTitle("退出登入", for: .normal)
        } else {
            logoutBtn.setTitle("登入", for: .normal)
        }
        
        logoutBtn.setTitleColor(.black, for: .normal)
        logoutBtn.backgroundColor = .white
        logoutBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        logoutBtn.layer.cornerRadius = 5
        logoutBtn.clipsToBounds = true
        view.addSubview(logoutBtn)
        logoutBtn.snp.makeConstraints { (make) in
            make.left.right.equalTo(view)
            make.bottom.equalTo(view.snp.bottomMargin).offset(-10)
            make.height.equalTo(45)
        }
        logoutBtn.layer.masksToBounds = false
        logoutBtn.layer.shadowColor = UIColor.gray.cgColor
        logoutBtn.layer.shadowOffset = CGSize(width: 1, height: 1)
        logoutBtn.layer.shadowRadius = 2
        logoutBtn.layer.shadowOpacity = 0.2
        logoutBtn.rx.tap.subscribe(onNext: {
            if UserModel.shared.isLogin() {
                let controller = UIAlertController(title: "确认登出", message: "是否要登出", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "好的", style: .default) { (_) in
                    UserModel.shared.logout()
                    SVProgressHUD.showInfo(withStatus: "登出成功")
//                    self.nameLabel.text = UserModel.shared.isLogin() ? "登入用户" : "游客"
//                    self.emailLabel.text = UserModel.shared.email
                    self.logoutBtn.setTitle("登入", for: .normal)
                }
                controller.addAction(okAction)
                let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
                controller.addAction(cancelAction)
                self.present(controller, animated: true, completion: nil)
            } else {
                LoginView.show()
            }
        })
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
