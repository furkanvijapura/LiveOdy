//
//  Model_Daily_Sales_Filter.swift
//  Odin_App_Project_Swift
//
//  Created by Sunil Yadav on 10/02/18.
//  Copyright © 2018 discussolutions. All rights reserved.
//

import UIKit

var CreatedBy = NSArray()
var SalesListStatus = NSArray()
var Retailer = NSArray()

class Model_Daily_Sales_Filter: NSObject {

    

}
//MARK:- Created By Model

class CreatedByModel: NSObject {
    var value: String = ""
    var id: String = ""
    init(CreatedId:String,CreatedValue:String)
    {
        self.value = CreatedValue
        self.id = CreatedId
    }
    class func generateSOFilterModelArray() -> [CreatedByModel]{
        var modelSoFilter = [CreatedByModel]()
        for i in 0..<CreatedBy.count
        {
            let createId = (CreatedBy.object(at: i) as! NSDictionary).value(forKey: "id") as! Int
            let createValue =  (CreatedBy.object(at: i) as! NSDictionary).value(forKey: "value") as! String
            
            print("ID :: ",createId,"name :: ",createValue)
           modelSoFilter.append(CreatedByModel(CreatedId: String(createId), CreatedValue: createValue))
            
        }
        return modelSoFilter
    }
}

//MARK:- Sales List Model

class SalesListModel: NSObject {
    var value: String = ""
    var id: String = ""
    init(SaleId:String,SaleValue:String)
    {
        self.value = SaleValue
        self.id = SaleId
    }
    class func generateSOFilterModelArray() -> [SalesListModel]{
        var modelSoFilter = [SalesListModel]()
        for i in 0..<SalesListStatus.count
        {
            let saleId = (SalesListStatus.object(at: i) as! NSDictionary).value(forKey: "id") as! Int
            let saleValue =  (SalesListStatus.object(at: i) as! NSDictionary).value(forKey: "value") as! String
            
            print("ID :: ",saleId,"name :: ",saleValue)
            
            modelSoFilter.append(SalesListModel(SaleId: String(saleId), SaleValue: saleValue))
        }
        return modelSoFilter
    }
}

//MARK:- Retailer Model

class RetailerModel: NSObject {
    var value: String = ""
    var id: String = ""
    init(RetailerId:String,RetailerValue:String)
    {
        self.value = RetailerValue
        self.id = RetailerId
    }
    class func generateSOFilterModelArray() -> [RetailerModel]{
        var modelSoFilter = [RetailerModel]()
        for i in 0..<Retailer.count
        {
            let retailerId = (Retailer.object(at: i) as! NSDictionary).value(forKey: "id") as! Int
            let retailerValue =  (Retailer.object(at: i) as! NSDictionary).value(forKey: "value") as! String
            
            print("ID :: ",retailerId,"name :: ",retailerValue)
            
            modelSoFilter.append(RetailerModel(RetailerId: String(retailerId), RetailerValue: retailerValue))
        }
        return modelSoFilter
    }
}
