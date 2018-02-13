//
//  CarouselViewController.swift
//  GalleryApp
//
//  Created by user136229 on 2/12/18.
//  Copyright © 2018 Vishal Madheshia. All rights reserved.
//

import UIKit

class CarouselViewController: UIViewController, UICollectionViewDelegate {

    // MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var indexLabel: UILabel!
    
    // MARK: - Properties
    fileprivate let carouselCellIdentifier = "carouselCell"
    
    var imageUrls: [String] = []
    var currentIndex = 1
    var totalImagesCount = 0
    fileprivate let itemsPerRow: CGFloat = 1
    fileprivate let sectionInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        totalImagesCount = imageUrls.count
        setUpViews()
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let currentIndexPath = IndexPath(item: currentIndex, section: 0)
        self.collectionView.scrollToItem(at: currentIndexPath, at: .centeredHorizontally, animated: false)
        self.collectionView.collectionViewLayout.invalidateLayout()
    }
    
    func setUpViews() {
        
        updateIndexLabel()
    }
    
    func updateIndexLabel() {
        guard totalImagesCount != 0 else {
            return
        }
        indexLabel.text = "\(currentIndex+1)/\(totalImagesCount)"
    }
    
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let x = targetContentOffset.pointee.x
        currentIndex = Int(x/view.frame.width)
        updateIndexLabel()
    }
}


extension CarouselViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageUrls.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: carouselCellIdentifier, for: indexPath) as! CarouselCollectionViewCell
        cell.imageUrl = self.imageUrls[indexPath.item]
        return cell
    }
}

extension CarouselViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}

