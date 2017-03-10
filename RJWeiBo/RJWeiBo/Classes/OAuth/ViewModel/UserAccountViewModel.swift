//
//  OAuthViewModel.swift
//  RJWeiBo
//
//  Created by ruanjh on 2017/3/8.
//  Copyright © 2017年 app. All rights reserved.
//

import UIKit
import SwiftyJSON
/**
 模型通常继承自 NSObject -> 可以使用 KVC 设置属性，简化对象构造
 如果没有父类，所有的内容，都需要从头创建，量级更轻
 
 视图模型的作用：封装`业务逻辑`，通常没有复杂的属性
 
 
 Swift中可以允许对象没有任何父类，相比较NSObject更加轻量级
 NSObject本身有一个 isa 指针，支持 kvc 以及动态转发消息
 但是没有任何父类的这些都不支持了
 是最纯洁的类
 
 
 */


class UserAccountViewModel: NSObject {


    static let shareInstance : UserAccountViewModel =  UserAccountViewModel()
    
    //定义属性
    var account : UserAccount?
    
    //计算属性
    var accountPatch : String  {
        
        let accountPatch = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        
        return (accountPatch as NSString).appendingPathComponent("account.plist")
    }
    
    
    
    
    var isLogin : Bool {
        
        if account == nil {
            return false
        }
        
        guard let expireDate = account?.expires_date else {
            return false
        }
        return expireDate.compare(Date()) == .orderedDescending

    }

    
    // 重新init（）函数 初始化的时候 读取存取的账号信息
    override init() {
        super.init()
        account = NSKeyedUnarchiver.unarchiveObject(withFile: accountPatch) as? UserAccount
    }
    
    
}


// MARK:- 用户相关的网络方法
extension UserAccountViewModel {
    
    func loadAccessToken(code : String ,finished : @escaping (_ isSuccessed : Bool)->()) {
        
        let urlString = "\(BASE_URL)oauth2/access_token"
        
        // 2.获取请求的参数
        let parameters = ["client_id" : app_key, "client_secret" : app_secret, "grant_type" : "authorization_code", "redirect_uri" : redirect_uri, "code" : code]
        
        NetworkTools.shareNetworkTool.post(urlString, parameters: parameters) { (json, error) in
            
            if  error != nil  {
                RJProgressHUD.showErrorWithStatus((error?.localizedDescription)!)
                 finished(false)
                return
            }
            
            guard  let accountDict = json as? [String : AnyObject] else {
                RJProgressHUD.showErrorWithStatus("返回数据为空")
                 finished(false)
                return
            }
            
            let account = UserAccount(dict: accountDict)
            //
            QL1("accountDict__\(accountDict)")
            
            self.loadUserInfo(account,finished: finished)
            
        }

        
        
    }
    

    
    
    //请求用户信息
    fileprivate func loadUserInfo(_ account : UserAccount,finished : @escaping (_ isSuccessed : Bool)->()) {
        
        guard let accessToken = account.access_token else {
             finished(false)
            return;
        }
        
        // 2.获取uid
        guard let uid = account.uid else {
             finished(false)
            return
        }
        
        let urlString = "\(BASE_URL)2/users/show.json"
        
        // 2.获取请求的参数
        let parameters = ["access_token" : accessToken, "uid" : uid]
        
        NetworkTools.shareNetworkTool.post(urlString, parameters: parameters) { (json, error ) in
            
            if error != nil  {
                 finished(false)
                QL4("error__\(error)")
                return
            }
            
            //拿到用户信息结果
            guard let userDictJson = json else {
                 finished(false)
                return
            }
            let userJSON = JSON(userDictJson)
            account.screen_name = userJSON["screen_name"].string
            account.avatar_large = userJSON["avatar_large"].string
            
            //保存account对象保存
            NSKeyedArchiver.archiveRootObject(account, toFile: UserAccountViewModel.shareInstance.accountPatch)
            //将account对象保存到单例中
            UserAccountViewModel.shareInstance.account = account
            
            finished(true)
            
//            //更新根控制
//            let main =  UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
//            UIApplication.shared.keyWindow?.rootViewController = main
            
        }
        
        
        
    }
    
    
}
