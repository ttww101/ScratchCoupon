//
//  HomeLayout.swift
//  UUBuy
//
//  Created by Jack on 2019/6/13.
//  Copyright © 2019 com.timi.test.test. All rights reserved.
//

import UIKit

class HomeLayout: UICollectionViewFlowLayout {

    override func prepare() {
        super.prepare()
        itemSize = CGSize(width: 75, height: 130)
        minimumLineSpacing = 5
        sectionInset = UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0);
        register(DecorationView.self, forDecorationViewOfKind: "decorationView")
    }
    
    override func layoutAttributesForDecorationView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let section = indexPath.section

        let attrs = UICollectionViewLayoutAttributes(forDecorationViewOfKind: "decorationView", with: indexPath)
        if elementKind == "decorationView" {
            if section == 1 {
                attrs.frame = CGRect(x: 5, y: 203 + (width-375)*0.406, width: width - 5 * 2, height: 242)
            } else {
                attrs.frame = CGRect(x: 5, y: 470, width: width - 5 * 2, height: 240)
            }
            attrs.zIndex = -1
        }
        
        return attrs
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var attrs = super.layoutAttributesForElements(in: rect)!
        
        let decorationAttrs = layoutAttributesForDecorationView(ofKind: "decorationView", at: IndexPath(item: 0, section: 1))
        if let decorationAttrs = decorationAttrs {
            if rect.intersects(decorationAttrs.frame) {
                attrs.append(decorationAttrs)
            }
        }
        
        let decorationAttrs1 = layoutAttributesForDecorationView(ofKind: "decorationView", at: IndexPath(item: 0, section: 2))
        decorationAttrs1?.frame = CGRect(x: 5, y: 500 + (width-375)*0.406, width: width - 5 * 2, height: 240)
        if let decorationAttrs1 = decorationAttrs1 {
            if rect.intersects(decorationAttrs1.frame) {
                attrs.append(decorationAttrs1)
            }
        }
        
        return attrs
    }
    
}
