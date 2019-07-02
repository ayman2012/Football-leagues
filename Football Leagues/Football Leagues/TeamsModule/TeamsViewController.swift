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
class TeamsViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    @IBOutlet weak var teamsTableView: UITableView!
    private var teamsViewModel: TeamsViewModel!
    private let disposeBag = DisposeBag()
    func initialize(teamsViewModel: TeamsViewModel) {
        self.teamsViewModel = teamsViewModel
    }
    
    override func viewDidLoad() {
        showLoadingView()
        setupTableView()
        configureBinding()
        title = teamsViewModel.title
    }
    private func configureBinding() {
        teamsViewModel.teamsItems
            .bind(to: teamsTableView.rx.items(cellIdentifier: "\(LeaguesViewCell.self)", cellType: LeaguesViewCell.self)) {
                _, leagueItem, cell in
                cell.configerCell(model: leagueItem)
            }.disposed(by: disposeBag)
        
        teamsViewModel.loadingSubject.subscribe({ [weak self] (_) in
            self?.hideLoadingView()
        }).disposed(by: disposeBag)
    }
    private func setupTableView() {
        teamsTableView.estimatedRowHeight = 162
        registerCell()
    }
    private func registerCell() {
        let cellNib = UINib(nibName: "\(LeaguesViewCell.self)", bundle: nil)
        teamsTableView.register(cellNib, forCellReuseIdentifier: "\(LeaguesViewCell.self)")
        teamsTableView.rx.setDelegate(self).disposed(by: self.disposeBag)
    }
    private func hideLoadingView() {
        self.indicatorView.stopAnimating()
        teamsTableView.isHidden = false
        
    }
    fileprivate func showLoadingView() {
        indicatorView.startAnimating()
        teamsTableView.isHidden = true
    }
}
