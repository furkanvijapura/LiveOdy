//
//  Model_Daily_Sales_Retailer.swift
//  Odin_App_Project_Swift
//
//  Created by discusit on 13/02/18.
//  Copyright © 2018 discussolutions. All rights reserved.
//

import UIKit

var DailySalesRetailers = NSArray()

class Model_Daily_Sales_Retailer: NSObject
{
    var value: String = ""
    var id: String = ""
    init(retailerId:String,retailerValue:String)
    {
        self.value = retailerValue
        self.id = retailerId
    }
    class func generateModelArray() -> [Model_Daily_Sales_Retailer]{
        var RetailerName = [Model_Daily_Sales_Retailer]()
        for i in 0..<DailySalesRetailers.count
        {
            let RetailerId = (DailySalesRetailers.object(at: i) as! NSDictionary).value(forKey: "id") as! Int
            let RetailerValue =  (DailySalesRetailers.object(at: i) as! NSDictionary).value(forKey: "value") as! String
            
            print("ID :: ",RetailerId,"name :: ",RetailerValue)
            
            RetailerName.append(Model_Daily_Sales_Retailer.init(retailerId: String(RetailerId), retailerValue: RetailerValue))
        }
        return RetailerName
    }
}
