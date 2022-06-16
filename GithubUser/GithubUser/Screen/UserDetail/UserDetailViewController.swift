//
//  UserDetailViewController.swift
//  GithubUser
//
//  Created by Lam Le on 16/06/2022.
//

import UIKit
import RxSwift
import RxCocoa

final class UserDetailViewController: UIViewController {

    @IBOutlet private weak var avatarImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var locationLabel: UILabel!
    @IBOutlet private weak var bioLabel: UILabel!

    private let trigger: PublishSubject<Void> = .init()

    private let viewModel: UserDetailViewModel
    private let bag = DisposeBag()

    init(viewModel: UserDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "UserDetailViewController", bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
        bindingView()
        notify()
    }
    

    private func configView() {
        configNavigationView()
    }

    private func configNavigationView() {
        title = App.String.UserDetail.profile
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
            .drive()
            .disposed(by: bag)
    }

    private func notify() {
        trigger.onNext(())
    }
}
