//
//  GalleryCollectionViewCell.swift
//  GalleryApp
//
//  Created by user136229 on 2/12/18.
//  Copyright © 2018 Vishal Madheshia. All rights reserved.
//

import UIKit
import SDWebImage

class GalleryCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var imageView: UIImageView!
    
    // MARK: - Properties
    var imageUrl: String = "" {
        didSet {
           setUpImage()
        }
    }
    
    // MARK: - Methods
    
    /// This method sets the image in image view from remote url.
    func setUpImage() {
        let url = URL.init(string: imageUrl)
        imageView.sd_setImage(with: url, placeholderImage: placeHolderImage, options: [], completed: nil)
    }
}
