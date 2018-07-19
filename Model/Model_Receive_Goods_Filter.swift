
//
//  Model_Receive_Goods_Filter.swift
//  Odin_App_Project_Swift
//
//  Created by discusit on 12/02/18.
//  Copyright © 2018 discussolutions. All rights reserved.
//

import UIKit

var BuyerNameList: NSArray = NSArray()

class Model_Receive_Goods_Filter: NSObject
{

}

//MARK:- Buyer Name List Model

class BuyerNameModel: NSObject {
    var value: String = ""
    var id: String = ""
    init(buyerId:String,buyerValue:String)
    {
        self.value = buyerValue
        self.id = buyerId
    }
    class func generateFilterModelArray() -> [BuyerNameModel]{
        var BuyerNameFilter = [BuyerNameModel]()
        for i in 0..<BuyerNameList.count
        {
            let BuyerId = (BuyerNameList.object(at: i) as! NSDictionary).value(forKey: "id") as! Int
            let BuyerValue =  (BuyerNameList.object(at: i) as! NSDictionary).value(forKey: "value") as! String
            
            print("ID :: ",BuyerId,"name :: ",BuyerValue)
            BuyerNameFilter.append(BuyerNameModel.init(buyerId: String(BuyerId), buyerValue: BuyerValue))
        }
        return BuyerNameFilter
    }
}
