//
//  UIImageView+LoadImageFromURL.swift
//  MovieApp
//
//  Created by Daniel Wong on 28/3/21.
//

import Foundation
import UIKit

/// Kindly adapted from
/// https://www.hackingwithswift.com/example-code/uikit/how-to-load-a-remote-image-url-into-uiimageview
extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
