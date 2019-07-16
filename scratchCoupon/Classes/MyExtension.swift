//
//  MyExtension.swift
//  UUBuy
//
//  Created by Jack on 2019/6/13.
//  Copyright © 2019 com.timi.test.test. All rights reserved.
//

import UIKit
import CommonCrypto

let centerX = UIScreen.main.bounds.width / 2
let centerY = UIScreen.main.bounds.height / 2
let width = UIScreen.main.bounds.width
let height = UIScreen.main.bounds.height

func widthRate(rate: CGFloat) -> CGFloat {
    return width * rate
}

func heightRate(rate: CGFloat) -> CGFloat {
    return height * rate
}

extension UIImageView {
    convenience init(named: String) {
        self.init(image: UIImage(named: named))
    }
}

extension UIColor {
    convenience init(rgb: Int) {
        self.init(
            red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgb & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}

func getGradientImage(width: CGFloat, height: CGFloat) -> UIImage {
    let gradientLayer = CAGradientLayer()
    gradientLayer.frame = CGRect(x: 0, y: 0, width: width, height: height)
    gradientLayer.colors = [UIColor(hex: 0xffbd7a)?.cgColor, UIColor(hex: 0xff8300)?.cgColor]
    gradientLayer.startPoint = CGPoint(x: 0, y: 0)
    gradientLayer.endPoint = CGPoint(x: 0, y: 1)
    UIGraphicsBeginImageContext(gradientLayer.frame.size)
    gradientLayer.render(in: UIGraphicsGetCurrentContext()!)
    let outputImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return outputImage!
}



class TextFieldHelper: UIResponder {
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
}

extension String {
    func md5() -> String {
        let str = self.cString(using: String.Encoding.utf8)
        let strLen = CUnsignedInt(self.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<UInt8>.allocate(capacity: 16)
        CC_MD5(str!, strLen, result)
        let hash = NSMutableString()
        for i in 0 ..< digestLen {
            hash.appendFormat("%02x", result[i])
        }
        free(result)
        return String(format: hash as String)
    }
}
