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
        leftSideImage.loadImage(model.homeTeam?.crestURL ?? "", placeHolder: UIImage.init(named: "default"))
        rightSideImage.loadImage(model.awayTeam?.crestURL ?? "", placeHolder: UIImage.init(named: "default"))
        resultLabel.text = "\(model.score?.fullTime?.homeTeam)" + ":" + "\(model.score?.fullTime?.awayTeam)"
        if model.status == "FINISHED" {
            statusLabel.isHidden = true
        }else {
            statusLabel.text = model.status ?? ""
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dataLabel.text = dateFormatter.string(from: model.utcDate ?? Date())
         }

}
