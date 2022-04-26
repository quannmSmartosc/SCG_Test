//
//  UIImageViewExtension.swift
//  News
//
//  Created by Baboon on 22/04/2022.
//

import UIKit
import Kingfisher

extension UIImageView {
    func displayImageString(_ image: String?) {
        guard let image = image, let url = URL(string: image) else { self.image = nil; return }
        kf.setImage(with: url, placeholder: UIImage(named: "app"))
    }
}


