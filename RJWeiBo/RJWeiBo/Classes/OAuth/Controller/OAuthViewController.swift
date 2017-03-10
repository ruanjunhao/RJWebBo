//
//  OAuthViewController.swift
//  RJWeiBo
//
//  Created by ruanjh on 2017/3/7.
//  Copyright © 2017年 app. All rights reserved.
//

import UIKit
import SwiftyJSON

class OAuthViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //加载网页
        loadPage()
        title = "授权登录"
    }


}

// MARK:- 设置UI界面
extension OAuthViewController {
    
    func loadPage() {
        
        // 1.获取登录页面的URLString
        let urlString = "https://api.weibo.com/oauth2/authorize?client_id=\(app_key)&redirect_uri=\(redirect_uri)"
        
        guard let url = URL(string : urlString) else {
            RJProgressHUD.showErrorWithStatus("授权地址错误")
            return
        }
        
        //创建urlRequest对象
        let  request = URLRequest(url: url)
        webView.loadRequest(request)
        
    }
}

// MARK:- webView的代理方法
extension OAuthViewController : UIWebViewDelegate {
    // webView开始加载网页
    func webViewDidStartLoad(_ webView: UIWebView) {
        RJProgressHUD.show()
    }
    
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        RJProgressHUD.dismiss()
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        RJProgressHUD.dismiss()
    }
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        guard let url = request.url else {
             return true
        }
        let urlString = url.absoluteString
        
       //判断该字符串是否包含code
        guard  urlString.contains("code=") else {
            return true
        }
        
        //ttp://www.baidu.com/?code=053f5816baa2541a2aa023b384039151💚
        QL2("code==\(urlString)")
        
        let code = urlString.components(separatedBy: "code=").last
        
        if let returncode = code {
            // 5.请求accessToken
            
            UserAccountViewModel.shareInstance.loadAccessToken(code: returncode, finished: { (isSuccessed) in
                
                if isSuccessed {
                    //更新根控制
                    let main =  UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
                    UIApplication.shared.keyWindow?.rootViewController = main
                }else {
                    RJProgressHUD.showErrorWithStatus("登录异常")
                }
                
            })
            return false
        }
        
        return true
        
        
    }
//    
//    func loadAccessToken(_ code : String)  {
//        
//        
//        let urlString = "\(BASE_URL)oauth2/access_token"
//        
//        // 2.获取请求的参数
//        let parameters = ["client_id" : app_key, "client_secret" : app_secret, "grant_type" : "authorization_code", "redirect_uri" : redirect_uri, "code" : code]
//        
//        NetworkTools.shareNetworkTool.post(urlString, parameters: parameters) { (json, error) in
//            
//            if  error != nil  {
//                RJProgressHUD.showErrorWithStatus((error?.localizedDescription)!)
//                return
//            }
//            
//            guard  let accountDict = json as? [String : AnyObject] else {
//                RJProgressHUD.showErrorWithStatus("返回数据为空")
//                return
//            }
//            
//            let account = UserAccount(dict: accountDict)
//            //
//            QL1("accountDict__\(accountDict)")
//            
//           self.loadUserInfo(account)
// 
//        }
//
//        
//    }
//    
//    
//    //请求用户信息
//    fileprivate func loadUserInfo(_ account : UserAccount) {
//        
//        guard let accessToken = account.access_token else {
//            return;
//        }
//        
//        // 2.获取uid
//        guard let uid = account.uid else {
//            return
//        }
//        
//        let urlString = "\(BASE_URL)2/users/show.json"
//        
//        // 2.获取请求的参数
//        let parameters = ["access_token" : accessToken, "uid" : uid]
//        
//        NetworkTools.shareNetworkTool.post(urlString, parameters: parameters) { (json, error ) in
//            
//            if error != nil  {
//                QL4("error__\(error)")
//                return
//            }
//            
//            //拿到用户信息结果
//            guard let userDictJson = json else {
//                return
//            }
//            let userJSON = JSON(userDictJson)
//            account.screen_name = userJSON["screen_name"].string
//            account.avatar_large = userJSON["avatar_large"].string
//            
//            //保存account对象保存
//            NSKeyedArchiver.archiveRootObject(account, toFile: UserAccountViewModel.shareInstance.accountPatch)
//            //将account对象保存到单例中
//            UserAccountViewModel.shareInstance.account = account
//            
//            
//            //更新根控制
//            let main =  UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
//            UIApplication.shared.keyWindow?.rootViewController = main
//
//        }
//        
//        
//        
//    }
    
    
}
