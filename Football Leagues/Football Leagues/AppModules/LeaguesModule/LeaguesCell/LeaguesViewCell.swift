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

    @IBOutlet weak var leftSideIcon: UIImageView!
    @IBOutlet weak var rightSideIcon: UIImageView!
    @IBOutlet weak var leftSideText: UILabel!
    @IBOutlet weak var rightSideText: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        // Initialization code
    }
    func configerCell(model: Competition) {
        leagueTitle.text = model.name
        leagueIcon.loadImage(model.emblemURL ?? "", placeHolder: UIImage.init(named: "default"))
        rightSideIcon.loadImage(model.currentSeason?.winner?.crestURL ?? "", placeHolder: UIImage.init(named: "default"))
        //Check if name empty from sql
        if model.currentSeason?.winner?.name == "" {
            rightSideText.text = "no winner yet"
        } else {
            rightSideText.text = model.currentSeason?.winner?.name ?? "no winner yet"

        }
        leftSideText.text = "available Seasons : \(model.numberOfAvailableSeasons ?? 0)"
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        leagueIcon.cancelImageLoad()
    }
}
