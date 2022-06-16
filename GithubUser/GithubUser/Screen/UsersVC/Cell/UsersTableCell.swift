//
//  UsersTableCell.swift
//  GithubUser
//
//  Created by Lam Le on 16/06/2022.
//

import UIKit

final class UsersTableCell: UITableViewCell {

    @IBOutlet private weak var avatarImageView: UIImageView!
    @IBOutlet private weak var userNameLabel: UILabel!
    @IBOutlet private weak var profileLinkLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        configView()
    }

    private func configView() {
        configAvatarImageView()
    }

    private func configAvatarImageView() {
        avatarImageView.layer.cornerRadius = avatarImageView.bounds.height / 2
        avatarImageView.layer.masksToBounds = true
    }

    func updateView(userDTO: UserDTO) {
        userNameLabel.text = userDTO.userName
        profileLinkLabel.text = userDTO.githubProfile
    }
}
