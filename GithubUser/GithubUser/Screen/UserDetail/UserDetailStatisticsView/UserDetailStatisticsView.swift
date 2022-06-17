//
//  UserDetailStatisticsView.swift
//  GithubUser
//
//  Created by Lam Le on 16/06/2022.
//

import UIKit

final class UserDetailStatisticsView: UIView {

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var followersNumberLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func updateView(type: `Type`) {
        titleLabel.text = type.title
        followersNumberLabel.text = type.number.toString()
    }
}

// MARK: - `Type`
extension UserDetailStatisticsView {

    enum `Type` {
        case publicRepos(Int)
        case followers(Int)
        case following(Int)

        var number: Int {
            switch self {
            case .publicRepos(let number): return number
            case .followers(let number): return number
            case .following(let number): return number
            }
        }
        var title: String {
            switch self {
            case .publicRepos: return App.String.UserDetail.publicRepos
            case .followers: return App.String.UserDetail.followers
            case .following: return App.String.UserDetail.following
            }
        }
    }
}

private extension Int {

    func toString() -> String {
        String(self)
    }
}
