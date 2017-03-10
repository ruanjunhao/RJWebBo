//
//  RJPresentationController.swift
//  RJWeiBo
//
//  Created by ruanjh on 2017/3/10.
//  Copyright © 2017年 app. All rights reserved.
//

import UIKit

class RJPresentationController: UIPresentationController {

    var presentedFrame : CGRect = CGRect.zero
    
    fileprivate lazy var cover : UIView = UIView()
    override func  containerViewWillLayoutSubviews() {
        
        super.containerViewWillLayoutSubviews()
        
        presentedView?.frame = presentedFrame
        setupCoverView()
        
    }
    
    
}

// MARK:- 设置UI界面相关
extension RJPresentationController {
    
    fileprivate func setupCoverView() {
        
        //添加蒙版
        containerView?.insertSubview(cover, at: 0)
        
        //设置蒙版属性
        cover.backgroundColor = UIColor(white: 0.8, alpha: 0.2)
        cover.frame = containerView!.bounds
        
        //添加手势
        let tapsGes = UITapGestureRecognizer(target: self, action: #selector(RJPresentationController.coverViewClick))
        cover.addGestureRecognizer(tapsGes)
        
    }
}


extension RJPresentationController {
    
    @objc func coverViewClick()  {
        
        presentedViewController.dismiss(animated: true, completion: nil)
    }
}
