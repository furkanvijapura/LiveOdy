//
//  DilevryAdress.swift
//  SearchList
//
//  Created by Abhishek Shodhan on 13/12/17.
//  Copyright © 2017 Discus IT. All rights reserved.
//

import UIKit

class DilevryAdress: UITableViewCell
{
    @IBOutlet weak var btnSelectAddress: UIButton!
    @IBOutlet weak var lblOrgAddress: UILabel!
    @IBOutlet weak var lblOrgName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
