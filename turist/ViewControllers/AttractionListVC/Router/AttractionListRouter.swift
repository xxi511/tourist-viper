//
//  AttractionListRouter.swift
//  turist
//
//  Created by 陳建佑 on 2020/2/19.
//  Copyright © 2020 陳建佑. All rights reserved.
//

import Foundation
import UIKit

class AttractionListRouter: AttractionListRouterProtocol {
    private weak var view: UIViewController?
    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
    
    init(view: UIViewController) {
        self.view = view
    }
    
    func showAlert(title: String?, message: String?) {
        guard let _view = self.view else {return}
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let checkAction = UIAlertAction(title: "了解", style: .default, handler: nil)
        alert.addAction(checkAction)
        if (Thread.isMainThread) {
            _view.present(alert, animated: true, completion: nil)
        } else {
            DispatchQueue.main.async {
                _view.present(alert, animated: true, completion: nil)
            }
        }
        
    }
}
