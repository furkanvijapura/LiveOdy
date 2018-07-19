//
//  SOModel_List.swift
//  Odin_App_Project_Swift
//
//  Created by discusit on 09/01/18.
//  Copyright © 2018 discussolutions. All rights reserved.
//

import UIKit
var SOListData = [SOModel_List]()
var SOFilterData = [SOModel_List]()
var SOMainArray:NSArray = NSArray()
class SOModel_List: NSObject {
    
    var id:String = ""
    var saleOrderNumber:String = ""
    var organizationName:String = ""
    var statusId:String = ""
    var status:String = ""
    var saleTypeId:String = ""
    var saleTypeName:String = ""
    var total:String = ""
    var saleDateStr:String = ""
    var fromOrgId:String = ""
    var fromOrgName:String = ""
    var organizationId:String = ""
    var creatorName:String = ""
    var currencySymbol:String = ""
    var buyerLogoId:String = ""
    var buyerLogoName:String = ""
    var buyerContentType:String = ""
    
    init(id:String,saleOrderNumber:String, organizationName:String,statusId:String,status:String,saleTypeId:String,saleTypeName:String,total:String,saleDateStr:String,fromOrgId:String,fromOrgName:String,organizationId:String,creatorName:String,currencySymbol:String,buyerLogoId:String,buyerLogoName:String,buyerContentType:String) {
        
        self.id = id
        self.saleOrderNumber = saleOrderNumber
        self.organizationName = organizationName
        self.statusId = statusId
        self.status = status
        self.saleTypeId = saleTypeId
        self.saleTypeName = saleTypeName
        self.total = total
        self.saleDateStr = saleDateStr
        self.fromOrgId = fromOrgId
        self.fromOrgName = fromOrgName
        self.organizationId = organizationId
        self.creatorName = creatorName
        self.currencySymbol=currencySymbol
        self.buyerLogoId = buyerLogoId
        self.buyerLogoName = buyerLogoName
        self.buyerContentType = buyerContentType
        
    }
    
    class func GenrateSOModelData() -> [SOModel_List]
    {
        var SOReloadData = [SOModel_List]()
        
        for i in 0..<SOMainArray.count
        {
            
            let id = (SOMainArray.object(at: i) as! NSDictionary).value(forKey: "id") as! Int
            let saleOrderNumber = (SOMainArray.object(at: i) as! NSDictionary).value(forKey: "saleOrderNumber") as! String
            let organizationName = (SOMainArray.object(at: i) as! NSDictionary).value(forKey: "organizationName") as! String
            let statusId = (SOMainArray.object(at: i) as! NSDictionary).value(forKey: "statusId") as! Int
            let status = (SOMainArray.object(at: i) as! NSDictionary).value(forKey: "status") as! String
            let saleTypeId = (SOMainArray.object(at: i) as! NSDictionary).value(forKey: "saleTypeId") as! Int
            let saleTypeName = (SOMainArray.object(at: i) as! NSDictionary).value(forKey: "saleTypeName") as! String
            let total = (SOMainArray.object(at: i) as! NSDictionary).value(forKey: "total") as! Double
            let saleDateStr = (SOMainArray.object(at: i) as! NSDictionary).value(forKey: "saleDateStr") as! String
            let fromOrgId = (SOMainArray.object(at: i) as! NSDictionary).value(forKey: "fromOrgId") as! Int
            let fromOrgName = (SOMainArray.object(at: i) as! NSDictionary).value(forKey: "fromOrgName") as! String
            let organizationId = (SOMainArray.object(at: i) as! NSDictionary).value(forKey: "organizationId") as! Int
            let creatorName = (SOMainArray.object(at: i) as! NSDictionary).value(forKey: "creatorName") as! String
            let buyerLogoId = (SOMainArray.object(at: i) as! NSDictionary).value(forKey: "buyerLogoId") as! Int
            let buyerLogoName = (SOMainArray.object(at: i) as! NSDictionary).value(forKey: "buyerLogoName") as! String
            let buyerContentType = (SOMainArray.object(at: i) as! NSDictionary).value(forKey: "buyerContentType") as! String
            let currencySymbol = (SOMainArray.object(at: i) as! NSDictionary).value(forKey: "currencySymbol") as! String
            
            SOReloadData.append(SOModel_List(id: String(id), saleOrderNumber: saleOrderNumber, organizationName: organizationName, statusId: String(statusId), status: status, saleTypeId: String(saleTypeId), saleTypeName: saleTypeName, total: String(total), saleDateStr: saleDateStr, fromOrgId: String(fromOrgId), fromOrgName: fromOrgName, organizationId: String(organizationId), creatorName: creatorName,currencySymbol: currencySymbol,buyerLogoId: String(buyerLogoId), buyerLogoName: buyerLogoName, buyerContentType: buyerContentType))
        }
        // tableeeORListScreen.reloadData()
        return SOReloadData
    }
}


//Mark : SO Select Product Model
var SOSelectProductData = [SOSelectProductModel]()
var SOSelectProductDataFilter = [SOSelectProductModel]()

class SOSelectProductModel: NSObject {
    var id = Int64()
    var name = String()
    var PriBpri = Double()
    var skuuu = String()
    var MeasermentName = String()
    var CategoryName = String()
    var CurrencySymbol = String()
    var Quntity = Double()
    var TotalAmount = Double()
    var Discount = Double()
    init(id:Int64,name:String,PriBpri:Double,sku:String,measermentName:String,categoryName:String,currencySymbol:String,quantity:Double,totalamount:Double, Discount:Double) {
        self.id = id
        self.name = name
        self.PriBpri = PriBpri
        self.skuuu = sku
        self.CategoryName = categoryName
        self.MeasermentName = measermentName
        self.CurrencySymbol = currencySymbol
        self.Quntity = quantity
        self.TotalAmount = totalamount
        self.Discount = Discount
    }
    
    class func GenrateSOSelectProductArrayyy() -> [SOSelectProductModel]{
        var modelAry = [SOSelectProductModel]()
        let proid : NSMutableArray = NSMutableArray()
        for f in 0..<LinkPendinOR.LinkedFinaleArray.count
        {
            let subValue : NSDictionary = LinkPendinOR.ProductMargArray[f] as! NSDictionary
            let id = subValue.value(forKey: "proId") as! Int64
            proid.add(id)
            print(proid)
        }
        
        for i in 0..<SOProduct.ProductListArray.count
        {
            var proID = Int64()
            var PriBookPri = Double()
            var ProName = String()
            var skuuu = String()
            var Measer  = String()
            var C_Name = String()
            var CurencySymboal = String()
            var Quntity = Double()
            var TotalAmountt = Double()
            var Discounttt = Double()
            
            proID = (SOProduct.ProductListArray.object(at: i) as! NSDictionary).value(forKey: "productId") as! Int64
            if  LinkPendinOR.LinkedFinaleArray.count == 0
            {
                
                PriBookPri = (SOProduct.ProductListArray.object(at: i) as! NSDictionary).value(forKey: "basicPrices") as! Double
                ProName = (SOProduct.ProductListArray.object(at: i) as! NSDictionary).value(forKey: "productName") as! String
                if ProName == ""{ ProName = "NA"}
                skuuu = (SOProduct.ProductListArray.object(at: i) as! NSDictionary).value(forKey: "sku") as! String
                if skuuu == "" {skuuu = "NA"}
                Measer = (SOProduct.ProductListArray.object(at: i) as! NSDictionary).value(forKey: "measurementName") as! String
                if Measer == "" { Measer = "NA"}
                C_Name = (SOProduct.ProductListArray.object(at: i) as! NSDictionary).value(forKey: "productCategoryName") as! String
                if C_Name == ""{ C_Name = "NA"}
                CurencySymboal = (SOProduct.ProductListArray.object(at: i) as! NSDictionary).value(forKey: "currencySymbol") as! String
                if CurencySymboal == ""{  CurencySymboal = "NA" }
                Quntity = 0.00
                TotalAmountt = 0.00
                Discounttt = 0.00
            }
            else
            {
                for x in 0..<LinkPendinOR.LinkedFinaleArray.count
                {
                    let subValue  = LinkPendinOR.LinkedFinaleArray[x] as! NSDictionary
                    let linkedProID = subValue.value(forKey: "productId") as! Int64
                    var proiddd = Int64()
                    if proid.count != 0{
                        proiddd  = proid[x] as! Int64
                    }
                    if proID  == proiddd
                    {
                        ProName = subValue.value(forKey: "productName") as! String
                        if ProName == ""{ ProName = "NA"}
                        SOProduct.ProductIDSelect.add(linkedProID)
                        SOProduct.ProductSelectName.add(ProName)
                        PriBookPri = subValue.value(forKey: "basicPrices") as! Double
                        
                        skuuu = (SOProduct.ProductListArray.object(at: i) as! NSDictionary).value(forKey: "sku") as! String
                        if skuuu == "" {skuuu = "NA"}
                        if let maser : String = subValue.value(forKey: "uom") as? String {
                            Measer = maser
                        }else{ Measer = ""}
                        C_Name = subValue.value(forKey: "productCategoryName") as! String
                        if C_Name == ""{ C_Name = "NA"}
                        CurencySymboal = subValue.value(forKey: "currencySymbol") as! String
                        if CurencySymboal == "" {  CurencySymboal = " " }
                        Quntity = subValue.value(forKey: "quantity") as! Double
                        let totl = subValue.value(forKey: "productTotal") as! Double
                        TotalAmountt = Double(String(format: "%.2f", totl))!
                        if let Disc = subValue.value(forKey: "discountAmount") as? Double
                        {
                            Discounttt = Double(String(format: "%.2f", Disc) )!
                        }else{
                            Discounttt = 0.00
                        }
                    }
                    else
                    {
                        if SOProduct.ProductIDSelect.contains(proID){
                            
                        }
                        else
                        {
                            PriBookPri = (SOProduct.ProductListArray.object(at: i) as! NSDictionary).value(forKey: "basicPrices") as! Double
                            ProName = (SOProduct.ProductListArray.object(at: i) as! NSDictionary).value(forKey: "productName") as! String
                            if ProName == ""{ ProName = "NA"}
                            skuuu = (SOProduct.ProductListArray.object(at: i) as! NSDictionary).value(forKey: "sku") as! String
                            if skuuu == "" {skuuu = "NA"}
                            Measer = (SOProduct.ProductListArray.object(at: i) as! NSDictionary).value(forKey: "measurementName") as! String
                            if Measer == "" { Measer = ""}
                            C_Name = (SOProduct.ProductListArray.object(at: i) as! NSDictionary).value(forKey: "productCategoryName") as! String
                            if C_Name == ""{ C_Name = "NA"}
                            CurencySymboal = (SOProduct.ProductListArray.object(at: i) as! NSDictionary).value(forKey: "currencySymbol") as! String
                            if CurencySymboal == ""{  CurencySymboal = "NA" }
                            Quntity = 0.0
                            TotalAmountt = 0.0
                            Discounttt = 0.00
                        }
                    }
                }
            }
            modelAry.append(SOSelectProductModel(id: proID, name: ProName, PriBpri: PriBookPri, sku: skuuu, measermentName: Measer , categoryName: C_Name, currencySymbol: CurencySymboal, quantity: Quntity, totalamount: TotalAmountt, Discount: Discounttt))
        }
        return modelAry
    }
}

//MARK : Rejection List Model for SO Profile

class SOProfileRejecModel: NSObject {
    // SO Profile ID'S
    static var SOProfileID = NSNumber()
    static var SOSalsetypeID = NSNumber()
    
    //Selected Value for Rejection List
    static var IDRejection = String()
    static var valueRejetion = String()
    //Model array
    static var SORejectionSelectData = [SOProfileRejecModel]()
    static var SORejectionSelectDataFilter = [SOProfileRejecModel]()
    //API Data
    static var RejectionData = NSArray()
    
    var value: String = ""
    var id: String = ""
    init(StatusId:String,StatusValue:String)
    {
        self.value = StatusValue
        self.id = StatusId
    }
    class func generateSORejectionList() -> [SOProfileRejecModel]{
        var modelSoFilter = [SOProfileRejecModel]()
        for i in 0..<RejectionData.count
        {
            let rejectionID = (RejectionData.object(at: i) as! NSDictionary).value(forKey: "id") as! Int
            
            let reson =  (RejectionData.object(at: i) as! NSDictionary).value(forKey: "value") as! String
            
            print("ID :: ",rejectionID,"name :: ",reson)
            
            modelSoFilter.append(SOProfileRejecModel(StatusId: String(rejectionID), StatusValue: reson))
        }
        return modelSoFilter
    }
}
