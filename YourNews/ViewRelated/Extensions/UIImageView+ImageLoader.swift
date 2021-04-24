//
//  UIImageView+ImageLoader.swift
//  YourNews
//
//  Created by Amr Hesham on 24/04/2021.
//

import UIKit

// MARK: - UIImageView + ImageLoader Conformance
//
extension UIImageView: ImageLoader {
    
    func setImage(urlString: String?, placeholder: UIImage?) {
        let url = URL(string: urlString ?? "")
        self.kf.setImage(with: url, placeholder: placeholder)
    }
}

// MARK: - ImageLoader
//
protocol ImageLoader {
    
    /// Set image using url as string and placeholder image in case of failure to fetch the image
    func setImage(urlString: String?, placeholder: UIImage?)
}
