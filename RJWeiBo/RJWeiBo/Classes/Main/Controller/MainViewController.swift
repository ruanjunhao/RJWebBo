//
//  MainViewController.swift
//  RJWeiBo
//
//  Created by ruanjh on 2017/3/9.
//  Copyright © 2017年 app. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {
 
    // MARK: 懒加载属性
    
    fileprivate lazy var composeBtn : UIButton  = UIButton(imageName: "tabbar_compose_icon_add", bgImageName: "tabbar_compose_button")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupComposeBtn()
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBar.bringSubview(toFront: composeBtn)
    }
    

}

// MARK:- 设置UI界面
extension MainViewController {
    //设置发布按钮
    fileprivate func setupComposeBtn() {
        
       
        tabBar.addSubview(composeBtn)
        
        //设置位置
        composeBtn.center = CGPoint(x: tabBar.center.x , y: tabBar.frame.size.height * 0.5)
        
        composeBtn.addTarget(self, action: #selector(MainViewController.composeBtnClick), for: .touchUpInside)
        
        

    }
    
}

// MARK:- 事件监听
extension MainViewController {
    @objc fileprivate func composeBtnClick() {
         QL1("setupComposeBtn")
        // 1.创建发布控制器
        let composeVc = ComposeViewController()
        
        // 2.包装导航控制器
        let composeNav = UINavigationController(rootViewController: composeVc)
        
        // 3.弹出控制器
        present(composeNav, animated: true, completion: nil)
    }
}


