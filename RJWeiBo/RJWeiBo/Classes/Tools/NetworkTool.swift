//
//  NetworkTools.swift
//  RJWeiBo
//
//  Created by ruanjh on 2017/3/7.
//  Copyright © 2017年 app. All rights reserved.
//

import UIKit
import Alamofire
//import SwiftyJSON



//请求响应状态
//enum RJResponseStatus : Int {
//    case success = 0
//    case failure = 1
//}

//typealias NetworkFinished = (_ status : RJResponseStatus, _ result : JSON?,_ error : Error? ) -> ()

typealias NetworkFinished = (_ result : AnyObject?,_ error : Error? ) -> ()


class NetworkTools: NSObject {

    static let shareNetworkTool = NetworkTools()
    
}

// MARK: - 基础请求方法
extension NetworkTools {
    
    /**
     GET请求
     
     - parameter URLString:  urlString
     - parameter parameters: 参数
     - parameter finished:   完成回调
     */
    func get(_ APIString : String, parameters : [String : Any]?, finished : @escaping NetworkFinished)  {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        Alamofire.request(APIString, method: .get, parameters: parameters).responseJSON { (response) in
            self.handle(response: response, finished: finished)
        }
    }
    
    /**
     POST请求
     
     - parameter URLString:  urlString
     - parameter parameters: 参数
     - parameter finished:   完成回调
     (_ result : JSON?,_ error : Error? ) -> ()
     */
    func post(_ APIString: String, parameters: [String : Any]?, finished: @escaping NetworkFinished) {
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        //        print("APIString = \(APIString)")
        Alamofire.request(APIString, method: .post, parameters: parameters, headers: nil).responseJSON { (response) in
            self.handle(response: response, finished: finished)
        }
    }
    
    /// 处理响应结果
    ///
    /// - Parameters:
    ///   - response: 响应对象
    ///   - finished: 完成回调
     func handle(response : DataResponse<Any>, finished : @escaping NetworkFinished) {
         UIApplication.shared.isNetworkActivityIndicatorVisible = false
        switch response.result {
        case .success(let value):
            let json = value as AnyObject
            finished(json, nil)
        case .failure(let error):
            finished(nil, error)
    }
    
    
}

}
