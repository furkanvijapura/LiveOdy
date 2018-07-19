//
//  Model.swift
//  SearchBar
//
//  Created by Shinkangsan on 12/20/16.
//  Copyright © 2016 Sheldon. All rights reserved.
//

import UIKit
var DicData:NSArray = NSArray()
var ModelContact = [Model]()
var ModelContactFilterfilter = [Model]()

class Model: NSObject {
    var OrganizationName: String = ""
    var OrganizationType: String = ""
    var contactType: NSNumber
    var ID: String = ""
    var ProLogo : String = ""
    var ProLogoID : String = ""
    var fullName : String = ""
    var designation : String = ""

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
    
    class func generateModelArray() -> [Model]{
        var modelAry = [Model]()
        for i in 0..<DicData.count
        {
            var id = (DicData.object(at: i) as! NSDictionary).value(forKey: "id") as! Int
            var OrganizatioName =  (DicData.object(at: i) as! NSDictionary).value(forKey: "organizationName") as! String
            var type = (DicData.object(at: i) as! NSDictionary).value(forKey: "type") as! String
            let imgPro = (DicData.object(at: i) as! NSDictionary).value(forKey: "logoName") as! String
            let imgProID = (DicData.object(at: i) as! NSDictionary).value(forKey: "logoId") as! Int
            let contactType = (DicData.object(at: i) as! NSDictionary).value(forKey: "contactType") as! NSNumber
            var fullName = (DicData.object(at: i) as! NSDictionary).value(forKey: "fullName") as! String
            var designation = (DicData.object(at: i) as! NSDictionary).value(forKey: "designation") as! String
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
            modelAry.append(Model(OrgName: OrganizatioName, OrgType: type, User: contactType, IDN: String(id), ProfileLogo: imgPro,ProfileLogoID: String(imgProID), fullName: fullName, designation: designation))
        }

        return modelAry
    }
}
