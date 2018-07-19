//
//  ORProfileCell.swift
//  SearchList
//
//  Created by Abhishek Shodhan on 12/12/17.
//  Copyright © 2017 Discus IT. All rights reserved.
//

import UIKit

class ORProfileCell: UITableViewCell {
    @IBOutlet weak var btnEdit: UIButton!
    @IBOutlet weak var btnApprove: UIButton!
    @IBOutlet weak var btnReject: UIButton!
    @IBOutlet weak var lblShipToAddress: UILabel!
    @IBOutlet weak var lblOrNumber: UILabel!
    @IBOutlet weak var lblCreateDate: UILabel!
    @IBOutlet weak var lblCreaterName: UILabel!
    @IBOutlet weak var lblSalesType: UILabel!
    @IBOutlet weak var lblSellerName: UILabel!
    @IBOutlet weak var lblBuyerName: UILabel!
    @IBOutlet weak var imgProfilePic: UIImageView!
    @IBOutlet weak var btnStatus: UIButton!
    @IBOutlet weak var btnProcessSO: UIButton!
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
