//
//  AttractionListVC.swift
//  turist
//
//  Created by 陳建佑 on 2020/2/19.
//  Copyright © 2020 陳建佑. All rights reserved.
//

import Foundation
import UIKit
import Models
import Utils

class AttractionListVC: UIViewController {

    @IBOutlet private var table: UITableView!
    private var refresher: UIRefreshControl?
    private var presenter: AttractionListPresenterInputProtocol?
    
    private var attractions: [Attraction] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.fetchNewData()
    }
    
    func configure(presenter: AttractionListPresenterInputProtocol) {
        self.presenter = presenter
    }
}

// MARK: Private
extension AttractionListVC {
    private func setupUI() {
        self.setupTopBar()
        self.setupRefresher()
        self.setupTableView()
    }
    
    private func setupTopBar() {
        self.title = "台北市熱門景點"
    }
    
    private func setupTableView() {
        self.table.tableFooterView = UIView(frame: .zero)
        self.table.register(AttractionCell.nib,
                            forCellReuseIdentifier: AttractionCell.Identifier)
        self.table.addSubview(self.refresher!)
    }
    
    private func setupRefresher()  {
        self.refresher = UIRefreshControl()
        self.refresher!.addTarget(self, action: #selector(AttractionListVC.fetchNewData), for: .valueChanged)
    }
    
    @objc private func fetchNewData() {
        self.attractions = []
        self.presenter?.fetchData(isPullToRefresh: true)
    }
}

extension AttractionListVC: AttractionListPresenterOutputProtocol {
    func reloadData(data: [Attraction]) {
        DispatchQueue.main.async {
            self.attractions = data
            self.table.reloadData()
        }
    }
    
    func insertData(data: [Attraction]) {
        DispatchQueue.main.async {
            let start = self.attractions.count
            self.attractions.append(contentsOf: data)
            let end = self.attractions.count
            let paths = Array(start..<end).map({IndexPath(row: $0, section: 0)})
            self.table.beginUpdates()
            self.table.insertRows(at: paths, with: .automatic)
            self.table.endUpdates()
        }
    }
    
    func showLoadingView() {
        DispatchQueue.main.async {
            LoadingPopup.show(in: self)
        }
    }
    
    func dismissLoadingView() {
        DispatchQueue.main.async {
            LoadingPopup.remove(from: self)
            self.refresher?.endRefreshing()
        }
    }
}

extension AttractionListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.attractions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AttractionCell.Identifier) as! AttractionCell
        cell.setData(self.attractions[indexPath.row])
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let height = scrollView.frame.size.height
        let contentYoffset = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if height + contentYoffset > contentHeight && contentYoffset > 0 {
            presenter?.fetchData(isPullToRefresh: false)
        }
    }
}
