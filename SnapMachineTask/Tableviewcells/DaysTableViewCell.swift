//
//  DaysTableViewCell.swift
//  SnapMachineTask
//
//  Created by Rakesh on 4/4/21.
//  Copyright © 2021 Rakesh. All rights reserved.
//

import UIKit

class DaysTableViewCell: UITableViewCell {
    @IBOutlet weak var dateandTimeLabel: UILabel!
    
    @IBOutlet weak var detailsText: UILabel!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
      
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
