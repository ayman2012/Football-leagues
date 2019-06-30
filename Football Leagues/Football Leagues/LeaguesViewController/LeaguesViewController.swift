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

class LeaguesViewController : UIViewController {
    
    @IBOutlet weak var leaguesTableView: UITableView!
    private var leaguesViewModel: LeaguesViewModel!
    private let disposeBag = DisposeBag()
    func initialize(leaguesViewModel:LeaguesViewModel) {
        self.leaguesViewModel = leaguesViewModel
        configureBinding()
    }
    private func configureBinding() {
        leaguesViewModel
            .leaguesItems.subscribe(onNext: { [weak self] (item) in
                print(item)
            }).disposed(by: disposeBag)
    }
    private func setupView(){
        let cellNib = UINib(nibName: "\(LeaguesViewCell.self)", bundle: nil)
        leaguesTableView.register(cellNib, forCellReuseIdentifier: "\(LeaguesViewCell.self)")
        leaguesTableView.rx.setDelegate(self).disposed(by: self.disposeBag)
    }
}
extension LeaguesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
    }
    
    
}
