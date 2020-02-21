//
//  AttractionCell.swift
//  turist
//
//  Created by 陳建佑 on 2020/2/20.
//  Copyright © 2020 陳建佑. All rights reserved.
//

import UIKit
import Models

class AttractionCell: UITableViewCell {
    
    static let Identifier = "AttractionCell"
    static let nib = UINib(nibName: "AttractionCell", bundle: Bundle.main)

    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var descLabel: UILabel!
    @IBOutlet private var collectionView: UICollectionView!
    private var images: [URL] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.collectionView.dataSource = self
        self.collectionView.register(ImageCell.nib,
                                     forCellWithReuseIdentifier: ImageCell.Identifier)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.titleLabel.text = ""
        self.descLabel.text = ""
        self.images = []
    }
    
    func setData(_ attraction: Attraction) {
        self.titleLabel.text = attraction.stitle
        self.descLabel.text = attraction.xbody
        self.images = attraction.files
        self.collectionView.reloadData()
    }
}

extension AttractionCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCell.Identifier, for: indexPath) as! ImageCell
        cell.setData(url: self.images[indexPath.row])
        return cell
    }
    
    
}
