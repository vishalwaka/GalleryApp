//
//  APIManager.swift
//  GalleryApp
//
//  Created by user136229 on 2/12/18.
//  Copyright © 2018 Vishal Madheshia. All rights reserved.
//

import UIKit

protocol APIDelegate {
    func getGalleryImageUrls(completion completionBlock: @escaping (Bool, [String])->())
}

class APIManager: NSObject, APIDelegate {
    func getGalleryImageUrls(completion completionBlock: @escaping (Bool, [String])->()) {
        guard let url = URL(string: galleryImagesUrl) else {
            completionBlock(false, [])
            return
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil, let data = data else {
                completionBlock(false, [])
                return
            }
            do {
                let imageUrls = try JSONDecoder().decode([String].self, from: data)
                print(imageUrls)
                completionBlock(true, imageUrls)
            }
            catch _ {
                completionBlock(false, [])
                return
            }
        }.resume()
        
    }
}
