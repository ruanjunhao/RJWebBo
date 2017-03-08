//
//  OAuthViewController.swift
//  RJWeiBo
//
//  Created by ruanjh on 2017/3/7.
//  Copyright © 2017年 app. All rights reserved.
//

import UIKit

class OAuthViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //加载网页
        loadPage()
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
            loadAccessToken(returncode)
            return false
        }
        
        return true
        
        
    }
    
    func loadAccessToken(_ code : String)  {
        
        
    }
    
    
    
}
