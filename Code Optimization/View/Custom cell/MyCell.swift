//
//  MyCell.swift
//  Code Optimization
//
//  Created by mac on 15/11/18.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit

class MyCell: UITableViewCell {

    @IBOutlet weak var mobile: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var company: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
