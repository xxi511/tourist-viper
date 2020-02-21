//
//  ImageCell.swift
//  turist
//
//  Created by 陳建佑 on 2020/2/21.
//  Copyright © 2020 陳建佑. All rights reserved.
//

import UIKit
import Kingfisher

class ImageCell: UICollectionViewCell {
    static let Identifier = "ImageCell"
    static let nib = UINib(nibName: "ImageCell", bundle: Bundle.main)

    @IBOutlet private var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setData(url: URL) {
        self.imageView.kf.setImage(with: url, placeholder: UIImage(named: "defaultImage"), options: nil, progressBlock: nil) { [weak self](result) in
            switch(result) {
            case .success(_):
                return
            case .failure(_):
                self?.imageView.image = UIImage(named: "errorImage")
            }
        }
    }
}
