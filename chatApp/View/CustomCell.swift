//
//  CustomCell.swift
//  chatApp
//
//  Created by 志賀大河 on 2020/01/17.
//  Copyright © 2020 志賀大河. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {

    // username
    @IBOutlet weak var userNameLabel: UILabel!
    // icon
    @IBOutlet weak var iconImageView: UIImageView!
    // message
    @IBOutlet weak var messageLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
