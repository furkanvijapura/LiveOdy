//
//  Model.swift
//  SearchBar
//
//  Created by Shinkangsan on 12/20/16.
//  Copyright © 2016 Sheldon. All rights reserved.
//

import UIKit
var FilterDicArry:NSArray = NSArray()
class FIlterModel: NSObject {
    var OrganizationName: String = ""
    var OrganizationType: String = ""
    var contactType: NSNumber
    var ID: String = ""
    var ProLogo : String = ""
    var fullName : String = ""
    var designation : String = ""
    var ProLogoID : String = ""
    init(OrgName:String,OrgType:String,User:NSNumber,IDN:String,ProfileLogo:String,ProfileLogoID:String,fullName:String,designation:String) {
        self.OrganizationName = OrgName
        self.OrganizationType = OrgType
        self.contactType = User
        self.ID = IDN
        self.ProLogo = ProfileLogo
        self.ProLogoID = ProfileLogoID
        self.fullName = fullName
        self.designation = designation        
    }
    
    class func generateModelFilterArray() -> [FIlterModel]{
        var modelAry = [FIlterModel]()
        for i in 0..<FilterDicArry.count
        {
            var id = (FilterDicArry.object(at: i) as! NSDictionary).value(forKey: "id") as! Int
            var OrganizatioName =  (FilterDicArry.object(at: i) as! NSDictionary).value(forKey: "organizationName") as! String
            var type = (FilterDicArry.object(at: i) as! NSDictionary).value(forKey: "type") as! String
            let imgPro = (FilterDicArry.object(at: i) as! NSDictionary).value(forKey: "logoName") as! String
            let imgProID = (FilterDicArry.object(at: i) as! NSDictionary).value(forKey: "logoId") as! Int
            let contactType = (FilterDicArry.object(at: i) as! NSDictionary).value(forKey: "contactType") as! NSNumber
            var fullName = (FilterDicArry.object(at: i) as! NSDictionary).value(forKey: "fullName") as! String
            var designation = (FilterDicArry.object(at: i) as! NSDictionary).value(forKey: "designation") as! String
            if id == 0
            {
                id = 0
            }
            if OrganizatioName == ""
            {
                OrganizatioName=fullName
            }
            if type == ""
            {
                type=designation
                
            }
            if imgPro == ""
            {
            }
            if fullName == ""
            {
                fullName=OrganizatioName
            }
            if designation == ""
            {
                designation=type
            }
           // if isUser == false
           // {
           //     isUser = false
           // }
           // else if isUser == true
           
           // {
           //     isUser = true
           // }
           // else
           // {
            //}
            print("ID :: ",id,"name :: ",OrganizatioName,"type ::",type,"imgPro ::",imgPro,"isUser :: ",contactType)
            modelAry.append(FIlterModel(OrgName: OrganizatioName, OrgType: type, User: contactType, IDN: String(id), ProfileLogo: imgPro,ProfileLogoID: String(imgProID), fullName: fullName, designation: designation))
        }

        return modelAry
    }
}
