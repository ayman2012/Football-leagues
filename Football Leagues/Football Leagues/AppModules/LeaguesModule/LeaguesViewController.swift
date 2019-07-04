//
//  LeaguesViewController.swift
//  Football Leagues
//
//  Created by Ayman Fathy on 6/30/19.
//  Copyright © 2019 Technivance. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import Swinject
import SwinjectStoryboard

class LeaguesViewController: UIViewController, UITableViewDelegate {

    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    @IBOutlet weak var leaguesTableView: UITableView!
    private var leaguesViewModel: LeaguesViewModel!
    private let disposeBag = DisposeBag()
    func initialize(leaguesViewModel: LeaguesViewModel) {
        self.leaguesViewModel = leaguesViewModel
    }

    override func viewDidLoad() {
        showLoadingView()
        setupTableView()
        configureBinding()
        title = leaguesViewModel.title
    }
    private func configureBinding() {
        leaguesViewModel.leaguesItems
            .bind(to: leaguesTableView.rx.items(cellIdentifier: "\(LeaguesViewCell.self)", cellType: LeaguesViewCell.self)) {
                _, leagueItem, cell in
                cell.configerCell(model: leagueItem)
            }.disposed(by: disposeBag)

        leaguesViewModel.loadingSubject.subscribe({ [weak self] (_) in
            self?.hideLoadingView()
        }).disposed(by: disposeBag)
        leaguesTableView
            .rx
            .itemSelected
            .bind {[weak self] _ in
                let id = 2000 //self?.leaguesViewModel.leaguesItems.value[index.row].id ?? 0
                let coordinator = TeamsCoordinator.init(navigation: self?.navigationController ?? UINavigationController(), leagueId: id)
               coordinator.start()
             }.disposed(by: disposeBag)

    }
    private func setupTableView() {
       leaguesTableView.estimatedRowHeight = 162
        registerCell()
    }
    private func registerCell() {
        let cellNib = UINib(nibName: "\(LeaguesViewCell.self)", bundle: nil)
        leaguesTableView.register(cellNib, forCellReuseIdentifier: "\(LeaguesViewCell.self)")
        leaguesTableView.rx.setDelegate(self).disposed(by: self.disposeBag)
    }
    private func hideLoadingView() {
        self.indicatorView.stopAnimating()
        leaguesTableView.isHidden = false

    }
    fileprivate func showLoadingView() {
        indicatorView.startAnimating()
        leaguesTableView.isHidden = true
    }
}
