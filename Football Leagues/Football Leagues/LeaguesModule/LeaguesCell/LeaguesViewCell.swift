//
//  LeaguesViewCell.swift
//  Football Leagues
//
//  Created by Ayman Fathy on 6/30/19.
//  Copyright © 2019 Technivance. All rights reserved.
//

import UIKit
import Kingfisher
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
        if let image = model.imageData{
            leagueIcon.image = UIImage.init(data: image )
        } else {
            let url = URL.init(string:model.emblemURL ?? "")
            leagueIcon.kf.setImage(with: url, placeholder: UIImage.init(named: "default"), options: nil, progressBlock: nil, completionHandler: nil)
        }
    }

}
