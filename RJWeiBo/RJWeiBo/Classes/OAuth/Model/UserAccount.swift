//
//  UserAccount.swift
//  RJWeiBo
//
//  Created by ruanjh on 2017/3/8.
//  Copyright © 2017年 app. All rights reserved.
//

import UIKit

class UserAccount: NSObject,NSCoding {

    
    // MARK:- 属性
    /// 授权AccessToken
    var access_token : String?
    /// 过期时间-->秒
    var expires_in : TimeInterval = 0.0 {
        
        didSet {
            expires_date = Date(timeIntervalSinceNow: expires_in)
        }
        
    }
    
    /// 用户ID
    var uid : String?
    
    /// 过期日期
    var expires_date : Date?
    
    /// 昵称
    var screen_name : String?
    
    /// 用户的头像地址
    var avatar_large : String?
    
    init(dict : [String : AnyObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
    
    // MARK:- 属性重写description属性
    override var description: String {
        return dictionaryWithValues(forKeys: ["access_token", "expires_date", "uid", "screen_name", "avatar_large"]).description
    }
    
    
    // MARK:- 归档&解档
    /// 解档的方法
    required init?(coder aDecoder: NSCoder) {
        
        access_token = aDecoder.decodeObject(forKey: "access_token") as? String
        uid = aDecoder.decodeObject(forKey: "uid") as? String
        expires_date = aDecoder.decodeObject(forKey: "expires_date") as? Date
        avatar_large = aDecoder.decodeObject(forKey: "avatar_large") as? String
        screen_name = aDecoder.decodeObject(forKey: "screen_name") as? String
    
    }

        
        
    func encode (with aCoder: NSCoder)  {
        
        aCoder.encode(access_token, forKey: "access_token")
        aCoder.encode(uid, forKey: "uid")
        aCoder.encode(expires_date, forKey: "expires_date")
        aCoder.encode(avatar_large, forKey: "avatar_large")
        aCoder.encode(screen_name, forKey: "screen_name")
        
    }
    
    //ruantime  归档 
    
//    // 归档
//    func encode(with aCoder: NSCoder) {
//        var count: UInt32 = 0
//        guard let ivars = class_copyIvarList(self.classForCoder, &count) else {
//            return
//        }
//        for i in 0 ..< count {
//            let ivar = ivars[Int(i)]
//            let name = ivar_getName(ivar)
//            
//            let key = NSString.init(utf8String: name!) as! String
//            
//            if let value = self.value(forKey: key) {
//                aCoder.encode(value, forKey: key)
//            }
//        }
//        // 释放ivars
//        free(ivars)
//    }
//    
//    // 反归档
//    required init?(coder aDecoder: NSCoder) {
//        super.init()
//        var count: UInt32 = 0
//        guard let ivars = class_copyIvarList(self.classForCoder, &count) else {
//            return
//        }
//        for i in 0 ..< count {
//            let ivar = ivars[Int(i)]
//            let name = ivar_getName(ivar)
//            let key = NSString.init(utf8String: name!) as! String
//            if let value = aDecoder.decodeObject(forKey: key) {
//                self.setValue(value, forKey: key)
//            }
//        }
//        // 释放ivars
//        free(ivars)
//    }
    
    
    
    
    
}
