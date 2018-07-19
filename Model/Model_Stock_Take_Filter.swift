//
//  Model_Stock_Take_Filter.swift
//  Odin_App_Project_Swift
//
//  Created by discusit on 12/02/18.
//  Copyright © 2018 discussolutions. All rights reserved.
//

import UIKit

//MARK:- Organization Name List Model
var OrgNameData = [OrgNameModel]()
var OrgNameFilter = [OrgNameModel]()
class OrgNameModel: NSObject {
    
     static var OrganizationNameList: NSArray = NSArray()
     static var OrganizationName = String()
     static var OrganizationID = String()
     static var OrganizationTypeID = String()
    
    var value: String = ""
    var id: String = ""
    var TypeID: String = ""
    init(OrgId:String, OrgValue:String,TypeID:String)
    {
        self.value = OrgValue
        self.id = OrgId
        self.TypeID = TypeID
    }
    
    class func generateFilterModelArray() -> [OrgNameModel]{
        var OrgNameFilter = [OrgNameModel]()
        for i in 0..<OrganizationNameList.count
        {
            let OrgId = (OrganizationNameList.object(at: i) as! NSDictionary).value(forKey: "id") as! Int
            let OrgValue =  (OrganizationNameList.object(at: i) as! NSDictionary).value(forKey: "value") as! String
            let OrgTypeID = "0"//(OrganizationNameList.object(at: i) as! NSDictionary).value(forKey: "typeId") as! String
            
            print("ID :: ",OrgId,"name :: ",OrgValue,"Type ID :: ",OrgTypeID)
            OrgNameFilter.append(OrgNameModel.init(OrgId: String(OrgId), OrgValue: OrgValue, TypeID: OrgTypeID))
        }
        return OrgNameFilter
    }
}

