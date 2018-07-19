//
//  ProductSelectCell.swift
//  SearchList
//
//  Created by Abhishek Shodhan on 13/12/17.
//  Copyright © 2017 Discus IT. All rights reserved.
//

import UIKit
//protocol TextCell {
//    var cellText: String? { get set }
//}

class ProductSelectCell: UITableViewCell {
    @IBOutlet weak var btnSelect: UIButton!
    @IBOutlet weak var lblProductName: MarqueeLabel!
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
