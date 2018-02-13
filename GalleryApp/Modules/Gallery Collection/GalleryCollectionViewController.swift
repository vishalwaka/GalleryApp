//
//  GalleryCollectionViewController.swift
//  GalleryApp
//
//  Created by user136229 on 2/12/18.
//  Copyright © 2018 Vishal Madheshia. All rights reserved.
//

import UIKit

class GalleryCollectionViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Properties
    private var imageUrls: [String] = []
    private var activityIndicator: UIActivityIndicatorView?
    fileprivate let itemsPerRow: CGFloat = 3
    fileprivate var currentSelectedItem = 0
    fileprivate let sectionInsets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
    fileprivate let carouselShowSegueIdentifier = "carouselShow"
    fileprivate let galleryCellIdentifier = "galleryCellIdentifier"

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Gallery"
        showIndicator()
        getGalleryImages()
    }

    // MARK: - Methods
    private func showIndicator() {
        activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        view.addSubview(activityIndicator!)
        activityIndicator?.frame = view.bounds
        activityIndicator?.startAnimating()
    }
    
    private func getGalleryImages() {
        let apiDelegate: APIDelegate = APIManager()
        apiDelegate.getGalleryImageUrls { (success, imageUrls) in
            DispatchQueue.main.async {
                self.activityIndicator?.stopAnimating()
                self.activityIndicator?.removeFromSuperview()
            }
            guard success else {
                //Show error while getting gallery images
                return
            }
            self.imageUrls = imageUrls
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == carouselShowSegueIdentifier {
            if let carouselVC = segue.destination as? CarouselViewController {
                carouselVC.currentIndex = currentSelectedItem
                carouselVC.imageUrls = self.imageUrls
            }
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.collectionView.collectionViewLayout.invalidateLayout()
    }
}

extension GalleryCollectionViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageUrls.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: galleryCellIdentifier, for: indexPath) as! GalleryCollectionViewCell
        cell.imageUrl = self.imageUrls[indexPath.item]
        return cell
    }
}

extension GalleryCollectionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        currentSelectedItem = indexPath.item
        performSegue(withIdentifier: carouselShowSegueIdentifier, sender: nil)
    }
}

extension GalleryCollectionViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace - view.safeAreaInsets.left - view.safeAreaInsets.right
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem)
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
