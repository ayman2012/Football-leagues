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
    @IBOutlet weak var nodataView: UIView!
    
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
            if model?.teams?.isEmpty ?? true {
                self?.showNoDataView()
            }else{
                self?.HideNoDataView()
            }
        }).disposed(by: disposeBag)
        teamsViewModel.teamsItems.subscribe(onNext: { [weak self] model in
            self?.title = model?.competition?.name
            self?.leagueTitle.text = model?.competition?.name
            if let leagueURL =  model?.competition?.emblemURL {
                self?.leagueIcon.loadImage(leagueURL, placeHolder: UIImage.init(named: "default"))
            }
            if let winnerURL =  model?.competition?.currentSeason?.winner?.crestURL {
                self?.leagueIcon.loadImage(winnerURL, placeHolder: UIImage.init(named: "default"))
            }
            if model?.competition?.currentSeason?.winner?.name == "" {
                self?.rightSideText.text = "no winner yet"
            } else {
                self?.rightSideText.text = model?.competition?.currentSeason?.winner?.name ?? "no winner yet"
            }
            self?.leftSideText.text = "available Seasons : \(model?.competition?.numberOfAvailableSeasons ?? 0)"
        }).disposed(by: disposeBag)

        teamsViewModel.loadingSubject.subscribe(onNext: { [weak self] loading in
            if loading {
                self?.hideLoadingView()
            }
        }).disposed(by: disposeBag)
        teamsTableView
            .rx
            .itemSelected
            .bind {[weak self] index in
                let id = "\(self?.teamsViewModel.teamsItems.value?.teams?[index.row].id ?? 0)"
                let teamName = self?.teamsViewModel.teamsItems.value?.teams?[index.row].name ?? ""
                let teamImageURL = self?.teamsViewModel.teamsItems.value?.teams?[index.row].crestURL ?? ""
                let coordinator = TeamCoordinator.init(navigation: self?.navigationController ?? UINavigationController(),
                                                      teamsId: id,
                                                      teamName: teamName,
                                                      teamImageURL: teamImageURL)
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
    fileprivate func showNoDataView() {
        ContainerView.isHidden = true
        nodataView.isHidden = false
    }
    fileprivate func HideNoDataView() {
        ContainerView.isHidden = false
        nodataView.isHidden = true
    }
}
