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
    
    private init(view: UIViewController) {
        self.view = view
    }
    
    class func createModule() -> UIViewController {
        
        let view = mainStoryboard.instantiateViewController(withIdentifier: "AttractionListVC") as! AttractionListVC
        let router = AttractionListRouter(view: view)
        let interactor = AttractionListInteractor()
        let presenter = AttractionListPresenter(view: view, interactor: interactor, router: router)
        view.setPresenter(presenter)
        interactor.setPresenter(presenter)
        
        return view
    }
    
    func showErrorAlert(error: Error) {
        
    }
}
