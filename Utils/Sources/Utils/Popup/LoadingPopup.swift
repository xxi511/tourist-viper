//
//  File.swift
//  
//
//  Created by 陳建佑 on 2020/2/20.
//

import UIKit

public class LoadingPopup: UIView {
    
    public class func show(in parent: UIViewController) {
        if (Thread.isMainThread) {
            LoadingPopup.prepareView(in: parent)
        } else {
            DispatchQueue.main.async {
                LoadingPopup.prepareView(in: parent)
            }
        }
    }
    
    public class func remove(from parent: UIViewController) {
        if (Thread.isMainThread) {
            LoadingPopup.dismissView(from: parent)
        } else {
            DispatchQueue.main.async {
                LoadingPopup.dismissView(from: parent)
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private init() {
        super.init(frame: .zero)
        self.addIndiCator()
        
        let color = UIColor(hexString: "eaeaea")!
        self.backgroundColor = color
        self.setBorder(width: 1, color: color)
        self.setCornerRadius(8)
    }
}

// MARK: Private
extension LoadingPopup {
    class private func isRedundant(parent: UIViewController) -> Bool {
        let subs = parent.view.subviews
        let views = subs.filter({$0 is LoadingPopup})
        return views.count > 0
    }
    
    class private func prepareView(in parent: UIViewController) {
        guard !LoadingPopup.isRedundant(parent: parent) else {return}
        let popup = LoadingPopup()
        popup.translatesAutoresizingMaskIntoConstraints = false
        popup.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        parent.view.addSubview(popup)
        
        popup.centerYAnchor.constraint(equalTo: parent.view.centerYAnchor).isActive = true
        popup.centerXAnchor.constraint(equalTo: parent.view.centerXAnchor).isActive = true
        popup.widthAnchor.constraint(equalToConstant: 128).isActive = true
        popup.heightAnchor.constraint(equalToConstant: 128).isActive = true
        
        UIView.animate(withDuration: 0.4) {
            popup.transform = .identity
        }
    }
    
    class private func dismissView(from parent: UIViewController) {
        let subs = parent.view.subviews
        for view in subs {
            if view is LoadingPopup {
                view.removeFromSuperview()
                break
            }
        }
    }
    
    private func addIndiCator() {
        let indicator = UIActivityIndicatorView(style: .gray)
        indicator.startAnimating()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.transform = CGAffineTransform(scaleX: 2, y: 2)
        self.addSubview(indicator)
        
        indicator.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        indicator.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        indicator.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        indicator.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
    }
}
