//
//  UIImageView+Extensions.swift
//  GithubUser
//
//  Created by Lam Le on 16/06/2022.
//

import UIKit
import SDWebImage

extension UIImageView {

    func setImage(_ urlString: String?) {
        guard let urlString = urlString, !urlString.isEmpty else {
            image = nil
            return
        }
        let url = URL(string: urlString)
        sd_setImage(with: url)
    }
}
