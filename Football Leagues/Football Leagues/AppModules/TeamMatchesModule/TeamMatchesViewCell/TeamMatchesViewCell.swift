//
//  TeamMatchesViewCell.swift
//  Football Leagues
//
//  Created by Ayman Fathy on 7/3/19.
//  Copyright © 2019 Technivance. All rights reserved.
//

import UIKit

class TeamMatchesViewCell: UITableViewCell {

    @IBOutlet weak var leftSideImage: UIImageView!
    @IBOutlet weak var rightSideImage: UIImageView!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var dataLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configerCell(model: Match) {

    }

}
