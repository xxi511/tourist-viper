//
//  File.swift
//  
//
//  Created by 陳建佑 on 2020/2/20.
//

import UIKit

public class LoadingPopup: UIView {
    
    public static func show(in parent: UIViewController) {
        if (Thread.isMainThread) {
            LoadingPopup.prepareView(in: parent)
        } else {
            DispatchQueue.main.async {
                LoadingPopup.prepareView(in: parent)
            }
        }
    }
    
    public static func remove(from parent: UIViewController) {
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
        let bgView = self.createBackgroundView()
        self.addIndiCatorAt(bgView)
    }
}

// MARK: Private
extension LoadingPopup {
    static private func isRedundant(parent: UIViewController) -> Bool {
        let subs = parent.view.subviews
        let views = subs.filter({$0 is LoadingPopup})
        return views.count > 0
    }
    
    static private func prepareView(in parent: UIViewController) {
        guard !LoadingPopup.isRedundant(parent: parent) else {return}
        let popup = LoadingPopup()
        popup.translatesAutoresizingMaskIntoConstraints = false
        popup.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        parent.view.addSubview(popup)
        
        popup.topAnchor.constraint(equalTo: parent.view.topAnchor).isActive = true
        popup.leadingAnchor.constraint(equalTo: parent.view.leadingAnchor).isActive = true
        popup.trailingAnchor.constraint(equalTo: parent.view.trailingAnchor).isActive = true
        popup.bottomAnchor.constraint(equalTo: parent.view.bottomAnchor).isActive = true
        
        UIView.animate(withDuration: 0.4) {
            popup.transform = .identity
        }
    }
    
    static private func dismissView(from parent: UIViewController) {
        let _ = parent.view.subviews
            .filter {$0 is LoadingPopup}
            .map {$0.removeFromSuperview()}
    }
    
    private func addIndiCatorAt(_ bgView: UIView) {
        let indicator = UIActivityIndicatorView(style: .gray)
        indicator.startAnimating()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.transform = CGAffineTransform(scaleX: 2, y: 2)
        bgView.addSubview(indicator)
        
        indicator.centerXAnchor.constraint(equalTo: bgView.centerXAnchor).isActive = true
        indicator.centerYAnchor.constraint(equalTo: bgView.centerYAnchor).isActive = true
        indicator.widthAnchor.constraint(equalTo: bgView.widthAnchor).isActive = true
        indicator.heightAnchor.constraint(equalTo: bgView.heightAnchor).isActive = true
    }
    
    private func createBackgroundView() -> UIView {
        let bgView = UIView()
        bgView.translatesAutoresizingMaskIntoConstraints = false
        let color = UIColor(hexString: "eaeaea")!
        bgView.backgroundColor = color
        bgView.setBorder(width: 1, color: color)
        bgView.setCornerRadius(8)
        self.addSubview(bgView)
        
        bgView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        bgView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        bgView.widthAnchor.constraint(equalToConstant: 128).isActive = true
        bgView.heightAnchor.constraint(equalToConstant: 128).isActive = true
        return bgView
    }
}
