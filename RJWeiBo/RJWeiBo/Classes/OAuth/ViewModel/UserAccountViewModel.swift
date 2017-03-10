//
//  OAuthViewModel.swift
//  RJWeiBo
//
//  Created by ruanjh on 2017/3/8.
//  Copyright © 2017年 app. All rights reserved.
//

import UIKit

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
