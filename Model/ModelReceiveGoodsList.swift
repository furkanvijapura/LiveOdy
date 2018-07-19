//
//  ModelReceiveGoodsList.swift
//  Odin_App_Project_Swift
//
//  Created by Sunil Yadav on 05/02/18.
//  Copyright © 2018 discussolutions. All rights reserved.
//

import UIKit
var ReceiveGoodsDicData: NSArray = NSArray()
var ReceiveGoodsData = [ModelReceiveGoodsList]()
var ReceiveGoodsFilterData = [ModelReceiveGoodsList]()

class ModelReceiveGoodsList: NSObject {
    var id : String = ""
    var sellerOrganizationId : String = ""
    var sellerOrganizationName :  String = ""
    var buyerOrganizationId : String = ""
    var buyerOrganizationName : String = ""
    var buyerWarehouseId : String = ""
    var buyerWarehouseName : String = ""
    var tReceiveId : String = ""
    var createdDate : String = ""
    var saleOrderNo : String = ""
    var totalAmount : String = ""
    var buyerLogoId : String = ""
    var buyerLogoName : String = ""
    var buyerContentType : String = ""
    var currencySymbol : String = ""

    
    init(id:String,sellerOrganizationId:String,sellerOrganizationName:String,buyerOrganizationId:String,buyerOrganizationName:String,buyerWarehouseId:String,buyerWarehouseName:String,tReceiveId:String,createdDate:String,saleOrderNo:String,totalAmount:String,buyerLogoId:String,buyerLogoName:String,buyerContentType:String,currencySymbol:String) {
        
        self.id = id
        self.sellerOrganizationId = sellerOrganizationId
        self.sellerOrganizationName = sellerOrganizationName
        self.buyerOrganizationId = buyerOrganizationId
        self.buyerOrganizationName = buyerOrganizationName
        self.buyerWarehouseId = buyerWarehouseId
        self.buyerWarehouseName = buyerWarehouseName
        self.tReceiveId = tReceiveId
        self.createdDate = createdDate
        self.saleOrderNo = saleOrderNo
        self.totalAmount = totalAmount
        self.buyerLogoId = buyerLogoId
        self.buyerLogoName = buyerLogoName
        self.buyerContentType = buyerContentType
        self.currencySymbol = currencySymbol

    }
    class func generateReceiveGoodArray() -> [ModelReceiveGoodsList]{
        var ModelReceiveGood = [ModelReceiveGoodsList]()
        for i in 0..<ReceiveGoodsDicData.count
        {
            let id = (ReceiveGoodsDicData.object(at: i) as! NSDictionary).value(forKey: "id") as! Int
            let sellerOrganizationId = (ReceiveGoodsDicData.object(at: i) as! NSDictionary).value(forKey: "sellerOrganizationId") as! Int
            let sellerOrganizationName = (ReceiveGoodsDicData.object(at: i) as! NSDictionary).value(forKey: "sellerOrganizationName") as! String
            let buyerOrganizationId = (ReceiveGoodsDicData.object(at: i) as! NSDictionary).value(forKey: "buyerOrganizationId") as! Int
            let buyerOrganizationName = (ReceiveGoodsDicData.object(at: i) as! NSDictionary).value(forKey: "buyerOrganizationName") as! String
            let buyerWarehouseId = (ReceiveGoodsDicData.object(at: i) as! NSDictionary).value(forKey: "buyerWarehouseId") as! Int
            let buyerWarehouseName = (ReceiveGoodsDicData.object(at: i) as! NSDictionary).value(forKey: "buyerWarehouseName") as! String
            let tReceiveId = (ReceiveGoodsDicData.object(at: i) as! NSDictionary).value(forKey: "tReceiveId") as! String
            let createdDate = (ReceiveGoodsDicData.object(at: i) as! NSDictionary).value(forKey: "createdDate") as! String
            let saleOrderNo = (ReceiveGoodsDicData.object(at: i) as! NSDictionary).value(forKey: "saleOrderNo") as! String
            let totalAmount = (ReceiveGoodsDicData.object(at: i) as! NSDictionary).value(forKey: "totalAmount") as! Double
            let buyerLogoId = (ReceiveGoodsDicData.object(at: i) as! NSDictionary).value(forKey: "buyerLogoId") as! Int
            let buyerLogoName = (ReceiveGoodsDicData.object(at: i) as! NSDictionary).value(forKey: "buyerLogoName") as! String
            let buyerContentType = (ReceiveGoodsDicData.object(at: i) as! NSDictionary).value(forKey: "buyerContentType") as! String
            let currencySymbol = (ReceiveGoodsDicData.object(at: i) as! NSDictionary).value(forKey: "currencySymbol") as! String

            ModelReceiveGood.append(ModelReceiveGoodsList(id: String(id), sellerOrganizationId: String(sellerOrganizationId), sellerOrganizationName: sellerOrganizationName, buyerOrganizationId:String(buyerOrganizationId), buyerOrganizationName: buyerOrganizationName,buyerWarehouseId: String(buyerWarehouseId),buyerWarehouseName: buyerWarehouseName,tReceiveId: tReceiveId,createdDate: createdDate,saleOrderNo: saleOrderNo,totalAmount: String(totalAmount),buyerLogoId: String(buyerLogoId),buyerLogoName: buyerLogoName,buyerContentType: buyerContentType,currencySymbol: currencySymbol))
        }
        return ModelReceiveGood
    }


}
