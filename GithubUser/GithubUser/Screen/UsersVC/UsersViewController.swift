//
//  UsersViewController.swift
//  GithubUser
//
//  Created by Lam Le on 15/06/2022.
//

import UIKit
import RxSwift
import RxCocoa

final class UsersViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!

    private let viewModel: UsersViewModel
    private let trigger: PublishSubject<Void> = .init()
    private var refreshControl = UIRefreshControl()
    private let bag = DisposeBag()

    init(viewModel: UsersViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "UsersViewController", bundle: nil)
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
        configNavigationBar()
        configTableView()
    }

    private func configTableView() {
        tableView.register(forCell: UsersTableCell.self)
        tableView.rowHeight = Config.rowHeight
        tableView.refreshControl = refreshControl
        tableView.contentInset = Config.contentInset
    }

    private func configNavigationBar() {
        // Title
        title = App.String.Users.title
    }

    private func bindingView() {
        let input = UsersViewModel.Input(
            trigger: trigger.asDriverOnEmpty(),
            refresh: refreshControl.rx.controlEvent(.valueChanged).asDriverOnEmpty(),
            selected: tableView.rx.itemSelected.asDriverOnEmpty()
        )

        let output = viewModel.transform(input: input)

        output.users
            .drive(tableView.rx.items(cellIdentifier: "UsersTableCell", cellType: UsersTableCell.self)) { (_, userDTO, cell) in
                cell.updateView(userDTO: userDTO)
            }
            .disposed(by: bag)

        Driver.merge(output.users.mapToVoid(), output.error.mapToVoid())
            .drive(onNext: { [weak self ] in self?.refreshControl.endRefreshing() })
            .disposed(by: bag)

        output
            .itemSelected
            .drive()
            .disposed(by: bag)

        output.error
            .drive(onNext: { [weak self] networkError in
                self?.showAlert(message: networkError.localizedDescription)
            })
            .disposed(by: bag)
    }

    private func notify() {
        trigger.onNext(())
    }
}

// MARK: - Config
extension UsersViewController {
    struct Config {
        static let rowHeight: CGFloat = 80
        static let contentInset: UIEdgeInsets = .init(top: 10, left: 0, bottom: 10, right: 0)
    }
}
