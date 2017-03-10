//
//  TitleButton.swift
//  RJWeiBo
//
//  Created by ruanjh on 2017/3/9.
//  Copyright © 2017年 app. All rights reserved.
//

import UIKit

class TitleButton: UIButton {

   
    override init(frame: CGRect) {
        super.init(frame: frame)
        setImage(UIImage(named: "navigationbar_arrow_down"), for: .normal)
        setImage(UIImage(named: "navigationbar_arrow_up"), for: .selected)
        setTitleColor(UIColor.black, for: .normal)
        sizeToFit()
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        //let maxX = frame.maxX
        //let maxY = frame.maxY
        titleLabel?.frame.origin.x = 0
        imageView?.frame.origin.x = titleLabel!.frame.maxX + 5 //titleLabel!.frame.width + 5
         //(imageView?.frame)!.maxX + 5
        
        
    }
    

}
