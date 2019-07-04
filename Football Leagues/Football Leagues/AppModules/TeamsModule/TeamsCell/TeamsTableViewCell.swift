//
//  TeamsTableViewCell.swift
//  Football Leagues
//
//  Created by Ayman Fathy on 7/2/19.
//  Copyright © 2019 Technivance. All rights reserved.
//

import UIKit
import Kingfisher

class TeamsTableViewCell: UITableViewCell {

    @IBOutlet weak var teamIcon: UIImageView!
    @IBOutlet weak var teamNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configerCell(team: Team) {
        teamNameLabel.text = team.name
        let url = URL.init(string: team.crestURL ?? "")
        teamIcon.kf.setImage(with: url, placeholder: UIImage.init(named: "default"), options: nil, progressBlock: nil, completionHandler: nil)
    }

}
