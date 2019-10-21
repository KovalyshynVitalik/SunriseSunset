//
//  SunriseSunsetInfoTableViewCell.swift
//  SunriseSunset
//
//  Created by Vitalik on 10/21/19.
//  Copyright © 2019 VitalikKovalyshyn. All rights reserved.
//

import UIKit

class SunriseSunsetInfoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var sunriseLabel: UILabel!
    @IBOutlet weak var sunsetLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
