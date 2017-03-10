//
//  PopoverAnimator.swift
//  RJWeiBo
//
//  Created by ruanjh on 2017/3/9.
//  Copyright © 2017年 app. All rights reserved.
//

import UIKit

class PopoverAnimator: NSObject {

    var isPresented : Bool = false
    var presentedFrame : CGRect = CGRect.zero
    
    var callBack : ((_ presented : Bool)->())?
    
    //如果自定义构造函数 就会覆盖系统默认的init方法
    init(callBack : @escaping (_ presented : Bool)->()) {
        
        self.callBack = callBack
    }
    
}


extension PopoverAnimator : UIViewControllerTransitioningDelegate {
    
    //目的 : 改变弹出view的尺寸
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        
        let presentation = RJPresentationController(presentedViewController: presented, presenting: presenting)
        presentation.presentedFrame = presentedFrame
        
        return presentation
        
    }
    
    // 目的:自定义弹出的动画
    func  animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresented = true
        if let callBack = callBack {
             callBack(isPresented)
        }

        return self
    }
    
    // 目的:自定义消失的动画
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresented = false
        if let callBack = callBack {
            callBack(isPresented)
        }

        return self
    }
    
}


// MARK:- 弹出和消失动画代理的方法
extension PopoverAnimator : UIViewControllerAnimatedTransitioning {
    
    //  动画执行时间
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }

    /// 获取`转场的上下文`:可以通过转场上下文获取弹出的View和消失的View
    // UITransitionContextFromViewKey : 获取消失的View
    // UITransitionContextToViewKey : 获取弹出的View
    func  animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        isPresented ? animationForPresentedView(transitionContext) : animationForDismissedView(transitionContext)
        
    }
    
    //自定义弹出动画
    fileprivate func animationForPresentedView(_ transitionContext: UIViewControllerContextTransitioning) {
        
        //获取弹出的view
        let presentedView = transitionContext.view(forKey: .to)
        
        // 将弹出的view添加到 containerView
        transitionContext.containerView.addSubview(presentedView!)
        
        presentedView?.transform = CGAffineTransform(scaleX: 1.0, y: 0)
        presentedView?.layer.anchorPoint = CGPoint(x: 0.5, y: 0)
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
             presentedView?.transform = CGAffineTransform.identity
        }, completion: { (_) -> Void in
             // 必须告诉转场上下文你已经完成动画
           transitionContext.completeTransition(true)
        })

    }
    
    //自定义消失动画
    fileprivate func animationForDismissedView(_ transitionContext: UIViewControllerContextTransitioning) {
        
        //自定义消失动画
        let dismissView = transitionContext.view(forKey: .from)
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: { 
            dismissView?.transform = CGAffineTransform(scaleX: 1.0, y: 0.001)
            
        }) { (_) in
            transitionContext.completeTransition(true)
        }
        
    }

}
