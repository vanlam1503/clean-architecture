//
//  UserDetailViewController.swift
//  GithubUser
//
//  Created by Lam Le on 16/06/2022.
//

import UIKit
import RxSwift
import RxCocoa
import Extensions
import App

public class UserDetailViewController: UIViewController {

    @IBOutlet private weak var avatarImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var locationLabel: UILabel!
    @IBOutlet private weak var bioLabel: UILabel!
    @IBOutlet private weak var footerView: UIView!
    private let publicRepoView = UIView.load(from: UserDetailStatisticsView.self)
    private let followersView = UIView.load(from: UserDetailStatisticsView.self)
    private let folowingView = UIView.load(from: UserDetailStatisticsView.self)

    private let trigger: PublishSubject<Void> = .init()

    private let viewModel: UserDetailViewModel
    private let bag = DisposeBag()

    public init(viewModel: UserDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "UserDetailViewController", bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        configView()
        bindingView()
        notify()
    }

    private func configView() {
        configNavigationView()
        configFooterView()
        configAvatarView()
    }

    private func configNavigationView() {
        title = App.String.UserDetail.profile
    }

    private func configAvatarView() {
        avatarImageView.layer.cornerRadius = avatarImageView.bounds.size.height / 2
    }

    private func configFooterView() {
        // Public repo view
        footerView.addSubview(publicRepoView)
        footerView.addSubview(followersView)
        footerView.addSubview(folowingView)

        // publicRepoView 's constraint
        publicRepoView.anchor(toView: footerView, insets: .init(top: 0, left: 0, bottom: 0, right: 0), anchorOptions: [.leading, .bottom])
        publicRepoView.widthAnchor(Config.itemWidth)
        publicRepoView.heightAnchor(Config.itemHeight)

        // followersView 's constraint
        followersView.translatesAutoresizingMaskIntoConstraints = false
        followersView.leadingAnchor.constraint(equalTo: publicRepoView.trailingAnchor).isActive = true
        followersView.anchor(toView: footerView, anchorOptions: .bottom)
        followersView.widthAnchor(Config.itemWidth)
        followersView.heightAnchor(Config.itemHeight)

        // following view
        folowingView.translatesAutoresizingMaskIntoConstraints = false
        folowingView.leadingAnchor.constraint(equalTo: followersView.trailingAnchor).isActive = true
        folowingView.anchor(toView: footerView, anchorOptions: .bottom)
        folowingView.widthAnchor(Config.itemWidth)
        folowingView.heightAnchor(Config.itemHeight)

        publicRepoView.translatesAutoresizingMaskIntoConstraints = false
        publicRepoView.leadingAnchor.constraint(equalTo: footerView.leadingAnchor).isActive = true
    }

    private func bindingView() {
        let input = UserDetailViewModel.Input(trigger: trigger.asDriverOnEmpty())
        let output = viewModel.transform(input: input)
        output.avatar.drive(onNext: { [weak self] avatar in
            self?.avatarImageView.setImage(avatar)
        }).disposed(by: bag)
        output
            .username
            .drive(nameLabel.rx.text)
            .disposed(by: bag)
        output
            .location
            .drive(locationLabel.rx.text)
            .disposed(by: bag)

        output.bio
            .drive(bioLabel.rx.text)
            .disposed(by: bag)

        output.error
            .drive(onNext: { [weak self] networkError in
                self?.showAlert(message: networkError.localizedDescription)
            })
            .disposed(by: bag)

        output.publicRepos
            .drive(onNext: { [weak self] number in
                self?.publicRepoView.updateView(type: .publicRepos(number))
            }).disposed(by: bag)

        output.followers
            .drive(onNext: { [weak self] number in
                self?.followersView.updateView(type: .followers(number))
            }).disposed(by: bag)

        output.following
            .drive(onNext: { [weak self] number in
                self?.folowingView.updateView(type: .following(number))
            }).disposed(by: bag)
    }

    private func notify() {
        trigger.onNext(())
    }
}

// MARK: - Config
extension UserDetailViewController {

    struct Config {
        static let screenWidth = UIScreen.main.bounds.width
        static let itemWidth: CGFloat = screenWidth / 3.0
        static let itemHeight: CGFloat = 50
    }
}
