//
//  RJProgressHUD.swift
//  RJWeiBo
//
//  Created by ruanjh on 2017/3/7.
//  Copyright © 2017年 app. All rights reserved.
//

import UIKit
import SVProgressHUD

class RJProgressHUD: NSObject {

    class func setupHD() {
        SVProgressHUD.setDefaultStyle(.custom)
        SVProgressHUD.setForegroundColor(UIColor.white)
        SVProgressHUD.setBackgroundColor(UIColor.init(white: 0.0, alpha: 0.8))
        SVProgressHUD.setFont(UIFont.systemFont(ofSize: 16))
        SVProgressHUD.setMinimumDismissTimeInterval(2.0)
    }
    
    
    class func show() {
        SVProgressHUD.show()
    }
    
    class func showWithStatus(_ status: String) {
        SVProgressHUD.show(withStatus: status)
    }
    
    class func showInfoWithStatus(_ status: String) {
        SVProgressHUD.showInfo(withStatus: status)
    }
    
    class func showSuccessWithStatus(_ status: String) {
        SVProgressHUD.showSuccess(withStatus: status)
    }
    
    class func showErrorWithStatus(_ status: String) {
        SVProgressHUD.showError(withStatus: status)
    }

    
    
    class func dismiss() {
        
        DispatchQueue.main.async { ()-> Void in
            
            SVProgressHUD.dismiss()
            
        }
    }
}
