//
//  AllUserInfo.swift
//  DemoCheckList
//
//  Created by i-Phone14 on 11/10/16.
//  Copyright © 2016 Trainee2. All rights reserved.
//

import UIKit

class AllUserInfo: NSObject
{
    var sites=NSArray()
    var site=NSNumber()
    var Token=String()
    var UserId=NSNumber()
    var permision=NSDictionary()
    var userName=NSString()
    var configurations=NSDictionary()
    var roleName=NSString()
    var cashFlowconfigurations=NSDictionary()
    var logoUrl=NSString()
    var profilelogolink=NSString()
    
    var orgName = NSString()
    var companyId = NSNumber()
    var companyActive = Bool()
    var companyFavorites = Bool()
    var companyEmails = NSArray()
    var companyContacts = NSArray()
    var companyContact = NSString()
    var contactPerson = NSString()
    var parentOrgName = NSString()
    var organizationMetadata = NSString()
    var parentId = NSNumber()
    var relationId = NSNumber()
    var webSide = NSString()
    var sameAsBillingAddressFlag = Bool()
    var vatTinNo = NSString()
    var cstNo = NSString()
    var personList = NSArray()
    var typeId = NSNumber()
    var typeName = NSString()
    var clientCode = NSString()
    var relationTypeName = NSString()
    var logoName = String()
    var logoId = NSNumber()
    var tagMasterProxys = NSArray()
    //    var userId:Integer=0
    func setUserInfo(dicInfo:NSDictionary)
    {
//        self.emailAddress=dicInfo .value(forKey: "emailAddress") as! String
//        self.fullName=dicInfo .value(forKey: "fullName") as! String
//        self.mobileNo=dicInfo .value(forKey: "mobileNo") as! String
//        self.userId = dicInfo.value(forKey: "userId") as?Int
    }
    func LoginInfo(dicInfo:NSDictionary)
    {
        self.sites = dicInfo.value(forKey: Constant.ksites)as! NSArray
        self.site = dicInfo.value(forKey: Constant.Ksite)as! NSNumber
        self.Token = dicInfo.value(forKey: Constant.ktoken)as! String
        self.UserId = dicInfo.value(forKey: Constant.kUserId)as! NSNumber
        self.permision = dicInfo.value(forKey: Constant.kpermissions)as! NSDictionary
        self.userName = dicInfo.value(forKey: Constant.kuserName)as! NSString
        self.configurations = dicInfo.value(forKey: Constant.kconfigurations)as! NSDictionary
        self.roleName = dicInfo.value(forKey: Constant.kroleName)as! NSString
        self.cashFlowconfigurations = dicInfo.value(forKey: Constant.kcashflowConfigurations)as! NSDictionary
        self.logoUrl = dicInfo.value(forKey: Constant.KlogoUrl)as! NSString
        self.profilelogolink = dicInfo.value(forKey: Constant.kprofileLogoLink)as! NSString
    }
    func CompanyProfileInfo(dicInfo:NSDictionary)
    {
        self.orgName = dicInfo.value(forKey: "organizationName")as! NSString
        self.companyId = dicInfo.value(forKey: "id")as! NSNumber
        self.companyActive = dicInfo.value(forKey: "isactive")as! Bool
        self.companyFavorites = dicInfo.value(forKey: "favorites")as! Bool
        self.companyEmails = dicInfo.value(forKey: "emails")as! NSArray
        self.companyContacts = dicInfo.value(forKey: "contacts")as! NSArray
        //self.companyContact = dicInfo.value(forKey: "contact")as! NSString
        self.contactPerson = dicInfo.value(forKey: "contactPerson")as! NSString
        self.parentOrgName = dicInfo.value(forKey: "parentOrganizationName")as! NSString
        self.organizationMetadata = dicInfo.value(forKey: "organizationMetadata")as! NSString
//        self.parentId = (dicInfo.object(at: 0) as AnyObject) .value(forKey: "parentOrganizationId")as! NSNumber
        self.relationId = dicInfo.value(forKey: "relationTypeId")as! NSNumber
        self.webSide = dicInfo.value(forKey: "webSite")as! NSString
        //self.sameAsBillingAddressFlag = dicInfo.value(forKey: "sameAsBillingAddressFlag")as! Bool
        self.vatTinNo = dicInfo.value(forKey: "vatTinNo")as! NSString
        self.cstNo = dicInfo.value(forKey: "cstNo")as! NSString
       // self.personList = dicInfo.value(forKey: "personList")as! NSArray
        self.typeId = dicInfo.value(forKey: "typeId")as! NSNumber
        self.typeName = dicInfo.value(forKey: "typeName")as! NSString
        self.clientCode = dicInfo.value(forKey: "clientCode")as! NSString
        self.relationTypeName = dicInfo.value(forKey: "relationTypeName")as! NSString
        self.logoName = dicInfo.value(forKey: "logoName")as! String
        self.logoId = dicInfo.value(forKey: "logoId")as! NSNumber
        self.tagMasterProxys = dicInfo.value(forKey: "tagMasterProxys")as! NSArray
    }
}
