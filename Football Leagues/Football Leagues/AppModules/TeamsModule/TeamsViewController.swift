//
//  TeamsViewController.swift
//  Football Leagues
//
//  Created by Ayman Fathy on 7/2/19.
//  Copyright © 2019 Technivance. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import Kingfisher
import SwinjectStoryboard

class TeamsViewController: UIViewController, UITableViewDelegate {

    @IBOutlet weak var ContainerView: UIView!
    @IBOutlet weak var leagueIcon: UIImageView!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    @IBOutlet weak var teamsTableView: UITableView!

    @IBOutlet weak var leagueTitle: UILabel!
    @IBOutlet weak var leftSideIcon: UIImageView!
    @IBOutlet weak var rightSideIcon: UIImageView!
    @IBOutlet weak var leftSideText: UILabel!
    @IBOutlet weak var rightSideText: UILabel!
    var teamsViewModel: TeamsViewModel!
    private let disposeBag = DisposeBag()
    func initialize(teamsViewModel: TeamsViewModel) {
        self.teamsViewModel = teamsViewModel
    }

    override func viewDidLoad() {
        showLoadingView()
        setupTableView()
        configureBinding()
    }
    private func configureBinding() {
        teamsViewModel.teamsItems.map {$0?.teams ?? []}
            .bind(to: teamsTableView.rx.items(cellIdentifier: "\(TeamsTableViewCell.self)", cellType: TeamsTableViewCell.self)) {
                _, team, cell in
                cell.configerCell(team: team)
            }.disposed(by: disposeBag)

        teamsViewModel.teamsItems.subscribe(onNext: { [weak self] model in
            self?.title = model?.competition?.name
            self?.leagueTitle.text = model?.competition?.name
            let url = URL.init(string: model?.competition?.emblemURL ?? "")
            self?.leagueIcon.kf.setImage(with: url, placeholder: UIImage.init(named: "default"), options: nil, progressBlock: nil, completionHandler: nil)
            let winnerURL = URL.init(string: model?.competition?.currentSeason?.winner?.crestURL ?? "")
            self?.rightSideIcon.kf.setImage(with: winnerURL, placeholder: UIImage.init(named: "default"), options: nil, progressBlock: nil, completionHandler: nil)

        }).disposed(by: disposeBag)

        teamsViewModel.loadingSubject.subscribe(onNext: { [weak self] loading in
            if loading {
                self?.hideLoadingView()
            }
        }).disposed(by: disposeBag)
        teamsTableView
            .rx
            .itemSelected
            .bind {[weak self] _ in
                let id = "760" //self?.leaguesViewModel.leaguesItems.value[index.row].id ?? 0
                let coordinator = TeamCoordinator.init(navigation: self?.navigationController ?? UINavigationController(), teamsId: id)
                coordinator.start()

            }.disposed(by: disposeBag)

    }
    private func setupTableView() {
        teamsTableView.estimatedRowHeight = 162
        registerCell()
    }
    private func registerCell() {
        let cellNib = UINib(nibName: "\(TeamsTableViewCell.self)", bundle: nil)
        teamsTableView.register(cellNib, forCellReuseIdentifier: "\(TeamsTableViewCell.self)")
        teamsTableView.rx.setDelegate(self).disposed(by: self.disposeBag)
    }
    private func hideLoadingView() {
        self.indicatorView.stopAnimating()
        ContainerView.isHidden = false

    }
    fileprivate func showLoadingView() {
        indicatorView.startAnimating()
        ContainerView.isHidden = true
    }
}
