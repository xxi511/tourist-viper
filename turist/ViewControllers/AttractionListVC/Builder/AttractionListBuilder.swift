//
//  AttractionListBuilder.swift
//  turist
//
//  Created by 陳建佑 on 2020/2/22.
//  Copyright © 2020 陳建佑. All rights reserved.
//

import Foundation
import UIKit

class AttractionListBuilder {
    
    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
    
    static func createModule() -> UIViewController {
        
        let view = mainStoryboard.instantiateViewController(withIdentifier: "AttractionListVC") as! AttractionListVC
        let router = AttractionListRouter(view: view)
        let interactor = AttractionListInteractor()
        let presenter = AttractionListPresenter(view: view, interactor: interactor, router: router)
        view.configure(presenter: presenter)
        interactor.configure(presenter: presenter)
        
        return view
    }
}
