//
//  File.swift
//  
//
//  Created by 陳建佑 on 2020/2/20.
//

import UIKit.UIView

public extension UIView {
    func setBorder(width: CGFloat, color: UIColor) {
        self.layer.borderWidth = width
        self.layer.borderColor = color.cgColor
    }
    
    func setCornerRadius(_ radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
}
