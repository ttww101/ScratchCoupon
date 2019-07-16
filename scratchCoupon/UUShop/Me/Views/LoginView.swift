//
//  LoginView.swift
//  UUBuy
//
//  Created by Jack on 2019/6/18.
//  Copyright © 2019 com.timi.test.test. All rights reserved.
//

import UIKit
import SVProgressHUD

class LoginView: UIView {
    
    static let window = UIWindow()
    static func show() {
        window.isHidden = false
        window.backgroundColor = UIColor(white: 0.1, alpha: 0.5)
        window.windowLevel = UIWindow.Level.alert + 1
        window.makeKeyAndVisible()
        let btn = UIButton()
        btn.backgroundColor = .clear
        window.addSubview(btn)
        btn.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalTo(window)
        }
        btn.rx.tap.subscribe(onNext: {
            window.isHidden = true
        })
        
        
        let loginView = LoginView()
        window.addSubview(loginView)
        loginView.snp.makeConstraints { (make) in
            make.width.equalTo(300)
            make.height.equalTo(320)
            make.centerX.equalTo(window)
            make.centerY.equalTo(window).offset(-90)
        }
    }
    
    static func dismiss() {
        window.isHidden = true
    }
    
    var isLogin = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layer.borderWidth = 4
        layer.borderColor = orangeColor?.cgColor
        layer.cornerRadius = 10
        clipsToBounds = true
        
        setup()
        
    }
    
    @objc func doneWithNumberPad() {
        UIApplication.shared.sendAction(#selector(resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    func textFieldToolBar() -> UIToolbar {
        let textFieldToolbar = UIToolbar(frame:CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        textFieldToolbar.barStyle = .default
        textFieldToolbar.items = [
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneWithNumberPad))]
        textFieldToolbar.sizeToFit()
        return textFieldToolbar
    }
    
    func setup() {
        let segLoginBtn = UIButton()
        segLoginBtn.setTitle("登入", for: .normal)
        addSubview(segLoginBtn)
        segLoginBtn.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(20)
            make.centerX.equalTo(self).offset(-30)
        }
        
        let segRegisterBtn = UIButton()
        segRegisterBtn.setTitle("注册", for: .normal)
        addSubview(segRegisterBtn)
        segRegisterBtn.snp.makeConstraints { (make) in
            make.centerY.equalTo(segLoginBtn)
            make.centerX.equalTo(self).offset(30)
        }
        
        let callback = {
            self.isLogin = !self.isLogin
            self.removeAllSubviews()
            self.setup()
        }
        segLoginBtn.rx.tap.subscribe(onNext: callback)
        segRegisterBtn.rx.tap.subscribe(onNext: callback)
        
        if isLogin {
            segLoginBtn.setTitleColor(.black, for: .normal)
            segLoginBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
            segRegisterBtn.setTitleColor(.gray, for: .normal)
            segRegisterBtn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
            
            let userNameTextField = LoginTextField()
            userNameTextField.placeholder = "请输入用户邮箱"
            userNameTextField.contentMode = .scaleAspectFit
            userNameTextField.font = UIFont.systemFont(ofSize: 12)
            userNameTextField.inputAccessoryView = textFieldToolBar()
            addSubview(userNameTextField)
            userNameTextField.snp.makeConstraints { (make) in
                make.centerX.equalTo(self)
                make.top.equalTo(segLoginBtn.snp.bottom).offset(20)
                make.width.equalTo(250)
                make.height.equalTo(40)
            }
            
            let userNameIconView = UIImageView(named: "buy_mbmail")
            userNameIconView.contentMode = .scaleAspectFit
            userNameTextField.addSubview(userNameIconView)
            userNameIconView.snp.makeConstraints { (make) in
                make.centerY.equalTo(userNameTextField)
                make.left.equalTo(userNameTextField).offset(5)
                make.size.equalTo(CGSize(width: 20, height: 20))
            }
            
            let passwordTextField = LoginTextField()
            passwordTextField.placeholder = "请输入密码"
            passwordTextField.font = UIFont.systemFont(ofSize: 12)
            passwordTextField.isSecureTextEntry = true
            passwordTextField.inputAccessoryView = textFieldToolBar()
            addSubview(passwordTextField)
            passwordTextField.snp.makeConstraints { (make) in
                make.centerX.equalTo(self)
                make.top.equalTo(userNameTextField.snp.bottom).offset(20)
                make.size.equalTo(userNameTextField)
            }
            
            
            let passwordIconView = UIImageView(named: "buy_mblock")
            addSubview(passwordIconView)
            passwordIconView.snp.makeConstraints { (make) in
                make.centerY.equalTo(passwordTextField)
                make.left.equalTo(passwordTextField).offset(5)
                make.size.equalTo(CGSize(width: 20, height: 20))
            }
            
            let forgetPasswordBtn = UIButton()
            forgetPasswordBtn.setTitle("忘记密码", for: .normal)
            forgetPasswordBtn.setTitleColor(.gray, for: .normal)
            forgetPasswordBtn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
            addSubview(forgetPasswordBtn)
            forgetPasswordBtn.snp.makeConstraints { (make) in
                make.right.equalTo(passwordTextField)
                make.top.equalTo(passwordTextField.snp.bottom).offset(5)
            }
            
            let loginBtn = UIButton()
            loginBtn.setTitle("登入", for: .normal)
            loginBtn.setTitleColor(.white, for: .normal)
            loginBtn.backgroundColor = orangeColor
            loginBtn.layer.cornerRadius = 10
            loginBtn.clipsToBounds = true
            loginBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            addSubview(loginBtn)
            loginBtn.snp.makeConstraints { (make) in
                make.centerX.equalTo(self)
                make.bottom.equalTo(self).offset(-30)
                make.width.equalTo(userNameTextField)
                make.height.equalTo(userNameTextField).offset(-5)
            }
            loginBtn.rx.tap.subscribe(onNext: {
                if userNameTextField.text! == "" || passwordTextField.text! == "" {
                    SVProgressHUD.showError(withStatus: "帳號或密碼不能為空")
                } else if !isValidEmail(testStr: userNameTextField.text!) {
                    SVProgressHUD.showError(withStatus: "無效 email")
                }  else if passwordTextField.text!.count < 6 {
                    SVProgressHUD.showError(withStatus: "密碼過短")
                } else {
                    if UserModel.shared.login(email: userNameTextField.text!, password: passwordTextField.text!) {
                        SVProgressHUD.showInfo(withStatus: "登入成功")
                        LoginView.dismiss()
                    } else {
                        SVProgressHUD.showInfo(withStatus: "帐号或密码错误")
                    }
                    
                    
                    
                }
                
            })
        } else {
            segLoginBtn.setTitleColor(.gray, for: .normal)
            segLoginBtn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
            segRegisterBtn.setTitleColor(.black, for: .normal)
            segRegisterBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
            
            let userNameTextField = UITextField()
            userNameTextField.placeholder = "请输入用户邮箱"
            userNameTextField.contentMode = .scaleAspectFit
            userNameTextField.backgroundColor = grayColor
            userNameTextField.font = UIFont.systemFont(ofSize: 12)
            userNameTextField.textAlignment = .center
            userNameTextField.inputAccessoryView = textFieldToolBar()
            addSubview(userNameTextField)
            userNameTextField.snp.makeConstraints { (make) in
                make.centerX.equalTo(self)
                make.top.equalTo(segLoginBtn.snp.bottom).offset(10)
                make.width.equalTo(250)
                make.height.equalTo(40)
            }
            
            
            let passwordTextField = UITextField()
            passwordTextField.placeholder = "请输入密码"
            passwordTextField.font = UIFont.systemFont(ofSize: 12)
            passwordTextField.backgroundColor = grayColor
            passwordTextField.isSecureTextEntry = true
            passwordTextField.textAlignment = .center
            passwordTextField.inputAccessoryView = textFieldToolBar()
            addSubview(passwordTextField)
            passwordTextField.snp.makeConstraints { (make) in
                make.centerX.equalTo(self)
                make.top.equalTo(userNameTextField.snp.bottom).offset(10)
                make.size.equalTo(userNameTextField)
            }
            
            let comfirmPasswordTextField = UITextField()
            comfirmPasswordTextField.placeholder = "确认密码"
            comfirmPasswordTextField.font = UIFont.systemFont(ofSize: 12)
            comfirmPasswordTextField.backgroundColor = grayColor
            comfirmPasswordTextField.isSecureTextEntry = true
            comfirmPasswordTextField.textAlignment = .center
            comfirmPasswordTextField.inputAccessoryView = textFieldToolBar()
            addSubview(comfirmPasswordTextField)
            comfirmPasswordTextField.snp.makeConstraints { (make) in
                make.centerX.equalTo(self)
                make.top.equalTo(passwordTextField.snp.bottom).offset(10)
                make.size.equalTo(userNameTextField)
            }
            
            let addressTextField = UITextField()
            addressTextField.placeholder = "计送地址"
            addressTextField.font = UIFont.systemFont(ofSize: 12)
            addressTextField.backgroundColor = UIColor(hex: 0xFFE5C4)
            addressTextField.textAlignment = .center
            addressTextField.inputAccessoryView = textFieldToolBar()
            addSubview(addressTextField)
            addressTextField.snp.makeConstraints { (make) in
                make.centerX.equalTo(self)
                make.top.equalTo(comfirmPasswordTextField.snp.bottom).offset(10)
                make.size.equalTo(userNameTextField)
            }
            
            let registerBtn = UIButton()
            registerBtn.setTitle("注册", for: .normal)
            registerBtn.setTitleColor(.white, for: .normal)
            registerBtn.backgroundColor = orangeColor
            registerBtn.layer.cornerRadius = 10
            registerBtn.clipsToBounds = true
            registerBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            addSubview(registerBtn)
            registerBtn.snp.makeConstraints { (make) in
                make.centerX.equalTo(self)
                make.bottom.equalTo(self).offset(-15)
                make.width.equalTo(userNameTextField)
                make.height.equalTo(userNameTextField).offset(-5)
            }
            
            registerBtn.rx.tap.subscribe(onNext: {
                if userNameTextField.text! == "" || passwordTextField.text! == "" || comfirmPasswordTextField.text! == "" || addressTextField.text! == "" {
                    SVProgressHUD.showError(withStatus: "輸入欄位不能為空")
                } else if !isValidEmail(testStr: userNameTextField.text!) {
                    SVProgressHUD.showError(withStatus: "無效 email")
                } else if passwordTextField.text!.count < 6 {
                    SVProgressHUD.showError(withStatus: "密碼過短")
                } else if passwordTextField.text! != comfirmPasswordTextField.text! {
                    SVProgressHUD.showError(withStatus: "密碼與確認密碼不相同")
                } else {
                    if UserModel.shared.register(email: userNameTextField.text!, password: passwordTextField.text!, address: addressTextField.text!) {
                        SVProgressHUD.showInfo(withStatus: "註冊成功")
                        LoginView.dismiss()
                    } else {
                        SVProgressHUD.showInfo(withStatus: "註冊失敗")
                    }
                    
                }
                
            })
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class LoginTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = grayColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 35, dy: 0)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 35, dy: 0)
    }
}

func isValidEmail(testStr:String) -> Bool {
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    
    let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailTest.evaluate(with: testStr)
}
