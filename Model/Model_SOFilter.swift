//
//  Model_SOFilter.swift
//  Odin_App_Project_Swift
//
//  Created by discusit on 09/02/18.
//  Copyright © 2018 discussolutions. All rights reserved.
//

import UIKit

var FilterSO : NSDictionary = NSDictionary()
var SoSalesType : NSArray = NSArray()
var SoOrgName : NSArray = NSArray()
var SoStatus : NSArray = NSArray()
var SoPeoples : NSArray = NSArray()

class Model_SOFilter: NSObject
{
   


}

//MARK:- Sales Type Model

class SOFilterSalesTypeModel: NSObject {
    var value: String = ""
    var id: String = ""
    init(SalesTypeId:String,SalesTypeValue:String)
    {
        self.value = SalesTypeValue
        self.id = SalesTypeId
    }
    class func generateSOFilterModelArray() -> [SOFilterSalesTypeModel]{
        var modelSoFilter = [SOFilterSalesTypeModel]()
        for i in 0..<SoSalesType.count
        {
            let SOId = (SoSalesType.object(at: i) as! NSDictionary).value(forKey: "id") as! Int
            let SOValue =  (SoSalesType.object(at: i) as! NSDictionary).value(forKey: "value") as! String
            
            print("ID :: ",SOId,"name :: ",SOValue)
            //                modelBuyer.append(salesType(buyerName: BuyerName, buyerType: String(Buyertype), orBuyerId: String(buyerid)))
            modelSoFilter.append(SOFilterSalesTypeModel(SalesTypeId: String(SOId), SalesTypeValue: SOValue))
        }
        return modelSoFilter
    }
}

//MARK:- Organization Name Model

class SOFilterOrgNameModel: NSObject {
    var value: String = ""
    var id: String = ""
    var type : String = ""
    init(OrgId:String,OrgValue:String,OrgType:String)
    {
        self.value = OrgValue
        self.id = OrgId
        self.type = OrgType
    }
    class func generateSOFilterModelArray() -> [SOFilterOrgNameModel]{
        var modelSoFilter = [SOFilterOrgNameModel]()
        for i in 0..<SoOrgName.count
        {
            let OrgId = (SoOrgName.object(at: i) as! NSDictionary).value(forKey: "id") as! Int
            
            let OrgValue =  (SoOrgName.object(at: i) as! NSDictionary).value(forKey: "value") as! String
            
             let OrgType = (SoOrgName.object(at: i) as! NSDictionary).value(forKey: "type") as! Int
            
            print("ID :: ",String(OrgId),"Value :: ",OrgValue,"Type ::",OrgType)
           
            modelSoFilter.append(SOFilterOrgNameModel(OrgId: String(OrgId), OrgValue: OrgValue, OrgType: String(OrgType)))
        }
        return modelSoFilter
    }
}

//MARK:- Status Model

class SOFilterStatusModel: NSObject {
    var value: String = ""
    var id: String = ""
//    var type : String = ""
    init(StatusId:String,StatusValue:String)
    {
        self.value = StatusValue
        self.id = StatusId
//        self.type = OrgType
    }
    class func generateSOFilterModelArray() -> [SOFilterStatusModel]{
        var modelSoFilter = [SOFilterStatusModel]()
        for i in 0..<SoStatus.count
        {
            let statusId = (SoStatus.object(at: i) as! NSDictionary).value(forKey: "id") as! Int
            
            let statusValue =  (SoStatus.object(at: i) as! NSDictionary).value(forKey: "value") as! String
            
//            let SOType = (status.object(at: i) as! NSDictionary).value(forKey: "type") as! Int
            
            print("ID :: ",statusId,"name :: ",statusValue)
            
            modelSoFilter.append(SOFilterStatusModel(StatusId: String(statusId), StatusValue: statusValue))
        }
        return modelSoFilter
    }
}

//MARK:- Peoples Model

class SOFilterPeoplesModel: NSObject {
    var peoplename: String = ""
    var peopleid: String = ""
    var personId : String = ""
    var reportingPersonId : String = ""
    init(PeopleId:String,PeopleName:String,PersonId:String)
    {
        self.peoplename = PeopleName
        self.peopleid = PeopleId
        self.personId = PersonId
//        self.reportingPersonId = reportingPerson
    }
    class func generateSOFilterModelArray() -> [SOFilterPeoplesModel]{
        var modelSoFilter = [SOFilterPeoplesModel]()
        for i in 0..<SoPeoples.count
        {
            let peopleId = (SoPeoples.object(at: i) as! NSDictionary).value(forKey: "id") as! Int
            
            let peopleName =  (SoPeoples.object(at: i) as! NSDictionary).value(forKey: "name") as! String
            
            let personId = (SoPeoples.object(at: i) as! NSDictionary).value(forKey: "personId") as! Int
            
//            let ReportingPersonId =  (SoPeoples.object(at: i) as! NSDictionary).value(forKey: "reportingPersonId") as! Int
            

            print("ID :: ",peopleId,"name :: ",peopleName,"personId ::",personId)
            modelSoFilter.append(SOFilterPeoplesModel(PeopleId: String(peopleId), PeopleName: peopleName, PersonId: String(personId)))
        }
        return modelSoFilter
    }
}


