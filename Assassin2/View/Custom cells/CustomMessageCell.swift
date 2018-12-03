//
//  CustomMessageCellTableViewCell.swift
//  Assassin2
//
//  Created by Timmy Van Cauwenberge on 11/14/18.
//  Copyright © 2018 Cowabunga Games. All rights reserved.
//

import UIKit

class CustomMessageCell : UITableViewCell {

    @IBOutlet weak var gameAvatar: UIImageView!
    @IBOutlet weak var gameNameLabel: UILabel!
    @IBOutlet weak var mostRecentMesageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
