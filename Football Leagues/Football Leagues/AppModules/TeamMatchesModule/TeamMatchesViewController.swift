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
    @IBOutlet weak var nodataView: UIView!

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
        teamsMatchesViewModel.teamsMatches.subscribe(onNext: { [weak self] model in
            if model?.matches?.isEmpty ?? true {
                self?.showNoDataView()
            }else{
                self?.HideNoDataView()
            }
        }).disposed(by: disposeBag)
        teamsMatchesViewModel.teamsMatches.subscribe(onNext: { [weak self] model in
            self?.teamTitle.text = self?.teamsMatchesViewModel.teamName ?? ""
            if let teamImageURL = self?.teamsMatchesViewModel.teamImageURL {
                self?.teamIcon.loadImage(teamImageURL, placeHolder: UIImage.init(named: "default"))
            }

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
