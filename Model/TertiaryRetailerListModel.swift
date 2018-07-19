//
//  TertiaryRetailerListModel.swift
//  Odin_App_Project_Swift
//
//  Created by discusit on 26/02/18.
//  Copyright © 2018 discussolutions. All rights reserved.
//

import UIKit
var TertiaryRetailerListData = [TertiaryRetailerListModel]()
var TertiaryRetailerListFilterData = [TertiaryRetailerListModel]()
class TertiaryRetailerListModel: NSObject {
    var value: String = ""
    var id: String = ""
    init(retailerId:String,retailerValue:String)
    {
        self.value = retailerValue
        self.id = retailerId
    }
    class func generateModelArray() -> [TertiaryRetailerListModel]{
        var RetailerName = [TertiaryRetailerListModel]()
        for i in 0..<RetailerNameList.count
        {
            let RetailerId = (RetailerNameList.object(at: i) as! NSDictionary).value(forKey: "id") as! Int
            let RetailerValue =  (RetailerNameList.object(at: i) as! NSDictionary).value(forKey: "value") as! String
            
            print("ID :: ",RetailerId,"name :: ",RetailerValue)
            
            RetailerName.append(TertiaryRetailerListModel.init(retailerId: String(RetailerId), retailerValue: RetailerValue))
        }
        return RetailerName
    }
}
