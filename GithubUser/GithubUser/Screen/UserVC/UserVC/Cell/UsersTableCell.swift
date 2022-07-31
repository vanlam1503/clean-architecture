//
//  UsersTableCell.swift
//  GithubUser
//
//  Created by Lam Le on 16/06/2022.
//

import UIKit
import Extensions

final class UsersTableCell: UITableViewCell {

    @IBOutlet private weak var avatarImageView: UIImageView!
    @IBOutlet private weak var userNameLabel: UILabel!
    @IBOutlet private weak var profileLinkLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        configView()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        configAvatarImageView()
    }

    private func configView() {
        configAvatarImageView()
    }

    private func configAvatarImageView() {
        avatarImageView.layer.cornerRadius = avatarImageView.bounds.height / 2
        avatarImageView.layer.masksToBounds = true
    }

    func updateView(userDTO: User) {
        avatarImageView.setImage(userDTO.avatar)
        userNameLabel.text = userDTO.login
        profileLinkLabel.text = userDTO.githubProfile
    }
}
