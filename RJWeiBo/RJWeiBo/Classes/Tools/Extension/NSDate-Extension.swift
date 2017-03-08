//
//  NSDate-Extension.swift
//  DYZB
//
//  Created by 1 on 16/9/19.
//  Copyright © 2016年 小码哥. All rights reserved.
//

import Foundation

/*
 
 
Swift中还定义了static  静态方法，也称为类型方法，所谓“类型”是指枚举、结构体和类。静态方法定义的方法也是与静态属性类似的，枚举和结构体的静态方法使用的关键字是static，类的静态方法使用的关键字是class。

 */

extension Date {
    
    static func getCurrentTime() -> String {
        
        let nowDate = Date()
        
        let interval = Int(nowDate.timeIntervalSince1970)
        
        //QL2("getCurrentTime___\(interval)")
        return "\(interval)"
    }
    
    
}

