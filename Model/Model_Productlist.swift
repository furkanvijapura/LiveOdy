//
//  Model.swift
//  SearchBar
//
//  Created by Shinkangsan on 12/20/16.
//  Copyright © 2016 Sheldon. All rights reserved.
//

import UIKit
var DicDataProductList:NSArray = NSArray()
var ModelProductlist1 = [ModelProductlist]()
var ModelProductlistfilter = [ModelProductlist]()

class ModelProductlist: NSObject {
    var OrganizationName: String = ""
    var OrganizationType: String = ""
    var ID: String = ""
    var ProLogo : String = ""
    var ProLogoID : String = ""
//    var designation : String = ""

    init(OrgName:String,OrgType:String,IDN:String,ProfileLogo:String,ProfileLogoID:String) {
        self.OrganizationName = OrgName
        self.OrganizationType = OrgType
//        self.isUser = User
        self.ID = IDN
        self.ProLogo = ProfileLogo
        self.ProLogoID = ProfileLogoID

    }
    class func generateModelArray() -> [ModelProductlist]{
        var modelAry = [ModelProductlist]()
        for i in 0..<DicDataProductList.count
        {
            let id = (DicDataProductList.object(at: i) as! NSDictionary).value(forKey: "id") as! Int
            let OrganizatioName =  (DicDataProductList.object(at: i) as! NSDictionary).value(forKey: "productName") as! String
            let type = (DicDataProductList.object(at: i) as! NSDictionary).value(forKey: "productCategoryName") as! String
            let imgPro = (DicDataProductList.object(at: i) as! NSDictionary).value(forKey: "logoName") as! String
            let imgProID = (DicDataProductList.object(at: i) as! NSDictionary).value(forKey: "logoId") as! Int

           

//            if id == 0
//            {
//                id = 0
//            }
//            if OrganizatioName == ""
//            {
//                OrganizatioName=fullName
//            }
//            if type == ""
//            {
//                type=designation
//                
//            }
//            if imgPro == ""
//            {
//            }
//            if fullName == ""
//            {
//                fullName=OrganizatioName
//            }
//            if designation == ""
//            {
//                designation=type
//            }
//            if isUser == false
//            {
//                isUser = false
//            }
//            else if isUser == true
//            {
//                isUser = true
//            }
//            else
//            {
//            }
            print("ID :: ",id,"name :: ",OrganizatioName,"type ::",type)
            modelAry.append(ModelProductlist(OrgName: OrganizatioName,OrgType: type, IDN: String(id), ProfileLogo:imgPro,ProfileLogoID:String(imgProID)))
        }

        return modelAry
    }
}

class ORSelectProductList: NSObject {
    
    var OrganizationName: String = ""
    var OrganizationType: String = ""
    var ID: String = ""
    var ProLogo : String = ""
    //    var fullName : String = ""
    //    var designation : String = ""
    
    init(OrgName:String,OrgType:String,IDN:String) {
        self.OrganizationName = OrgName
        self.OrganizationType = OrgType
        //        self.isUser = User
        self.ID = IDN
        //        self.ProLogo = ProfileLogo
    }
    class func generateModelArray() -> [ModelProductlist]{
        var modelAry = [ModelProductlist]()
        for i in 0..<DicDataProductList.count
        {
            let id = (DicDataProductList.object(at: i) as! NSDictionary).value(forKey: "id") as! Int
            let OrganizatioName =  (DicDataProductList.object(at: i) as! NSDictionary).value(forKey: "productName") as! String
            let type = (DicDataProductList.object(at: i) as! NSDictionary).value(forKey: "productCategoryName") as! String
             let imgPro = (DicDataProductList.object(at: i) as! NSDictionary).value(forKey: "logoName") as! String
            let imgProID = (DicDataProductList.object(at: i) as! NSDictionary).value(forKey: "logoId") as! Int
            print("ID :: ",id,"name :: ",OrganizatioName,"type ::",type)
            modelAry.append(ModelProductlist(OrgName: OrganizatioName,OrgType: type, IDN: String(id), ProfileLogo:imgPro,ProfileLogoID:String(imgProID)))
        }
        
        return modelAry
    }
}

var ORBuyerNameList:NSArray = NSArray()
class ORSelectBuyerListModel: NSObject {
    var value: String = ""
    var type: String = ""
    var id: String = ""
    init(buyerName:String,buyerType:String,orBuyerId:String) {
        self.value = buyerName
        self.type = buyerType
        self.id = orBuyerId
    }
    class func generateORBuyerModelArray() -> [ORSelectBuyerListModel]{
        var modelBuyer = [ORSelectBuyerListModel]()
        for i in 0..<ORBuyerNameList.count
        {
            let buyerid = (ORBuyerNameList.object(at: i) as! NSDictionary).value(forKey: "id") as! Int
            let BuyerName =  (ORBuyerNameList.object(at: i) as! NSDictionary).value(forKey: "value") as! String
            let Buyertype = (ORBuyerNameList.object(at: i) as! NSDictionary).value(forKey: "type") as! Int
            print("ID :: ",buyerid,"name :: ",BuyerName,"type ::",Buyertype)
            modelBuyer.append(ORSelectBuyerListModel(buyerName: BuyerName, buyerType: String(Buyertype), orBuyerId: String(buyerid)))
        }
        return modelBuyer
    }
}

var ORSellerNameList:NSArray = NSArray()
class ORSelectSellerListModel: NSObject {
    var value: String = ""
    var type: String = ""
    var id: String = ""
    init(buyerName:String,buyerType:String,orBuyerId:String) {
        self.value = buyerName
        self.type = buyerType
        self.id = orBuyerId
    }
    class func generateORSellerModelArray() -> [ORSelectSellerListModel]{
        var modelSeller = [ORSelectSellerListModel]()
        for i in 0..<ORSellerNameList.count
        {
            let buyerid = (ORSellerNameList.object(at: i) as! NSDictionary).value(forKey: "id") as! Int
            let BuyerName =  (ORSellerNameList.object(at: i) as! NSDictionary).value(forKey: "value") as! String
            let Buyertype = (ORSellerNameList.object(at: i) as! NSDictionary).value(forKey: "type") as! Int
            print("ID :: ",buyerid,"name :: ",BuyerName,"type ::",Buyertype)
            modelSeller.append(ORSelectSellerListModel(buyerName: BuyerName, buyerType: String(Buyertype), orBuyerId: String(buyerid)))
        }
        return modelSeller
    }
}
var ORPricebookList:NSArray = NSArray()
class ORProcebookListModel: NSObject {
    var value: String = ""
    var id: String = ""
    init(buyerName:String,orBuyerId:String) {
        self.value = buyerName
        self.id = orBuyerId
    }
    class func generateORPricebookModelArray() -> [ORProcebookListModel]{
        var modelSeller = [ORProcebookListModel]()
        for i in 0..<ORPricebookList.count
        {
            let buyerid = (ORPricebookList.object(at: i) as! NSDictionary).value(forKey: "id") as! Int
            let BuyerName =  (ORPricebookList.object(at: i) as! NSDictionary).value(forKey: "value") as! String
            print("ID :: ",buyerid,"name :: ",BuyerName)
            modelSeller.append(ORProcebookListModel(buyerName: BuyerName, orBuyerId: String(buyerid)))
        }
        return modelSeller
    }
}

//================For SO API Calling==========================

var SOBuyerNameList:NSArray = NSArray()
class SOSelectBuyerListModel: NSObject {
    var value: String = ""
    var type: String = ""
    var id: String = ""
    init(buyerName:String,buyerType:String,orBuyerId:String) {
        self.value = buyerName
        self.type = buyerType
        self.id = orBuyerId
    }
    class func generateSOBuyerModelArray() -> [SOSelectBuyerListModel]{
        var modelBuyer = [SOSelectBuyerListModel]()
        for i in 0..<SOBuyerNameList.count
        {
            let buyerid = (SOBuyerNameList.object(at: i) as! NSDictionary).value(forKey: "id") as! Int
            let BuyerName =  (SOBuyerNameList.object(at: i) as! NSDictionary).value(forKey: "value") as! String
            let Buyertype = (SOBuyerNameList.object(at: i) as! NSDictionary).value(forKey: "type") as! Int
            print("ID :: ",buyerid,"name :: ",BuyerName,"type ::",Buyertype)
            modelBuyer.append(SOSelectBuyerListModel(buyerName: BuyerName, buyerType: String(Buyertype), orBuyerId: String(buyerid)))
        }
        return modelBuyer
    }
}

var SOSellerNameList:NSArray = NSArray()
class SOSelectSellerListModel: NSObject {
    var value: String = ""
    var type: String = ""
    var id: String = ""
    init(buyerName:String,buyerType:String,orBuyerId:String) {
        self.value = buyerName
        self.type = buyerType
        self.id = orBuyerId
    }
    class func generateSOSellerModelArray() -> [SOSelectSellerListModel]{
        var modelSeller = [SOSelectSellerListModel]()
        for i in 0..<SOSellerNameList.count
        {
            let buyerid = (SOSellerNameList.object(at: i) as! NSDictionary).value(forKey: "id") as! Int
            let BuyerName =  (SOSellerNameList.object(at: i) as! NSDictionary).value(forKey: "value") as! String
            let Buyertype = (SOSellerNameList.object(at: i) as! NSDictionary).value(forKey: "type") as! Int
            print("ID :: ",buyerid,"name :: ",BuyerName,"type ::",Buyertype)
            modelSeller.append(SOSelectSellerListModel(buyerName: BuyerName, buyerType: String(Buyertype), orBuyerId: String(buyerid)))
        }
        return modelSeller
    }
}
var SOPricebookListarr:NSArray = NSArray()
class SOProcebookListModel: NSObject {
    var value: String = ""
    var id: String = ""
    init(buyerName:String,orBuyerId:String) {
        self.value = buyerName
        self.id = orBuyerId
    }
    class func generateSOPricebookModelArray() -> [SOProcebookListModel]{
        var modelSeller = [SOProcebookListModel]()
        for i in 0..<SOPricebookListarr.count
        {
            let buyerid = (SOPricebookListarr.object(at: i) as! NSDictionary).value(forKey: "id") as! Int
            let BuyerName =  (SOPricebookListarr.object(at: i) as! NSDictionary).value(forKey: "value") as! String
            print("ID :: ",buyerid,"name :: ",BuyerName)
            modelSeller.append(SOProcebookListModel(buyerName: BuyerName, orBuyerId: String(buyerid)))
        }
        return modelSeller
    }
}


var SOApproverListarr:NSArray = NSArray()
class SOApproverListModel: NSObject {
    var value: String = ""
    var id: String = ""
    init(buyerName:String,orBuyerId:String) {
        self.value = buyerName
        self.id = orBuyerId
    }
    class func generateSOApproverModelArray() -> [SOApproverListModel]{
        var modelSeller = [SOApproverListModel]()
        for i in 0..<SOApproverListarr.count
        {
            let buyerid = (SOApproverListarr.object(at: i) as! NSDictionary).value(forKey: "id") as! Int
            let BuyerName =  (SOApproverListarr.object(at: i) as! NSDictionary).value(forKey: "value") as! String
            print("ID :: ",buyerid,"name :: ",BuyerName)
            modelSeller.append(SOApproverListModel(buyerName: BuyerName, orBuyerId: String(buyerid)))
        }
        return modelSeller
    }
}

var SOPendingListarr:NSArray = NSArray()
class SOPendingListModel: NSObject {
    var value: String = ""
    var id: String = ""
    init(buyerName:String,orBuyerId:String) {
        self.value = buyerName
        self.id = orBuyerId
    }
    class func generateSOApproverModelArray() -> [SOPendingListModel]{
        var modelSeller = [SOPendingListModel]()
        for i in 0..<SOPendingListarr.count
        {
            let buyerid = (SOPendingListarr.object(at: i) as! NSDictionary).value(forKey: "id") as! Int
            let BuyerName =  (SOPendingListarr.object(at: i) as! NSDictionary).value(forKey: "orNumber") as! String
            print("ID :: ",buyerid,"name :: ",BuyerName)
            modelSeller.append(SOPendingListModel(buyerName: BuyerName, orBuyerId: String(buyerid)))
        }
        return modelSeller
    }
}

//===============For OR Filter Model==============

var ORFilterBuyerNameList:NSArray = NSArray()
class ORFilterSelectBuyerListModel: NSObject {
    var value: String = ""
    var type: String = ""
    var id: String = ""
    init(buyerName:String,buyerType:String,orBuyerId:String) {
        self.value = buyerName
        self.type = buyerType
        self.id = orBuyerId
    }
    class func generateORBuyerModelArray() -> [ORFilterSelectBuyerListModel]{
        var modelBuyer = [ORFilterSelectBuyerListModel]()
        for i in 0..<ORFilterBuyerNameList.count
        {
            let buyerid = (ORFilterBuyerNameList.object(at: i) as! NSDictionary).value(forKey: "id") as! Int
            let BuyerName =  (ORFilterBuyerNameList.object(at: i) as! NSDictionary).value(forKey: "name") as! String
            let Buyertype = (ORFilterBuyerNameList.object(at: i) as! NSDictionary).value(forKey: "personId") as! Int
            print("ID :: ",buyerid,"name :: ",BuyerName,"type ::",Buyertype)
            modelBuyer.append(ORFilterSelectBuyerListModel(buyerName: BuyerName, buyerType: String(Buyertype), orBuyerId: String(buyerid)))
        }
        return modelBuyer
    }
}


var ORFilterOrgList:NSArray = NSArray()
class ORFilterOrgListModel: NSObject {
    var value: String = ""
    var type: String = ""
    var id: String = ""
    init(buyerName:String,buyerType:String,orBuyerId:String) {
        self.value = buyerName
        self.type = buyerType
        self.id = orBuyerId
    }
    class func generateORBuyerModelArray() -> [ORFilterOrgListModel]{
        var modelBuyer = [ORFilterOrgListModel]()
        for i in 0..<ORFilterOrgList.count
        {
            let buyerid = (ORFilterOrgList.object(at: i) as! NSDictionary).value(forKey: "id") as! Int
            let BuyerName =  (ORFilterOrgList.object(at: i) as! NSDictionary).value(forKey: "value") as! String
            let Buyertype = (ORFilterOrgList.object(at: i) as! NSDictionary).value(forKey: "type") as! Int
            print("ID :: ",buyerid,"name :: ",BuyerName,"type ::",Buyertype)
            modelBuyer.append(ORFilterOrgListModel(buyerName: BuyerName, buyerType: String(Buyertype), orBuyerId: String(buyerid)))
        }
        return modelBuyer
    }
}

var ORFilterStatusList:NSArray = NSArray()
class ORFilterStatusListModel: NSObject {
    var value: String = ""
    var id: String = ""
    init(buyerName:String,orBuyerId:String) {
        self.value = buyerName
        self.id = orBuyerId
    }
    class func generateORBuyerModelArray() -> [ORFilterStatusListModel]{
        var modelBuyer = [ORFilterStatusListModel]()
        for i in 0..<ORFilterStatusList.count
        {
            let buyerid = (ORFilterStatusList.object(at: i) as! NSDictionary).value(forKey: "id") as! Int
            let BuyerName =  (ORFilterStatusList.object(at: i) as! NSDictionary).value(forKey: "value") as! String
            print("ID :: ",buyerid,"name :: ")
            modelBuyer.append(ORFilterStatusListModel(buyerName: BuyerName, orBuyerId: String(buyerid)))
        }
        return modelBuyer
    }
}

var ORFilterSalesList:NSArray = NSArray()
class ORFilterSalesListModel: NSObject {
    var value: String = ""
    var id: String = ""
    init(buyerName:String,orBuyerId:String) {
        self.value = buyerName
        self.id = orBuyerId
    }
    class func generateORBuyerModelArray() -> [ORFilterSalesListModel]{
        var modelBuyer = [ORFilterSalesListModel]()
        for i in 0..<ORFilterSalesList.count
        {
            let buyerid = (ORFilterSalesList.object(at: i) as! NSDictionary).value(forKey: "id") as! Int
            let BuyerName =  (ORFilterSalesList.object(at: i) as! NSDictionary).value(forKey: "value") as! String
            print("ID :: ",buyerid,"name :: ",BuyerName)
            modelBuyer.append(ORFilterSalesListModel(buyerName: BuyerName,orBuyerId: String(buyerid)))
        }
        return modelBuyer
    }
}

//=================================================





