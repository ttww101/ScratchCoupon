//
//  ViewController.swift
//  scratchCoupon
//
//  Created by Jack on 2019/7/1.
//  Copyright © 2019 com. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let observable = Observable<Int>.create { observer in
            // run in background
            return Disposables.create()
        }.observeOn(MainScheduler.instance)
        .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
        .subscribe(onNext: { el in
            // run in main thread
        })
        
//        _ = observable.subscribe(onNext: { (id) in
//            self.navigationItem.title = "福彩宝刮刮乐\(id)"
//        })
        
        // Do any additional setup after loading the view.
//        title = "福彩宝刮刮乐"
        navigationItem.title = "福彩宝刮刮乐"
//        navigationController.title
    }


}

