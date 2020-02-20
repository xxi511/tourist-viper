//
//  AttractionListVC.swift
//  turist
//
//  Created by 陳建佑 on 2020/2/19.
//  Copyright © 2020 陳建佑. All rights reserved.
//

import UIKit
import Models

class AttractionListVC: UIViewController {

    @IBOutlet private var table: UITableView!
    private var presenter: AttractionListPresenterInputProtocol?
    
    private var attractions: [Attraction] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter?.fetchData(isPullToRefresh: true)
    }
    
    func setPresenter(_ presenter: AttractionListPresenterInputProtocol) {
        self.presenter = presenter
    }
}

extension AttractionListVC: AttractionListPresenterOutputProtocol {
    func reloadData(data: [Attraction]) {
        let offset = self.attractions.count
        self.attractions = data
        if (offset == 0) {
            self.table.reloadData()
        } else {
            let paths = (offset..<data.count).map({IndexPath(row: $0, section: 0)})
            self.table.reloadRows(at: paths, with: .automatic)
        }
        
    }
    
    func showLoadingView() {
        
    }
    
    func dismissLoadingView() {
        
    }
    
    
}

extension AttractionListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.attractions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = self.attractions[indexPath.row].info
        return cell
    }
    
    
}
