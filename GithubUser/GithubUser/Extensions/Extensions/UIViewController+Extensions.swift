//
//  UIViewController+Extensions.swift
//  GithubUser
//
//  Created by Lam Le on 17/06/2022.
//

import Foundation
import UIKit

public extension UIViewController {

    func showAlert(title: String? = nil, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(action)
        present(alert, animated: true)
    }
}
