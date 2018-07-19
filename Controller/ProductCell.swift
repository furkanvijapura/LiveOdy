//
//  ProductCell.swift
//  SearchList
//
//  Created by Abhishek Shodhan on 12/12/17.
//  Copyright © 2017 Discus IT. All rights reserved.
//

import UIKit

class ProductCell: UITableViewCell {

    @IBOutlet var lblNoProduct: UILabel!
    @IBOutlet var viewBackMain: UIView!
    @IBOutlet var btnDelete: UIButton!
    @IBOutlet weak var lblTotalAmount: UILabel!
    @IBOutlet weak var lblQty: UILabel!
    @IBOutlet weak var btnPriceBookprice: UIButton!
    @IBOutlet weak var lblskuname: UILabel!
    @IBOutlet weak var lblUcom: UILabel!
    @IBOutlet weak var lblProductdetails: UILabel!
    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var imgProductProfilepic: UIImageView!
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
