//
//  UIView+Extensions.swift
//  GithubUser
//
//  Created by Lam Le on 16/06/2022.
//

import UIKit

extension UIView {

    class func load<T: UIView>(from name: T.Type) -> T {
        guard let view = UINib(nibName: String(describing: name), bundle: nil).instantiate(withOwner: nil, options: nil).first as? T else {
            fatalError()
        }
        return view
    }
}
