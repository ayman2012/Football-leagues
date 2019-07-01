//
//  LeaguesViewCell.swift
//  Football Leagues
//
//  Created by Ayman Fathy on 6/30/19.
//  Copyright © 2019 Technivance. All rights reserved.
//

import UIKit

class LeaguesViewCell: UITableViewCell {

    @IBOutlet weak var leagueIcon: UIImageView!
    @IBOutlet weak var leagueTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configerCell(model: Competition) {
        leagueTitle.text = model.name
        leagueIcon.image = UIImage.init(data: model.imageData ?? Data())
    }

}
