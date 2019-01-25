//
//  BrDetailTableViewCell.swift
//  brackfasts
//
//  Created by Admin on 25/01/2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

class BrDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var keyLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
