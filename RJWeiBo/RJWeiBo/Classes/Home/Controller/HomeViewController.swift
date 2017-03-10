//
//  HomeViewController.swift
//  RJWeiBo
//
//  Created by ruanjh on 2017/3/9.
//  Copyright © 2017年 app. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    
    fileprivate lazy var titleButton : TitleButton = TitleButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
        
        // Do any additional setup after loading the view.
    }



}

// MARK:-  设置UI界面
extension HomeViewController {
    
    fileprivate func setupNavigationBar() {
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "navigationbar_friendattention")
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(imageName: "navigationbar_pop")
        
        //设置TitleView
        titleButton.setTitle("codeRJ", for: .normal)
        titleButton.addTarget(self, action: #selector(HomeViewController.titleBtnClick(_:)), for: .touchUpInside)
        navigationItem.titleView = titleButton
        
        
    }
    
}

//事件监听
extension HomeViewController {
    
    @objc fileprivate func titleBtnClick(_ titleBtn : TitleButton) {
        
        let popV = PopoverViewController()
        
        //设置控制器的modal的样式
        popV.modalPresentationStyle = .custom
        present(popV, animated: true, completion: nil)
        
    }
    
}
