//
//  UIView+Extensions.swift
//  GithubUser
//
//  Created by Lam Le on 16/06/2022.
//

import UIKit

public extension UIView {

    class func load<T: UIView>(from name: T.Type) -> T {
        guard let view = UINib(nibName: String(describing: name), bundle: nil).instantiate(withOwner: nil, options: nil).first as? T else {
            fatalError()
        }
        return view
    }
}

// Anchor
public extension UIView {

    struct AnchorOptions: OptionSet {

        public let rawValue: Int

        public init(rawValue: Int) {
            self.rawValue = rawValue
        }

        public static let top = UIView.AnchorOptions(rawValue: 1 << 0)

        public static let leading = UIView.AnchorOptions(rawValue: 1 << 1)

        public static let trailing = UIView.AnchorOptions(rawValue: 1 << 2)

        public static let bottom = UIView.AnchorOptions(rawValue: 1 << 3)

        public static let all: UIView.AnchorOptions = [.top, .leading, .trailing, .bottom]
    }

    func anchor(toView view: UIView?, insets: UIEdgeInsets = .zero, anchorOptions options: AnchorOptions = .all) {
        guard let view = view else { return }
        translatesAutoresizingMaskIntoConstraints = false

        if options.contains(.top) {
            topAnchor.constraint(equalTo: view.topAnchor, constant: insets.top).isActive = true
        }
        if options.contains(.leading) {
            leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: insets.left).isActive = true
        }
        if options.contains(.trailing) {
            trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: insets.right).isActive = true
        }
        if options.contains(.bottom) {
            bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: insets.bottom).isActive = true
        }
    }

    @discardableResult
    func widthAnchor(_ constant: CGFloat = 0) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let width = widthAnchor.constraint(equalToConstant: constant)
        width.isActive = true
        return width
    }

    @discardableResult
    func heightAnchor(_ constant: CGFloat = 0) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let height = heightAnchor.constraint(equalToConstant: constant)
        height.isActive = true
        return height
    }
}
