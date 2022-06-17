//
//  TableView+Extensions.swift
//  GithubUser
//
//  Created by Lam Le on 16/06/2022.
//

import UIKit

public extension UITableView {

    func register(forCell cell: UITableViewCell.Type) {
        let identifier = String(describing: cell)
        let nib = UINib(nibName: identifier, bundle: Bundle(for: cell))
        register(nib, forCellReuseIdentifier: identifier)
    }
}
