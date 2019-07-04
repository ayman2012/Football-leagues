//
//  TeamMatchesViewController.swift
//  Football Leagues
//
//  Created by Ayman Fathy on 7/3/19.
//  Copyright © 2019 Technivance. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

class TeamMatchesViewController: UIViewController, UITableViewDelegate {

    @IBOutlet weak var ContainerView: UIView!
    @IBOutlet weak var teamIcon: UIImageView!
    @IBOutlet weak var teamTitle: UILabel!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    @IBOutlet weak var teamsMatchesTableView: UITableView!

    var teamsMatchesViewModel: TeamMatchesViewModel!
    private let disposeBag = DisposeBag()
    func initialize(teamsMatchesViewModel: TeamMatchesViewModel) {
        self.teamsMatchesViewModel = teamsMatchesViewModel
    }

    override func viewDidLoad() {
        showLoadingView()
        setupTableView()
        configureBinding()
    }
    private func configureBinding() {
        teamsMatchesViewModel.teamsMatches.map {$0?.matches ?? []}
            .bind(to: teamsMatchesTableView.rx.items(cellIdentifier: "\(TeamMatchesViewCell.self)",
                cellType: TeamMatchesViewCell.self)) {
                _, match, cell in
                cell.configerCell(model: match)
            }.disposed(by: disposeBag)

        teamsMatchesViewModel.teamsMatches.subscribe(onNext: { [weak self] _ in
//            self?.title = model?.competition?.name
//            self?.leagueTitle.text = model?.competition?.name
//            let url = URL.init(string:model?.competition?.emblemURL ?? "")
//            self?.leagueIcon.kf.setImage(with: url, placeholder: UIImage.init(named: "default"), options: nil, progressBlock: nil, completionHandler: nil)

        }).disposed(by: disposeBag)

        teamsMatchesViewModel.loadingSubject.subscribe(onNext: { [weak self] loading in
            if loading {
                self?.hideLoadingView()
            }
        }).disposed(by: disposeBag)

    }
    private func setupTableView() {
        teamsMatchesTableView.estimatedRowHeight = 162
        registerCell()
    }
    private func registerCell() {
        let cellNib = UINib(nibName: "\(TeamMatchesViewCell.self)", bundle: nil)
        teamsMatchesTableView.register(cellNib, forCellReuseIdentifier: "\(TeamMatchesViewCell.self)")
        teamsMatchesTableView.rx.setDelegate(self).disposed(by: self.disposeBag)
    }
    private func hideLoadingView() {
        self.indicatorView.stopAnimating()
//        ContainerView.isHidden = false

    }
    fileprivate func showLoadingView() {
        indicatorView.startAnimating()
//        ContainerView.isHidden = true
    }
}
